import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../../../Utils/Toast/toast.dart';

class ProfileViewModel extends GetxController {
  RxBool loading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final currentUID = FirebaseAuth.instance.currentUser!.uid;
  RxString imagePath = ''.obs;
  final pickedImage = ImagePicker();
  Future getImageFormStorage() async {
    final selectedImage =
        await pickedImage.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      imagePath.value = selectedImage.path;
    }
  }

  void updateProfile({
    required File? profileImage,
    required String? url,
    required String uid,
    required String name,
  }) async {
    loading.value = true;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    if (profileImage != null) {
      final img = profileImage;
      Reference storage = await FirebaseStorage.instance.ref().child(
          'profile/[profile-${DateTime.now().microsecondsSinceEpoch.toString()}');
      await storage.putFile(img);
      String imageUrl = await storage.getDownloadURL();

      await firebaseFirestore.collection("users").doc(uid).update({
        "image": imageUrl,
        "name": name,
      }).whenComplete(() {
        loading.value = false;
        toast(
            title: "Account Created Successfully :",
            backgroundColor: Colors.black);
      });
    } else {
      await firebaseFirestore.collection("users").doc(uid).update({
        "image": url,
        "name": name,
      }).whenComplete(() {
        loading.value = false;
        toast(
            title: "Account Created Successfully :",
            backgroundColor: Colors.black);
      });
    }
  }
}
