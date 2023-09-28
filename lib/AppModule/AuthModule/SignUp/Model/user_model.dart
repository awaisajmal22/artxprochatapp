import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? image;
  Timestamp? lastActive;
  bool? isOnline;

  UserModel({
    this.email,
    this.name,
    this.password,
    this.uid,
    this.image,
    this.lastActive,
    this.isOnline,
  });
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      image: map['image'] ?? '',
      isOnline: map['isOnline'] ?? false,
      lastActive: map['lastActive'] 
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'password': password,
      'image': image,
      'isOnline': isOnline,
      'lastActive': lastActive,
    };
  }
}

class Messages {
  String? sendUid;
  String? receiverUid;
  String? dateTime;
  bool? isUserSide = true;
  String? msg;
  bool? isReaded = true;
  String? file;
  Messages({
    this.sendUid,
    this.receiverUid,
    this.dateTime,
    this.file,
    this.isUserSide,
    this.isReaded,
    this.msg,
  });
}
