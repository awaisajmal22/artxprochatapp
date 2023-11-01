import 'dart:async';
import 'dart:convert';

import 'package:artxprochatapp/App/Auth/Signup/Model/user_model.dart';
import 'package:artxprochatapp/App/CreatGroup/Model/group_model.dart';
import 'package:artxprochatapp/App/SingleChat/Model/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/files.dart';
import 'package:get/get.dart';

// import '../../AppModule/GroupChatModule/Model/groups_model.dart';
// import '../../AppModule/VoiceChannelModule/Model/channel_name_model.dart';
import '../../RoutesAndBindings/app_routes.dart';
import 'package:http/http.dart' as http;

class FirebaseGroupNotificationServices {
  static String serverToken =
      'AAAAe4QjFhY:APA91bESceVB_NVGA_2MuvgLqKxZZ1RVeLRFBEXSuLbONlKXzMWLeNaNkpFIreCDpjQkXUWl34DcClRCKqpzKbnEJp2B3Ep074Rye5XfevPpse5qTPcaAf2zw22EhSi35_KQQeg721xK';
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future<Map<String, dynamic>> sendAndRetrieveMessage(
      List<String> fcm, String title, String body, String type) async {
    print('///inside send and retrieve message, fcm token $fcm');
    await firebaseMessaging.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);
    print("Here we got ::: ");
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': <String, dynamic>{
            'title': title,
            'body': body,
            'type': type,
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '${Timestamp.now().millisecondsSinceEpoch}',
            'status': 'done'
          },
          'registration_ids': fcm,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    return completer.future;
  }

  static Future saveNotification(Notifications notification, String groupName,
      GroupMessages message) async {
    print('///inside save notification');
    for (var i in message.reciverUid!) {
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(i)
          .collection('Groups')
          .doc(groupName)
          .collection('messages')
          .doc(message.dateTime)
          .collection('notifications')
          .doc(i);
      notification.id = docRef.id;
      notification.senderId = FirebaseAuth.instance.currentUser!.uid;
      notification.createdAt = Timestamp.now();
      print('///inside save notification before set  ${i}');
      await docRef.set(Notifications.toMap(notification));
      print('///inside save notification after set ');
      // if(user.activeStatus==2){
      //   return;
      // }
      if (i == null || i.isEmpty) {
        return;
      }
      // if(user.showNotification==1){
      //
      //   return;
      // }
      print('///inside save notification after set ------------');

      sendAndRetrieveMessage(message.fcmToken!, notification.title!,
          notification.description!, notification.type!);
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> streamUserNotifications(
      String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .get();
  }

  //
}

class FirebaseGroupServices {
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;
  textOnlyAdmin({
    required String groupName,
    required bool textOnlyAdminValue,
    required List<GroupUserModel> members,
    required GroupsModel groupData,
  }) async {
    RxList<GroupUserModel> updatedMembers = <GroupUserModel>[].obs;
    RxList<String> updatedUidList = <String>[].obs;
    updatedUidList.value = groupData.uid!;
    updatedMembers.value = members;

    for (int index = 0; index < updatedMembers.length; index++) {
      if (updatedMembers[index].isAdmin == true) {
        if (!groupData.uid!.contains(FirebaseAuth.instance.currentUser!.uid)) {
          updatedUidList.add(updatedMembers[index].uid!);
        }
        updatedMembers[index] = GroupUserModel(
            email: updatedMembers[index].email,
            fcmToken: updatedMembers[index].fcmToken,
            image: updatedMembers[index].image,
            isAddedToGroup: updatedMembers[index].isAddedToGroup,
            isAdmin: updatedMembers[index].isAdmin,
            textOnlyAdmin: textOnlyAdminValue,
            isOnline: updatedMembers[index].isOnline,
            lastActive: updatedMembers[index].lastActive,
            name: updatedMembers[index].name,
            uid: updatedMembers[index].uid);
      }
    }
    final group = GroupsModel(
      dateTime: groupData.dateTime,
      groupImage: groupData.groupImage,
      groupName: groupData.groupName,
      members: updatedMembers,
      uid: updatedUidList,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Groups")
        .doc(groupName)
        .update(group.toJson());
    for (var user in members) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection("Groups")
          .doc(groupName)
          .update(group.toJson());
    }
  }

  makeAdmin({
    required bool textOnlyAdminValue,
    required String memberUID,
    required List<GroupUserModel> members,
    required GroupsModel groupData,
  }) async {
    RxList<GroupUserModel> updatedMembers = <GroupUserModel>[].obs;
    updatedMembers.value = members;

    RxList<String> updatedUIDS = <String>[].obs;
    updatedUIDS.value = groupData.uid!;
    updatedUIDS.add(memberUID);

    int index =
        updatedMembers.indexWhere((element) => element.uid == memberUID);
    if (index != -1) {
      updatedMembers[index] = GroupUserModel(
          email: updatedMembers[index].email,
          fcmToken: updatedMembers[index].fcmToken,
          image: updatedMembers[index].image,
          isAddedToGroup: updatedMembers[index].isAddedToGroup,
          isAdmin: true,
          textOnlyAdmin: textOnlyAdminValue,
          isOnline: updatedMembers[index].isOnline,
          lastActive: updatedMembers[index].lastActive,
          name: updatedMembers[index].name,
          uid: updatedMembers[index].uid);
    }
    final group = GroupsModel(
      dateTime: groupData.dateTime,
      groupImage: groupData.groupImage,
      groupName: groupData.groupName,
      members: updatedMembers,
      uid: updatedUIDS,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Groups")
        .doc(groupData.groupName)
        .update(group.toJson());
    for (var user in members) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection("Groups")
          .doc(groupData.groupName)
          .update(group.toJson());
    }
  }

  createGroup({
    required GroupModel model,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser)
        .collection('Groups')
        .doc(model.groupName)
        .set(model.toJson());
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(_currentUser)
    //     .collection('Groups')
    //     .doc(model.groupName)
    //     .collection("Members")
    //     .doc(_currentUser)
    //     .set(currentMember.toJson());
  }

  final groupsCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Groups');
  Future removeMemberToGroup({
    required List<GroupUserModel> membersList,
    required GroupUserModel removedMember,
    required GroupsModel group,
  }) async {
    RxList<GroupUserModel> members = <GroupUserModel>[].obs;
    members.value = membersList;
    if (members.any((member) => member.uid == removedMember.uid)) {
      members.removeWhere((element) => element.uid == removedMember.uid);
      final groupModel = GroupsModel(
          uid: group.uid,
          groupImage: group.groupImage,
          groupName: group.groupName,
          dateTime: group.dateTime,
          members: members);
      await groupsCollection
          .doc(group.groupName)
          .set(groupModel.toJson())
          .then((value) async {
        await getGroupsList();
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(removedMember.uid)
          .collection("Groups")
          .doc(group.groupName)
          .delete()
          .then((value) {});
    }
  }

  addMesageToChat({
    required String groupName,
    required GroupMessages message,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Groups')
        .doc(groupName)
        .collection('messages')
        .doc(message.dateTime)
        .set(message.toJson());
    for (var i in message.reciverUid!) {
      if (i != _currentUser) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(i)
            .collection('Groups')
            .doc(groupName)
            .collection('messages')
            .doc(message.dateTime)
            .set(message.toJson());
      }
    }
  }

  Future<List<GroupModel>> getGroupsList() async {
    RxList<GroupModel> groupsList = <GroupModel>[].obs;

    groupsCollection
        // .where('Members', arrayContains:  _currentUser)
        .snapshots(includeMetadataChanges: true)
        .listen((data) {
      final groups =
          data.docs.map((e) => GroupModel.fromJson(e.data())).toList();
      groupsList.value = groups;
      print("groupsList" + "${groups.length}");
    });

    return groupsList;
  }

  RxList<GroupUserModel> getGroupMember({required String groupName}) {
    RxList<GroupUserModel> groupMembers = <GroupUserModel>[].obs;
    groupsCollection.doc(groupName).snapshots().listen((data) {
      final model = GroupsModel.fromJson(data.data()!);
      groupMembers.value = model.members!.toList();
    });

    return groupMembers;
  }

  Future addMembersToGroup({
    required List<GroupUserModel> membersList,
    required GroupUserModel newMember,
    required GroupsModel group,
  }) async {
    RxList<GroupUserModel> members = <GroupUserModel>[].obs;

    members.value = membersList;
    if (!members.any((member) => member.uid == newMember.uid)) {
      members.add(newMember);

      for (var i in membersList) {
        await groupsCollection
            .doc(group.groupName)
            .collection('Members')
            .doc(i.uid)
            .set(newMember.toJson());
      }
      // if (i != _currentUser) {
      for (int x = 0; x < members.length; x++) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(members[x].uid)
            .collection('Groups')
            .doc(group.groupName)
            .set(group.toJson());

        // .collection("Members")
        // .doc(members[x].uid)
        // .set(members[x].toJson());

        // }
      }

      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(newMember.uid)
      //     .collection("Groups")
      //     .doc(group.groupName)
      //     .set(group.toJson());
    }
  }

  deleteGroup(
      {required String groupName,
      required List<GroupUserModel> membersList}) async {
    await groupsCollection.doc(groupName).delete();
    for (int x = 0; x < membersList.length; x++) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(membersList[x].uid)
          .collection('Groups')
          .doc(groupName)
          .delete();
    }
  }
}

class FirebaseUserServices {
  final currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  Future<List<UserModel>> getUsersList() async {
    // Get the current user
    RxList<UserModel> userChatList = <UserModel>[].obs;

    // Query the Firestore collection containing user data
    // final usersCollection = FirebaseFirestore.instance.collection('users');
    usersCollection
        .orderBy('lastActive', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((data) {
      final users = data.docs
          .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      userChatList.value = users;
    });

    return userChatList;
  }
}

// class FirebaseChannelServices {
//   createChannel({
//     required ChannelNameModel channel,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection('Channels')
//         .doc(channel.channelName)
//         .set(channel.toJson());
//   }

//   removeChannel({required String channelName}) async {
//     await FirebaseFirestore.instance
//         .collection('Channels')
//         .doc(channelName)
//         .delete();
//   }

//   Future<List<ChannelNameModel>> getChannels() async {
//     RxList<ChannelNameModel> channelsList = <ChannelNameModel>[].obs;
//     await FirebaseFirestore.instance
//         .collection('Channels')
//         .snapshots()
//         .listen((data) {
//       final channels =
//           data.docs.map((e) => ChannelNameModel.fromJson(e.data())).toList();

//       channelsList.value = channels;
//     });
//     return channelsList;
//   }
// }
