import 'dart:io';

import 'package:artxprochatapp/AppModule/GroupChatModule/Model/group_chat_model.dart';
import 'package:artxprochatapp/AppModule/Services/firebase_services.dart';
import 'package:artxprochatapp/AppModule/SingleChatModule/ViewModel/single_chat_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Utils/SizeConfig/size_config.dart';
import '../../../Utils/Toast/toast.dart';
import '../../AuthModule/SignUp/Model/user_model.dart';
import '../../SingleChatModule/Model/notification_model.dart';
import '../../SingleChatModule/Model/users_model.dart';
import '../Model/groups_model.dart';

class GroupChatViewModel extends GetxController {
  RxBool isUser = false.obs;
  RxInt textFieldTextLenght = 40.obs;
  final groupChatInputController = TextEditingController();
  final groupNameController = TextEditingController();
  final searchController = TextEditingController();
  RxInt textFieldLines = 1.obs;
  final singleChatVM = Get.put(SingleChatViewModel());
  RxList<UserModel> searchList = <UserModel>[].obs;
  RxList<UserModel> userChatList = <UserModel>[].obs;
  List<UserModel> searchUsers(String query) {
    print(singleChatVM.userChatList.length);
    return singleChatVM.userChatList
        .where((user) => user.name!.contains(query.toLowerCase()))
        .toList();
  }

  final scrollController = ScrollController();

