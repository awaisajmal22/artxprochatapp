import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  String? image;
  bool? isMessage;
  FieldValue? lastActive;
  bool? isOnline;
  String? fmcToken;

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
  });
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'] ?? '',
        email: map['email'] ?? '',
        name: map['name'] ?? '',
        password: map['password'] ?? '',
        image: map['image'] ?? '',
        isMessage: map['isMessage'] ?? false,
        isOnline: map['isOnline'] ?? false,
        fmcToken: map['fmcToken'],
        lastActive: map['lastActive']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'password': password,
      'image': image,
      'isOnline': isOnline,
      'fmcToken': fmcToken,
      'isMessage': isMessage,
      'lastActive': lastActive,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "password": password,
      "image": image,
      "isOnline": isOnline,
      "isMessage": isMessage,
      'fmcToken': fmcToken,
      "lastActive": lastActive,
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
