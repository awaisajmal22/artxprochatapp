import 'dart:io';

import 'package:artxprochatapp/Utils/Toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../Model/bottom_sheet_model.dart';
import '../Model/user_model.dart';

class SignUpViewModel extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxString imagePath = ''.obs;
  final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
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

  List<BottomSheetModel> bottomSheetList = <BottomSheetModel>[
    BottomSheetModel(title: 'Take a photo', leadingIcon: Icons.camera_alt),
    BottomSheetModel(title: 'Your Photo', leadingIcon: Icons.browse_gallery),
    BottomSheetModel(title: 'Delete current photo', leadingIcon: Icons.delete),
  ];
  final auth = FirebaseAuth.instance;

  signUp(String email, String password, String name, String image) async {
    if (name.length < 3) {
      return toast(
          title: 'Please Enter Valid Name..', backgroundColor: Colors.black);
    }
    if (!emailValid.hasMatch(email)) {
      return toast(
          title: 'Please Enter Valid Email..', backgroundColor: Colors.black);
    } else if (password.length < 4) {
      return toast(
          title: 'Password Length must be more than 4 Characters..',
          backgroundColor: Colors.black);
    } else if (image == '') {
      return toast(
          title: "please Select an Image..", backgroundColor: Colors.black);
    } else {
      try {
        await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          createAccount(
              profileImage: File(image),
              email: email,
              password: password,
              name: name);
        });
      } catch (e) {
        String characterToRemoveBefore = "]";
        int index = e.toString().indexOf(characterToRemoveBefore);
        return toast(
            title: e.toString().substring(index + 1),
            backgroundColor: Colors.black);
      }
    }
  }

  void createAccount({
    required File profileImage,
    required String email,
    required String password,
    required String name,
  }) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    UserModel userModel = UserModel();
    final img = profileImage;
    Reference storage = await FirebaseStorage.instance.ref().child(
        'profile/[profile-${DateTime.now().microsecondsSinceEpoch.toString()}');
    await storage.putFile(img);
    String imageUrl = await storage.getDownloadURL();

    userModel.image = imageUrl;
    userModel.email = user!.email;
    userModel.name = name;
    userModel.uid = user.uid;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    toast(
        title: "Account Created Successfully :", backgroundColor: Colors.black);
    Get.offAllNamed(AppRoutes.loginView);
  }
}
