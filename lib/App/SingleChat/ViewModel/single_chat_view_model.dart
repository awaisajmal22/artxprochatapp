import 'package:artxprochatapp/App/Auth/Signup/Model/user_model.dart';
import 'package:artxprochatapp/App/Services/single_chat_notification_firebase_services.dart';
import 'package:artxprochatapp/App/SingleChat/Model/message_model.dart';
import 'package:artxprochatapp/App/SingleChat/Model/notification_model.dart';
import 'package:artxprochatapp/Utils/Models/popUpMenu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class SingleChatViewModel extends GetxController {
  TextEditingController messageController = TextEditingController();
  TextEditingController emojiController = TextEditingController();
  List<PopupMenuModel> popupMenuList = <PopupMenuModel>[
    PopupMenuModel(icon: Icons.person, key: 1, title: 'View Profile'),
    PopupMenuModel(icon: Ionicons.link, key: 2, title: 'Media, Links & Docs'),
  ];
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

  Rx<UserModel> reciever = UserModel().obs;
  UserModel? getUserByID({required String uid}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .listen((user) {
      reciever.value = UserModel.fromJson(user.data()!);
    });
    return reciever.value;
  }

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

  final scrollController = ScrollController();
  void scrollDOwn() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getCurrentUserData();
    super.onInit();
  }
}
