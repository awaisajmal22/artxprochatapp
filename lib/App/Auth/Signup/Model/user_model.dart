import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? image;
  bool? isMessage;
  Timestamp? lastActive;
  bool? isOnline;
  String? fmcToken;
  bool? isAdmin;
  String? lastMessage;

  UserModel({
    this.email,
    this.name,
    this.password,
    this.uid,
    this.image,
    this.lastActive,
    this.isOnline,
    this.isMessage,
    this.fmcToken,
    this.isAdmin,
    this.lastMessage,
  });
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'] ?? '',
        lastMessage: map['lastMessage'] ?? '',
        email: map['email'] ?? '',
        name: map['name'] ?? '',
        password: map['password'] ?? '',
        image: map['image'] ?? '',
        isMessage: map['isMessage'] ?? false,
        isOnline: map['isOnline'] ?? false,
        fmcToken: map['fmcToken'],
        isAdmin: map["isAdmin"] ?? false,
        lastActive: map['lastActive']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'lastMessage': lastMessage,
      'name': name,
      'password': password,
      'image': image,
      'isOnline': isOnline,
      'fmcToken': fmcToken,
      'isMessage': isMessage,
      'lastActive': lastActive,
      "isAdmin": isAdmin
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "password": password,
      'lastMessage': lastMessage,
      "image": image,
      "isOnline": isOnline,
      "isMessage": isMessage,
      'fmcToken': fmcToken,
      "lastActive": lastActive,
      "isAdmin": isAdmin
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
