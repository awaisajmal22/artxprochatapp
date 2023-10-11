import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:artxprochatapp/Utils/Toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/files.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;

import '../../AuthModule/SignUp/Model/user_model.dart';
import '../../Services/single_chat_notification_firebase_services.dart';
import '../../Services/firebase_services.dart';
import '../Model/notification_model.dart';
import '../Model/users_model.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class SingleChatViewModel extends GetxController {
  final singleChatController = TextEditingController();
  final searchController = TextEditingController();
  RxInt textFieldTextLenght = 26.obs;
  final scrollController = ScrollController();
  RxInt textFieldLines = 1.obs;
  RxString senderUID = ''.obs;
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

  RxList<UserModel> usersList = <UserModel>[].obs;
  //

  RxBool isFileUploading = false.obs;
  FilePickerResult? result;
  Future<void> sendMessage({
    required String msg,
    required String recieverToken,
    required bool isPickedFile,
    required String receiverUID,
    required UserModel currentUser
  }) async {
    String fileUrl;
    if (isPickedFile == true) {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'zip', 'png', 'jpeg', 'jpg', 'apk'],
      );

      if (result != null) {
        isFileUploading.value = true;
        Reference storage = FirebaseStorage.instance.ref().child(
            'Messages/[messages-${DateTime.now().microsecondsSinceEpoch.toString()}');
        await storage.putFile(File(result!.files.first.path!));

        await storage.getDownloadURL().then((value) async {
           final notification = Notifications(
          senderId: currentUser .uid,
          title: currentUser.name,
          description: result!.files.first.name,
          type: 'file',
          subId: receiverUID,
          id: currentUser.uid);
     
          final message = Message(
            senderUid: currentUser.uid,
            receiverUid: receiverUID,
            messageType: MessageType.text,
            msg: result!.files.first.name,
            isReaded: false,
            file: value,
            fmcToken: recieverToken,
            emoji: '',
            dateTime: DateTime.now().toIso8601String(),
          );
          isFileUploading.value = false;
          await FirebaseMessagesServices()
              .addMesageToChat(receiverUID: receiverUID, message: message); await FirebaseMessagesServices.saveNotification(
        notification,
        message,
      );
        });
       
      }
    } else {
      final notification = Notifications(
          senderId: currentUser .uid,
          title: currentUser.name,
          description: msg,
          type: 'text',
          subId: receiverUID,
          id: currentUser.uid);
      final message = Message(
        senderUid: currentUser.uid,
        receiverUid: receiverUID,
        messageType: MessageType.text,
        msg: msg,
        isReaded: false,
        fmcToken: recieverToken,
        emoji: '',
        dateTime: DateTime.now().toIso8601String(),
      );
      singleChatController.clear();
      textFieldTextLenght.value = 26;
      textFieldLines.value = 1;
      senderUID.value = message.senderUid!;
      await FirebaseMessagesServices()
          .addMesageToChat(receiverUID: receiverUID, message: message);

      await FirebaseMessagesServices.saveNotification(
        notification,
        message,
      );

      print('you picked only 3 files');
      return;
    }
    // Do something with the selected files
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

  updateEmojie({
    required String senderUID,
    required String emoji,
    required String docUID,
  }) async {
    await FirebaseMessagesServices()
        .updateEmoji(senderUID: senderUID, emoji: emoji, docUID: docUID);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsers();
  
    // recieveMessages();
  }

  RxList emojiList = [
    'assets/icons/like.svg',
    'assets/icons/heart.svg',
    'assets/icons/ok.svg',
    'assets/icons/hand.svg',
    'assets/icons/open-face-smile.svg',
    'assets/icons/joy.svg'
  ].obs;
  final currentUser = FirebaseAuth.instance.currentUser;

  RxList<UserModel> userChatList = <UserModel>[].obs;
  getUsers() async {
    userChatList.value = await FirebaseUserServices().getUsersList();
    if (userChatList.isNotEmpty) {
      for (var element in userChatList) {
        if (element.isMessage == true) {
          usersList.value = userChatList;
          print(usersList.length);
        }
      }
    }
  }

  Rx<UserModel> singleUser = UserModel().obs;
  UserModel? getUserByID({required String uid}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((user) {
      singleUser.value = UserModel.fromJson(user.data()!);
    });
    return singleUser.value;
  }

  // Rx<UserModel> currentUserData = UserModel().obs;
  // getCurrentUser() async {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(currentUser!.uid)
  //       .snapshots()
  //       .listen((user) {
  //     currentUserData.value = UserModel.fromJson(user.data()!);
  //   });
  //   return currentUserData.value;
  // }

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

  final Dio dio = Dio();
  RxBool downloadingFile = false.obs;
  RxDouble progress = (0.0).obs;
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
}
