import 'dart:io';

import 'package:artxprochatapp/App/Auth/Signup/Model/user_model.dart';
import 'package:artxprochatapp/App/Services/single_chat_notification_firebase_services.dart';
import 'package:artxprochatapp/App/SingleChat/Model/message_model.dart';
import 'package:artxprochatapp/App/SingleChat/Model/notification_model.dart';
import 'package:artxprochatapp/Utils/Models/popUpMenu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Utils/Toast/toast.dart';
import '../../CreatGroup/Model/group_model.dart';
import '../../Services/firebase_services.dart';

class GroupChatViewModel extends GetxController {
  TextEditingController messageController = TextEditingController();
  TextEditingController emojiController = TextEditingController();
  List<PopupMenuModel> popupMenuList = <PopupMenuModel>[
    PopupMenuModel(icon: Icons.person, key: 1, title: 'View Profile'),
    PopupMenuModel(icon: Ionicons.link, key: 2, title: 'Media, Links & Docs'),
  ];
  RxList<UserModel> userChatList = <UserModel>[].obs;
   final scrollController = ScrollController();
  RxBool isFileUploading = false.obs;
  RxBool isEmojiShowing = false.obs;
  RxBool isShowCamera = true.obs;
  onBackspacePressed() {
    emojiController
      ..text = emojiController.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: emojiController.text.length));
  }

  RxString lastMessage = ''.obs;
  final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  Rx<UserModel> currentUserData = UserModel().obs;
  getCurrentUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserUID)
        .snapshots()
        .listen((data) {
      if (data.exists) {
        final model = UserModel.fromJson(data.data() as Map<String, dynamic>);
        currentUserData.value = model;
      }
    });
  }

  Rx<UserModel> reciever = UserModel().obs;
  UserModel getUserByID({required String uid}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((user) {
      reciever.value = UserModel.fromJson(user.data() as Map<String, dynamic>);
    });
    return reciever.value;
  }

  RxString senderUID = ''.obs;
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

  Future<void> sendMessage(
      {required String msg,
      required bool isPickedFile,
      required String senderUID,
      required List<UserModel> groupmembers,
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

    }
    if (isPickedFile == true) {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'zip', 'png', 'jpeg', 'jpg', 'apk'],
      );

      if (result != null) {
        isFileUploading.value = true;
        if (result!.files.first.name.contains('.png') ||
            result!.files.first.name.contains('.jpg') ||
            result!.files.first.name.contains('.jpeg')) {
          Reference storage = FirebaseStorage.instance.ref().child(
              '$groupName/media/${result!.files.first.name}[${DateTime.now()}');
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
        } else if (result!.files.first.name.contains('.doc') ||
            result!.files.first.name.contains('.zip') ||
            result!.files.first.name.contains('.pdf')) {
          Reference storage = FirebaseStorage.instance.ref().child(
              '$groupName/documents/${result!.files.first.name}[${DateTime.now()}');
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
      messageController.clear();
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
          backgroundColor: Colors.blue,
          gravity: ToastGravity.CENTER);
    } else {
      toast(
          title: 'Something went wrong..',
          backgroundColor: Colors.blue,
          gravity: ToastGravity.CENTER);
    }

    downloadingFile.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getCurrentUserData();
    super.onInit();
  }
}