  RxList<GroupChatModel> groupList = <GroupChatModel>[
    GroupChatModel(
        groupImage:
            'https://images.pexels.com/photos/18005100/pexels-photo-18005100/free-photo-of-an-interior-with-potted-plants-and-pictures-in-frames.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        groupName: 'NewYork is My City',
        id: 1,
        userModel: [
          GroupUsersModel(
            groupCreatedBy: true.obs,
            id: 1,
            userImage:
                'https://images.pexels.com/photos/18125927/pexels-photo-18125927/free-photo-of-woman-on-the-stairwell-of-a-parking-garage.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Umer',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 2,
            userImage:
                'https://images.pexels.com/photos/18377390/pexels-photo-18377390/free-photo-of-city-street-building-pattern.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jamal',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 3,
            userImage:
                'https://images.pexels.com/photos/15488686/pexels-photo-15488686/free-photo-of-red-cabriolet-car-with-flowers-arrangement.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Kashif',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 4,
            userImage:
                'https://images.pexels.com/photos/12792408/pexels-photo-12792408.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jahan',
          )
        ]),
    GroupChatModel(
        groupImage:
            'https://images.pexels.com/photos/18005100/pexels-photo-18005100/free-photo-of-an-interior-with-potted-plants-and-pictures-in-frames.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        groupName: 'Kawait',
        id: 2,
        userModel: [
          GroupUsersModel(
            groupCreatedBy: true.obs,
            id: 1,
            userImage:
                'https://images.pexels.com/photos/18125927/pexels-photo-18125927/free-photo-of-woman-on-the-stairwell-of-a-parking-garage.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Umer',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 2,
            userImage:
                'https://images.pexels.com/photos/18377390/pexels-photo-18377390/free-photo-of-city-street-building-pattern.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jamal',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 3,
            userImage:
                'https://images.pexels.com/photos/15488686/pexels-photo-15488686/free-photo-of-red-cabriolet-car-with-flowers-arrangement.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Kashif',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 4,
            userImage:
                'https://images.pexels.com/photos/12792408/pexels-photo-12792408.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jahan',
          )
        ]),
    GroupChatModel(
        groupImage:
            'https://images.pexels.com/photos/18005100/pexels-photo-18005100/free-photo-of-an-interior-with-potted-plants-and-pictures-in-frames.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        groupName: 'America',
        id: 3,
        userModel: [
          GroupUsersModel(
            groupCreatedBy: true.obs,
            id: 1,
            userImage:
                'https://images.pexels.com/photos/18125927/pexels-photo-18125927/free-photo-of-woman-on-the-stairwell-of-a-parking-garage.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Umer',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 2,
            userImage:
                'https://images.pexels.com/photos/18377390/pexels-photo-18377390/free-photo-of-city-street-building-pattern.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jamal',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 3,
            userImage:
                'https://images.pexels.com/photos/15488686/pexels-photo-15488686/free-photo-of-red-cabriolet-car-with-flowers-arrangement.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Kashif',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 4,
            userImage:
                'https://images.pexels.com/photos/12792408/pexels-photo-12792408.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jahan',
          )
        ]),
    GroupChatModel(
        groupImage:
            'https://images.pexels.com/photos/18005100/pexels-photo-18005100/free-photo-of-an-interior-with-potted-plants-and-pictures-in-frames.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        groupName: 'Pakistan',
        id: 1,
        userModel: [
          GroupUsersModel(
            groupCreatedBy: true.obs,
            id: 4,
            userImage:
                'https://images.pexels.com/photos/18125927/pexels-photo-18125927/free-photo-of-woman-on-the-stairwell-of-a-parking-garage.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Umer',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 2,
            userImage:
                'https://images.pexels.com/photos/18377390/pexels-photo-18377390/free-photo-of-city-street-building-pattern.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jamal',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 3,
            userImage:
                'https://images.pexels.com/photos/15488686/pexels-photo-15488686/free-photo-of-red-cabriolet-car-with-flowers-arrangement.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Kashif',
          ),
          GroupUsersModel(
            groupCreatedBy: false.obs,
            id: 4,
            userImage:
                'https://images.pexels.com/photos/12792408/pexels-photo-12792408.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
            userName: 'Jahan',
          )
        ])
  ].obs;
  FilePickerResult? result;
  RxString image = ''.obs;
  Future<String> selectImage() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'png',
        'jpeg',
        'jpg',
      ],
    );

    if (result != null) {
      Reference storage = FirebaseStorage.instance.ref().child(
          'Groups/[image-${DateTime.now().microsecondsSinceEpoch.toString()}');
      await storage.putFile(File(result!.files.first.path!));

      image.value = await storage.getDownloadURL();
    }
    return image.value;
  }

  creatGroup({
    required String groupName,
    required String groupImage,
  }) {
    if (groupName.isNotEmpty && groupImage.isNotEmpty) {
      GroupUserModel currentUser = GroupUserModel(
          fcmToken: currentUserData.value.fmcToken,
          image: currentUserData.value.image,
          textOnlyAdmin: false,
          isAdmin: true,
          email: currentUserData.value.email,
          isOnline: currentUserData.value.isOnline,
          lastActive: currentUserData.value.lastActive,
          name: currentUserData.value.name,
          uid: currentUserData.value.uid,
          isAddedToGroup: true);

      final groupModel = GroupsModel(
          uid: [FirebaseAuth.instance.currentUser!.uid],
          groupImage: groupImage,
          groupName: groupName,
          dateTime: DateTime.now().toIso8601String(),
          members: [currentUser]);
      FirebaseGroupServices().createGroup(
        model: groupModel,
      );
      image.value = '';
    }
  }

  RxBool isPersonAddedToGroup = false.obs;
  RxList<GroupsModel> groupsList = <GroupsModel>[].obs;
  RxInt groupMembersIndex = 0.obs;
  RxList<GroupUserModel> groupMembersList = <GroupUserModel>[].obs;
  getGroupsList() async {
    groupsList.value = await FirebaseGroupServices().getGroupsList();
    print(groupList.length);
  }

  makeAdmin({
    required bool textOnlyAdminValue,
    required String memberUID,
    required List<GroupUserModel> members,
    required GroupsModel groupData,
  }) async {
    await FirebaseGroupServices().makeAdmin(
        textOnlyAdminValue: textOnlyAdminValue,
        memberUID: memberUID,
        members: members,
        groupData: groupData);
  }

  getGroupMembers({required String groupName}) async {
    groupMembersList.value =
        await FirebaseGroupServices().getGroupMember(groupName: groupName);
  }

  textOnlyAdmin({
    required String groupName,
    required bool textOnlyAdminValue,
    required List<GroupUserModel> members,
    required GroupsModel groupData,
  }) async {
    FirebaseGroupServices().textOnlyAdmin(
      groupName: groupName,
      textOnlyAdminValue: textOnlyAdminValue,
      members: members,
      groupData: groupData,
    );
  }

  deleteGroup(
      {required String groupName,
      required List<GroupUserModel> membersList}) async {
    await FirebaseGroupServices()
        .deleteGroup(groupName: groupName, membersList: membersList);
  }

  User? user = FirebaseAuth.instance.currentUser;
  Rx<UserModel> currentUserData = UserModel().obs;
  getCurrentUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .listen((data) {
      if (data.exists) {
        final model = UserModel.fromJson(data.data() as Map<String, dynamic>);
        currentUserData.value = model;
      }
    });
  }

  removeMemberToGroup({
    required GroupsModel group,
    required GroupUserModel removedMember,
  }) async {
    await FirebaseGroupServices().removeMemberToGroup(
        membersList: group.members!,
        removedMember: removedMember,
        group: group);
  }

  addMembersToGroup(
      {required GroupsModel group, required GroupUserModel newMember}) async {
    await FirebaseGroupServices().addMembersToGroup(
      group: group,
      newMember: newMember,
      membersList: group.members!,
    );
  }

  RxBool isFileUploading = false.obs;

  Future<void> sendMessage(
      {required String msg,
      required bool isPickedFile,
      required String senderUID,
      required List<GroupUserModel> groupmembers,
      required String groupName,
      required UserModel currentUser}) async {
    String fileUrl;
    RxList<String> receiverUidList = <String>[].obs;
    RxList<String> fmcTokenLIst = <String>[].obs;
    final currentFcmToken = await FirebaseMessaging.instance.getToken();

    for (var users in groupmembers) {
      receiverUidList.addIf(
          users.uid != FirebaseAuth.instance.currentUser!.uid, users.uid!);
      for (var data in userChatList) {
        if (data.uid == users.uid) {
          fmcTokenLIst.addIf(data.fmcToken != currentFcmToken!, data.fmcToken!);
        }
      }

      print(users.fcmToken);
    }
    if (isPickedFile == true) {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'zip', 'png', 'jpeg', 'jpg', 'apk'],
      );

      if (result != null) {
        isFileUploading.value = true;
        Reference storage = FirebaseStorage.instance.ref().child(
            'GroupMessage/[messages-${DateTime.now().microsecondsSinceEpoch.toString()}');
        await storage.putFile(File(result!.files.first.path!));

        await storage.getDownloadURL().then((value) async {
          final message = GroupMessages(
            fcmToken: fmcTokenLIst,
            image: currentUser.image,
            senderUid: senderUID,
            reciverUid: receiverUidList,
            groupMessagesType: GroupMessageType.file,
            msg: result!.files.first.name,
            isReaded: false,
            file: value,
            emoji: '',
            dateTime: DateTime.now().toIso8601String(),
          );
          final notification = Notifications(
              senderId: senderUID,
              title: groupName,
              description: result!.files.first.name,
              type: 'file');
          isFileUploading.value = false;
          await FirebaseGroupServices()
              .addMesageToChat(message: message, groupName: groupName);
          await FirebaseGroupNotificationServices.saveNotification(
              notification, groupName, message);
        });
      }
    } else {
      final message = GroupMessages(
        fcmToken: fmcTokenLIst,
        senderUid: senderUID,
        reciverUid: receiverUidList,
        image: currentUser.image,
        groupMessagesType: GroupMessageType.text,
        msg: msg,
        isReaded: false,
        emoji: '',
        dateTime: DateTime.now().toIso8601String(),
      );
      groupChatInputController.clear();
      textFieldTextLenght.value = 26;
      textFieldLines.value = 1;
      final notification = Notifications(
          senderId: senderUID,
          title: groupName,
          description: msg,
          type: 'text');
      await FirebaseGroupServices()
          .addMesageToChat(message: message, groupName: groupName);
      await FirebaseGroupNotificationServices.saveNotification(
          notification, groupName, message);
      print('you picked only 3 files');
      return;
    }
    // Do something with the selected files
  }

