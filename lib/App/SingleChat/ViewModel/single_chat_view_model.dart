import 'dart:io';

import 'package:artxprochatapp/App/Auth/Signup/Model/user_model.dart';
import 'package:artxprochatapp/App/Services/single_chat_notification_firebase_services.dart';
import 'package:artxprochatapp/App/SingleChat/Model/message_model.dart';
import 'package:artxprochatapp/App/SingleChat/Model/notification_model.dart';
import 'package:artxprochatapp/Utils/Models/popUpMenu_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;

import 'package:permission_handler/permission_handler.dart';

import '../../../Utils/Toast/toast.dart';
import '../../Home/Model/wraper_tab_model.dart';

class SingleChatViewModel extends GetxController {
  TextEditingController messageController = TextEditingController();
  TextEditingController emojiController = TextEditingController();
  List<PopupMenuModel> popupMenuList = <PopupMenuModel>[
    PopupMenuModel(icon: Icons.person, key: 1, title: 'View Profile'),
    PopupMenuModel(icon: Ionicons.link, key: 2, title: 'Media, Links & Docs'),
  ];

  final String localUserID = math.Random().nextInt(10000).toString();
  RxBool isEmojiShowing = false.obs;
  RxBool isShowCamera = true.obs;
  // onBackspacePressed() {
  //   emojiController
  //     ..text = emojiController.text.characters.toString()
  //     ..selection = TextSelection.fromPosition(
  //         TextPosition(offset: emojiController.text.length));
  // }
//get current User
  // RxString lastMessage = ''.obs;
  final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  Rx<UserModel> currentUser = UserModel().obs;
  getCurrentUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserUID)
        .snapshots()
        .listen((data) {
      if (data.exists) {
        final model = UserModel.fromJson(data.data() as Map<String, dynamic>);
        currentUser.value = model;
      }
    });
  }

//get User By ID
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

//send Camera Image
  RxString imagePath = ''.obs;
  final pickedImage = ImagePicker();
  Future getImageFormCamera(
      {required String recieverToken,
      required bool isPickedFile,
      required String receiverUID,
      required UserModel currentUser}) async {
    final selectedImage =
        await pickedImage.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      Reference storage = FirebaseStorage.instance.ref().child(
          'Messages/media/$receiverUID[${currentUser.uid}/${selectedImage.name}[${DateTime.now()}');
      await storage.putFile(File(selectedImage.path));

      await storage.getDownloadURL().then((value) async {
        final notification = Notifications(
            senderId: currentUser.uid,
            title: currentUser.name,
            description: selectedImage.name,
            type: 'file',
            subId: receiverUID,
            id: currentUser.uid);

        final message = Message(
          isPlaying: false,
          senderUid: currentUser.uid,
          receiverUid: receiverUID,
          messageType: MessageType.text,
          msg: value,
          isReaded: false,
          file: selectedImage.name,
          fmcToken: recieverToken,
          emoji: '',
          dateTime: DateTime.now().toIso8601String(),
        );
        await FirebaseMessagesServices()
            .addMesageToChat(receiverUID: receiverUID, message: message);
        await FirebaseMessagesServices.saveNotification(
          notification,
          message,
        );
      });
    }
  }

  Future getImageFormStorage({required String recieverToken,
      required bool isPickedFile,
      required String receiverUID,
      required UserModel currentUser}) async {
    final selectedImage =
        await pickedImage.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      Reference storage = FirebaseStorage.instance.ref().child(
          'Messages/media/$receiverUID[${currentUser.uid}/${selectedImage.name}[${DateTime.now()}');
      await storage.putFile(File(selectedImage.path));

      await storage.getDownloadURL().then((value) async {
        final notification = Notifications(
            senderId: currentUser.uid,
            title: currentUser.name,
            description: selectedImage.name,
            type: 'file',
            subId: receiverUID,
            id: currentUser.uid);

        final message = Message(
          isPlaying: false,
          senderUid: currentUser.uid,
          receiverUid: receiverUID,
          messageType: MessageType.text,
          msg: value,
          isReaded: false,
          file: selectedImage.name,
          fmcToken: recieverToken,
          emoji: '',
          dateTime: DateTime.now().toIso8601String(),
        );
        await FirebaseMessagesServices()
            .addMesageToChat(receiverUID: receiverUID, message: message);
        await FirebaseMessagesServices.saveNotification(
          notification,
          message,
        );
      });
    }
  }

//send Message
  RxString senderUID = ''.obs;

  Future sendTextMessage(
      {required String msg,
      String? audioPath,
      required String recieverToken,
      required bool isPickedFile,
      required String receiverUID,
      required UserModel currentUser}) async {
    final notification = Notifications(
        senderId: currentUser.uid,
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
    messageController.clear();
    isShowCamera.value = true;
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

//get All Messages
  RxList<Message> messagesList = <Message>[].obs;
  RxList<int> MessagesIndexList = <int>[].obs;
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
      for (int i = 0; i < messagesList.length; i++) {
        MessagesIndexList.add(i);
      }
      scrollDOwn();
    });

    return messagesList;
  }

//Scroll
  final scrollController = ScrollController();
  void scrollDOwn() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

//Permissions request
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

//Download
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

// bottom Sheet
  RxBool isShowBottomSheet = false.obs;
  // Transform bottomSheet
  RxDouble width = 0.0.obs;
  RxDouble height = 0.0.obs;
  RxDouble innerButtonHeight = 0.0.obs;
  RxDouble innerButtonWidth = 0.0.obs;
  RxDouble rotation = 0.0.obs;
  RxDouble iconSize = 0.0.obs;
  RxDouble opacity = 0.0.obs;
  RxDouble fontSize = 0.0.obs;
  void transform() {
    if (isShowBottomSheet == true) {
      width.value = SizeConfig.widthMultiplier * 75.0;
      height.value = SizeConfig.heightMultiplier * 13.0;
      innerButtonHeight.value = SizeConfig.heightMultiplier * 8;
      innerButtonWidth.value = SizeConfig.widthMultiplier * 20;
      iconSize.value = SizeConfig.heightMultiplier * 5;
      rotation.value = 45.0;
      opacity.value = 1.0;
      fontSize.value = 12.0;
    } else {
      width.value = 0.0;
      height.value = 0.0;
      innerButtonHeight.value = 0.0;
      innerButtonWidth.value = 0.0;
      iconSize.value = 0.0;
      rotation.value = 0.0;
      opacity.value = 0.0;
      fontSize.value = 0.0;
    }
  }

  //bottom sheet List
  RxList<AnimatedWraperModel> bottomsheetList = <AnimatedWraperModel>[
    AnimatedWraperModel(
        icon: Ionicons.document, title: 'Document', ),
    AnimatedWraperModel(icon: Ionicons.camera, title: 'Camera', ),
    AnimatedWraperModel(icon: Ionicons.image, title: 'Gallery', ),
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getCurrentUserData();
    super.onInit();
  }
}
