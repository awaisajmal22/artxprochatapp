import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../../AuthModule/SignUp/Model/user_model.dart';
import '../Model/users_model.dart';
import 'package:path/path.dart' as path;

class SingleChatViewModel extends GetxController {
  final singleChatController = TextEditingController();
  final searchController = TextEditingController();
  RxInt textFieldTextLenght = 26.obs;

  RxInt textFieldLines = 1.obs;
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

  RxList<UserModel> searchList = <UserModel>[].obs;
  List<UserModel> searchUsers(String query) {
    return userChatList
        .where((user) => user.name!.contains(query.toUpperCase()))
        .toList();
  }

  RxList<UsersModel> usersList = <UsersModel>[
    UsersModel(
        groupCreatedBy: true.obs,
        id: 1,
        userImage:
            'https://images.pexels.com/photos/18125927/pexels-photo-18125927/free-photo-of-woman-on-the-stairwell-of-a-parking-garage.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        userName: 'Umer',
        message: [
          Message(
            dateTime: '2023-09-25 05:00:00.000Z',
            isUserSide: true,
            isReaded: false,
            msg: 'hi How are you',
          )
        ].obs),
    UsersModel(
        groupCreatedBy: false.obs,
        id: 2,
        userImage:
            'https://images.pexels.com/photos/18377390/pexels-photo-18377390/free-photo-of-city-street-building-pattern.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        userName: 'Jamal',
        message: [
          Message(
            dateTime: '2022-08-08 05:00:00.000Z',
            isUserSide: true,
            isReaded: false,
            msg: 'hi How are you',
          ),
          Message(
            dateTime: '2022-08-08 02:00:00.000Z',
            isUserSide: true,
            isReaded: false,
            msg: 'kick you',
          ),
          Message(
            dateTime: '2022-08-07 05:00:00.000Z',
            isUserSide: true,
            isReaded: true,
            msg: 'kick you',
          ),
          Message(
            dateTime: '2022-08-06 05:00:00.000Z',
            isUserSide: true,
            isReaded: true,
            msg: 'kick you',
          )
        ].obs),
    UsersModel(
        groupCreatedBy: false.obs,
        id: 3,
        userImage:
            'https://images.pexels.com/photos/15488686/pexels-photo-15488686/free-photo-of-red-cabriolet-car-with-flowers-arrangement.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        userName: 'Kashif',
        message: <Message>[].obs),
    UsersModel(
        groupCreatedBy: false.obs,
        id: 4,
        userImage:
            'https://images.pexels.com/photos/12792408/pexels-photo-12792408.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
        userName: 'Jahan',
        message: <Message>[].obs)
  ].obs;
  RxList<Messages> messages = <Messages>[].obs;
  recieveMessages() async {
    final data = await FirebaseFirestore.instance
        .collection('messages')
        .where('receiverUid',
            isEqualTo: currentUser) // Filter messages for the current user
        .orderBy('dateTime',
            descending: true) // Order by timestamp (newest first)
        .snapshots();
    messages.addAll(data as Iterable<Messages>);
  }

  FilePickerResult? result;
  Future<void> sendMessage({
    required String msg,
    required bool isPickedFile,
    required String senderUID,
    required String receiverUID,
  }) async {
    String fileUrl;
    if (isPickedFile == true) {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'zip', 'png', 'jpeg', 'jpg', 'apk'],
      );

      if (result != null) {
        Reference storage = FirebaseStorage.instance.ref().child(
            'Messages/[messages-${DateTime.now().microsecondsSinceEpoch.toString()}');
        await storage.putFile(File(result!.files.first.path!));
        await storage.getDownloadURL().then((value) async {
          final message = Message(
            senderUid: senderUID,
            receiverUid: receiverUID,
            messageType: MessageType.text,
            msg: result!.files.first.name,
            isReaded: false,
            file: value,
            dateTime: DateTime.now().toIso8601String(),
          );
          await _addMesageToChat(receiverUID: receiverUID, message: message);
        });

        // usersModel.message!.insert(
        //     0,
        //     Message(
        //       file: File(result!.files[0].path!),
        //       isReaded: true,
        //       dateTime: DateTime.now().toIso8601String(),
        //       isUserSide: true,
        //       msg: result?.files[0].name,
        //     ));
      }
    } else {
      // await FirebaseFirestore.instance.collection('messages').add({
      //   'senderUid': senderUID,
      //   'receiverUid': receiverUID,
      //   'dateTime': DateTime.now().toIso8601String(),
      //   'isReaded': false,
      //   'isUserSide': false,
      //   'file': '',
      //   msg: msg,
      // });
      final message = Message(
        senderUid: senderUID,
        receiverUid: receiverUID,
        messageType: MessageType.text,
        msg: msg,
        isReaded: false,
        dateTime: DateTime.now().toIso8601String(),
      );
      singleChatController.clear();
      textFieldTextLenght.value = 26;
      textFieldLines.value = 1;
      await _addMesageToChat(receiverUID: receiverUID, message: message);
      print('you picked only 3 files');
      return;
    }
    // Do something with the selected files
  }

  _addMesageToChat({
    required String receiverUID,
    required Message message,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverUID)
        .collection('messages')
        .add(message.toJson());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUID)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(message.toJson());
  }

  String getImageAccordingExtension(String path) {
    if (path.contains('zip')) {
      return 'assets/images/zip.jpeg';
    } else {
      return 'assets/images/doc.png';
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsersList();
    // recieveMessages();
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  RxList<UserModel> userChatList = <UserModel>[].obs;
  Future<List<UserModel>> getUsersList() async {
    // Get the current user

    final currentUserUID = currentUser?.uid;

    // Query the Firestore collection containing user data
    // final usersCollection = FirebaseFirestore.instance.collection('users');
    usersCollection
        .orderBy('lastActive', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((data) {
      userChatList.value = data.docs
          .map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });

    // for (final doc in querySnapshot.docs) {
    //   // Exclude the current user from the list
    //   if (doc.id != currentUserUID) {
    //     userChatList.add(
    //       UserModel(
    //           uid: doc.id,
    //           name: doc['name'],
    //           email: doc['email'],
    //           image: doc['image'],
    //           isOnline: doc['isOnline'],
    //           lastActive: doc['lastActive']),
    //     );
    //   }
    // }

    return userChatList;
  }

  // sendMessages(
  //     {required String revciverUid,
  //     required String msg,
  //     required String file,
  //     required String name,
  //     required String image}) async {
  //   final user = await FirebaseAuth.instance.currentUser;
  //   final senderUid = user!.uid;
  //   String fileUrl = '';
  //   if (file != '') {}
  //   // Create a new message document in Firestore

  //   // Clear the message input field
  // }
  Rx<UserModel> singleUser = UserModel().obs;
  UserModel? getUserByID({required String uid}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((user) {
      singleUser.value = UserModel.fromJson(user.data()!);
    });
  }

  RxList<Message> messagesList = <Message>[].obs;
  List<Message> getMessages({required String receiverUid}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverUid)
        .collection('messages')
        .orderBy('dateTime', descending: false)
        .snapshots()
        .listen((msgData) {
      messagesList.value =
          msgData.docs.map((e) => Message.fromJson(e.data())).toList();
          
    });
    return messagesList;
  }
}
