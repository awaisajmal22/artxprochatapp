import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/Toast/toast.dart';

class LoginViewModel extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseFirestore.instance.collection('users');
  void loginAccount({required String email, required String password}) async {
    if (!emailValid.hasMatch(email)) {
      toast(title: 'Please Enter Valid Email', backgroundColor: Colors.black);
    } else if (password.length < 4) {
      return toast(
          title: 'Please  Enter Valid Password', backgroundColor: Colors.black);
    } else {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        await prefs.setString('password', password);
        await prefs.setString('uid', uid.user!.uid);
        if (uid == null) {
          return;
        }
        final fcmToken = await FirebaseMessaging.instance.getToken();
        final userRef = databaseReference.doc(uid.user!.uid);
        userRef.update(
            {"isOnline": true, "lastActive": FieldValue.serverTimestamp(), "fmcToken": fcmToken});
        Get.offAllNamed(AppRoutes.homeView);
      }).catchError((e) {
        String characterToRemoveBefore = "]";
        int index = e.toString().indexOf(characterToRemoveBefore);
        toast(
            title: e.toString().substring(index + 1),
            backgroundColor: Colors.black);
      });
    }
  }
}
