import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/Toast/toast.dart';

class SplashViewModel extends GetxController {
  Timer? timer;

  @override
  void onInit() {
    timer = Timer(const Duration(seconds: 2), () {
      checkUser();
      
    });
  }

  final _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseFirestore.instance.collection('users');
  checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    final prefemail = prefs.getString('email');
    final prefpassword = prefs.getString('password');
    if (prefemail != null && prefpassword != null) {
      if (prefemail != '' && prefpassword != '') {
        await _auth
            .signInWithEmailAndPassword(
                email: prefemail, password: prefpassword)
            .then((uid) async {
          if (uid == null) {
            return;
          }
          final userRef = databaseReference.doc(uid.user!.uid);
          userRef.update(
              {"isOnline": true, "lastActive": FieldValue.serverTimestamp()});
          Get.offAllNamed(AppRoutes.homeView);
        }).catchError((e) {
          String characterToRemoveBefore = "]";
          int index = e.toString().indexOf(characterToRemoveBefore);
          toast(
              title: e.toString().substring(index + 1),
              backgroundColor: Colors.black);
          Get.offAllNamed(AppRoutes.loginView);
        });
      } else {
        Get.offAllNamed(AppRoutes.loginView);
      }
    } else {
      Get.offAllNamed(AppRoutes.loginView);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }
}