// removeFcmToken({required GroupMessages message, required String groupName}) async {
// await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
// .collection("Groups")
// .doc(groupName).collection('messages').doc(message.dateTime).update(data)
// }
  RxList<GroupMessages> messagesList = <GroupMessages>[].obs;
  List<GroupMessages> getGroupMessages({required String groupName}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Groups')
        .doc(groupName)
        .collection('messages')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .listen((msgData) {
      messagesList.value =
          msgData.docs.map((e) => GroupMessages.fromJson(e.data())).toList();
      scrollDOwn();
    });
    return messagesList;
  }

  void scrollDOwn() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  Future<bool> download(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage) &&
            // access media location needed for android 10/Q
            await _requestPermission(Permission.accessMediaLocation) &&
            await _requestPermission(Permission.manageExternalStorage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/ArtxPro";
          directory = Directory(newPath);
          print(directory.path);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File("${directory.path}/$fileName");
      if (!await directory.exists()) {
        await directory.create(
          recursive: true,
        );
        print('Directory Created');
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          progress.value = value1 / value2;
        });

        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  final Dio dio = Dio();
  RxBool downloadingFile = false.obs;
  RxDouble progress = (0.0).obs;
  downloadFile(String url, String fileName) async {
    downloadingFile.value = true;
    progress.value = 0;

    bool downloaded = await download("$url" "/$fileName", fileName);
    if (downloaded) {
      toast(
          title: 'Downloading Successfull',
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER);
    } else {
      toast(
          title: 'Something went wrong..',
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER);
    }

    downloadingFile.value = false;
  }

  RxBool displayEmoji = false.obs;
  RxInt selectedEmojiIndex = (-1).obs;
  String getImageAccordingExtension(String path) {
    if (path.contains('zip')) {
      return 'assets/images/zip.jpeg';
    } else if (path.contains('.pdf')) {
      return 'assets/images/pdf.png';
    } else {
      return 'assets/images/doc.png';
    }
  }

  String checkDate(String dateString) {
    DateTime checkedTime = DateTime.parse(dateString);
    DateTime currentTime = DateTime.now();

    if ((currentTime.year == checkedTime.year) &&
        (currentTime.month == checkedTime.month) &&
        (currentTime.day == checkedTime.day)) {
      return "${DateFormat('hh:mm').format(checkedTime)}";
    } else if ((currentTime.year == checkedTime.year) &&
        (currentTime.month == checkedTime.month)) {
      if (checkedTime.day < currentTime.day) {
        return "${DateFormat.E().format(checkedTime)}";
      } else {
        return dateString;
      }
    }
    return "${DateFormat.MMMd().format(checkedTime)}";
  }

  updateEmoji(
      {required String senderUID,
      required String emoji,
      required String groupName,
      required String docUID}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Groups')
        .doc(groupName)
        .collection('messages')
        .doc(docUID)
        .update({'emoji': emoji});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(senderUID)
        .collection('Groups')
        .doc(groupName)
        .collection('messages')
        .doc(docUID)
        .update({'emoji': emoji});
  }

  RxList emojiList = [
    'assets/icons/like.svg',
    'assets/icons/heart.svg',
    'assets/icons/ok.svg',
    'assets/icons/hand.svg',
    'assets/icons/open-face-smile.svg',
    'assets/icons/joy.svg'
  ].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getGroupsList();
    getCurrentUserData();
    userChatList.value = singleChatVM.userChatList;
    super.onInit();
  }
}
