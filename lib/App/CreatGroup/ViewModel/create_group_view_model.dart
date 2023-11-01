import 'dart:io';

import 'package:artxprochatapp/App/Auth/Signup/Model/bottom_sheet_model.dart';
import 'package:artxprochatapp/App/Home/ViewModel/home_view_model.dart';
import 'package:artxprochatapp/App/Services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../Auth/Signup/Model/user_model.dart';
import '../Model/group_model.dart';

class CreateGroupViewModel extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController groupNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxList<UserModel> usersList = <UserModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool isSearch = false.obs;
  RxList<UserModel> filteredUsers = <UserModel>[].obs;
  RxList<UserModel> groupUserList = <UserModel>[].obs;
  void filterUsers(String query) {
    filteredUsers.value = usersList
        .where((user) => user.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  getUsers() async {
    usersList.value = await FirebaseUserServices().getUsersList();

    if (usersList.isNotEmpty || usersList != null) {
      isLoading.value = false;
      filteredUsers.value = usersList;
    }
  }

  RxString imagePath = ''.obs;
  final pickedImage = ImagePicker();
  Future getImageFormCamera() async {
    final selectedImage =
        await pickedImage.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      imagePath.value = selectedImage.path;
    }
  }

  Future getImageFormStorage() async {
    final selectedImage =
        await pickedImage.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      imagePath.value = selectedImage.path;
    }
  }

  Rx<UserModel> currentUserData = UserModel().obs;
  getCurrentUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .snapshots()
        .listen((data) {
      if (data.exists) {
        final model = UserModel.fromJson(data.data() as Map<String, dynamic>);
        currentUserData.value = model;
      }
    });
  }

  creatGroup({
    required String groupName,
    required String groupImage,
    required List<UserModel> selectedUsers,
  }) async {
    if (groupName.isNotEmpty && groupImage.isNotEmpty) {
      if (groupImage != null || groupImage != '') {
        Reference storage = FirebaseStorage.instance.ref().child(
            'Groups/[image-${DateTime.now().microsecondsSinceEpoch.toString()}');
        await storage.putFile(File(groupImage));

        await storage.getDownloadURL().then((picture) {
          UserModel currentUser = UserModel(
            fmcToken: currentUserData.value.fmcToken,
            image: currentUserData.value.image,
            // textOnlyAdmin: false,
            isAdmin: true,
            email: currentUserData.value.email,
            isOnline: currentUserData.value.isOnline,
            lastActive: currentUserData.value.lastActive,
            name: currentUserData.value.name,
            uid: currentUserData.value.uid,
            // isAddedToGroup: true
          );
          selectedUsers.insert(0, currentUser);
          final groupModel = GroupModel(
              uid: [FirebaseAuth.instance.currentUser!.uid],
              groupImage: picture,
              groupName: groupName,
              dateTime: DateTime.now().toIso8601String(),
              members: selectedUsers);
          FirebaseGroupServices().createGroup(
            model: groupModel,
          );
          imagePath.value = '';
          Get.offAllNamed(AppRoutes.homeView);
          groupUserList.value = [];
          groupNameController.clear();
          final homeVM = Get.put(HomeViewModel());
          homeVM.getGroupsList();
        });
      }
    }
  }

  List<BottomSheetModel> bottomSheetList = <BottomSheetModel>[
    BottomSheetModel(title: 'Take a photo', leadingIcon: Icons.camera_alt),
    BottomSheetModel(title: 'Your Photo', leadingIcon: Icons.browse_gallery),
    BottomSheetModel(title: 'Delete current photo', leadingIcon: Icons.delete),
  ];
  @override
  void onInit() {
    // TODO: implement onInit
    getUsers();
    getCurrentUserData();
    super.onInit();
  }
}
