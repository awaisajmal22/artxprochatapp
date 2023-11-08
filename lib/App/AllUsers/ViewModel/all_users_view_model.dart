import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Auth/Signup/Model/user_model.dart';
import '../../Services/firebase_services.dart';

class AllUsersViewModel extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController searchController = TextEditingController();
  RxList<UserModel> usersList = <UserModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool isSearch = false.obs;
  RxList<UserModel> filteredUsers = <UserModel>[].obs;


  void filterUsers(String query) {
    filteredUsers.value = usersList
        .where((user) => user.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  getUsers() async {
    usersList.value = await FirebaseUserServices().getUsersList2();
    // print(usersList.length);
    if (usersList.isNotEmpty || usersList != null) {
      isLoading.value = false;
      filteredUsers.value = usersList;
      //   // loading.value = false;
      //   for (var element in usersList) {
      //     if (element.isMessage == true) {
      //       userChatList.value = usersList;
    }

    //     print(usersList.length);
    //   }
    // }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getUsers();

    super.onInit();
  }
}
