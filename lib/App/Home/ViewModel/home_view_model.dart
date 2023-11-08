import 'package:artxprochatapp/App/Auth/Signup/Model/user_model.dart';
import 'package:artxprochatapp/App/CreatGroup/Model/group_model.dart';
import 'package:artxprochatapp/App/Home/Model/wraper_tab_model.dart';
import 'package:artxprochatapp/App/Services/firebase_services.dart';
import 'package:artxprochatapp/App/SingleChat/ViewModel/single_chat_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/Models/popUpMenu_model.dart';
import '../../../Utils/SizeConfig/size_config.dart';
import '../../SingleChat/Model/message_model.dart';
import '../Model/specific_message_model.dart';

class HomeViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  final searchController = TextEditingController();
  RxBool onCancel = false.obs;
  final currentUser = FirebaseAuth.instance.currentUser;
  late TabController tabController;
  RxInt selectedWraper = 0.obs;
  RxBool isSelectWraper = false.obs;
  RxBool isSearchBarShow = false.obs;
  final scrollController = ScrollController();
  List<String> dropDownList = <String>['New Group', 'Settings'].obs;
  List<Tab> tabs = [
    Tab(
      height: SizeConfig.heightMultiplier * 5.85,
      icon: Icon(
        Ionicons.chatbox,
      ),
    ),
    Tab(
      height: SizeConfig.heightMultiplier * 5.85,
      icon: Icon(Ionicons.people),
    )
  ];
  RxList<UserModel> usersList = <UserModel>[].obs;
  RxList<UserModel> userChatList = <UserModel>[].obs;
  RxBool isLoadingChatView = true.obs;

  getUsersList() async {
    userChatList.value =
        await FirebaseUserServices().getUsersList().whenComplete(() {
      isLoadingChatView.value = false;
      print(true);
      if (userChatList.isNotEmpty) {
        // loading.value = false;

        print('user List is not Empty');
        for (var data in userChatList) {
          if (data.uid != currentUser!.uid) {
            usersList.value = userChatList;
            isLoadingChatView.value = false;
          }
        }
      }
    });
  }

  RxList<SpecificMsgModel> specificMessagesList = <SpecificMsgModel>[].obs;
  RxList<String> specificMessagesIntList = <String>[].obs;
  Future getSpecificMessages() async {
    print(FirebaseAuth.instance.currentUser!.uid);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      specificMessagesList.clear();
      specificMessagesIntList.clear();

      specificMessagesList.value =
          event.docs.map((e) => SpecificMsgModel.fromJson(e.data())).toList();
      print(specificMessagesList.length);
      for (int i = 0; i < userChatList.length; i++) {
        for (int x = 0; x < specificMessagesList.length; x++) {
          if (userChatList[i].uid == specificMessagesList[x].uid) {
            specificMessagesIntList.add(specificMessagesList[x].uid!);
            print(specificMessagesIntList.length);
          }
        }
      }
    });

    // });
  }

  RxBool isPersonAddedToGroup = false.obs;
  RxList<GroupModel> groupsList = <GroupModel>[].obs;
  RxInt groupMembersIndex = 0.obs;
  RxList<UserModel> groupMembersList = <UserModel>[].obs;
  getGroupsList() async {
    groupsList.value = await FirebaseGroupServices().getGroupsList();
    print(groupsList.length);
  }

  List<PopupMenuModel> popUpMenuList = <PopupMenuModel>[
    PopupMenuModel(icon: Icons.star, key: 1, title: 'New Group'),
    PopupMenuModel(icon: Icons.settings, key: 2, title: 'Settings'),
    PopupMenuModel(icon: Icons.logout, key: 3, title: 'Logout'),
  ];
  final databaseReference = FirebaseFirestore.instance.collection('users');
  signOut() async {
    final current = currentUser!.uid;

    if (current == null) {
      return;
    }

    final userRef = databaseReference.doc(current);
    userRef.update({
      "isOnline": false,
      "lastActive": FieldValue.serverTimestamp(),
      "fmcToken": '',
    }).then((value) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', '');
      await prefs.setString('password', '');
      await prefs.setString('uid', '');
      await FirebaseAuth.instance
          .signOut()
          .whenComplete(() => Get.offAllNamed(AppRoutes.loginView));
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: tabs.length, vsync: this);

    getUsersList();
    getGroupsList();
    getSpecificMessages();
    super.onInit();

    scrollController.addListener(
      () {
        if (isSelectWraper.value == false) {
          isSearchBarShow.value = false;
          searchController.clear();
          onCancel.value = false;
        }
      },
    );
  }

  RxList<WraperModel> wraperList = <WraperModel>[
    WraperModel(icon: Ionicons.link, title: "Links"),
    WraperModel(icon: Ionicons.document, title: "Documents"),
    WraperModel(icon: Ionicons.image, title: "Meida"),
  ].obs;
}
