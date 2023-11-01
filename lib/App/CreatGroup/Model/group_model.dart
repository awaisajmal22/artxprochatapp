import 'dart:convert';

import 'package:artxprochatapp/App/Auth/Signup/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String? groupImage;
  String? groupName;
  List<String>? uid;
  List<UserModel>? members;

  String? dateTime;
  GroupModel(
      {this.groupImage, this.groupName, this.dateTime, this.uid, this.members});

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    var list = json['members'] as List;
    var uidList = json["uid"] as List;
    List<UserModel> membersList =
        list.map((userJson) => UserModel.fromJson(userJson)).toList();
    List<String> uids = uidList.map((e) => e.toString()).toList();
    return GroupModel(
      groupImage: json["groupImage"],
      groupName: json["groupName"],
      dateTime: json["dateTime"],
      uid: uids,
      members: membersList,
    );
  }

  Map<String, dynamic> toJson() => {
        "groupImage": groupImage,
        "groupName": groupName,
        "dateTime": dateTime,
        "uid": uid!.map((e) => e).toList(),
        "members": members!.map((member) => member.toMap()).toList()
      };
}

List<GroupsModel> GroupsModelFromJson(String str) => List<GroupsModel>.from(
    json.decode(str).map((x) => GroupsModel.fromJson(x)));

String GroupsModelToJson(List<GroupsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupsModel {
  String? groupImage;
  String? groupName;
  List<String>? uid;
  List<GroupUserModel>? members;

  String? dateTime;
  GroupsModel(
      {this.groupImage, this.groupName, this.dateTime, this.uid, this.members});

  factory GroupsModel.fromJson(Map<String, dynamic> json) {
    var list = json['members'] as List;
    var uidList = json["uid"] as List;
    List<GroupUserModel> membersList =
        list.map((userJson) => GroupUserModel.fromJson(userJson)).toList();
    List<String> uids = uidList.map((e) => e.toString()).toList();
    return GroupsModel(
      groupImage: json["groupImage"],
      groupName: json["groupName"],
      dateTime: json["dateTime"],
      uid: uids,
      members: membersList,
    );
  }

  Map<String, dynamic> toJson() => {
        "groupImage": groupImage,
        "groupName": groupName,
        "dateTime": dateTime,
        "uid": uid!.map((e) => e).toList(),
        "members": members!.map((member) => member.toJson()).toList()
      };
}



class GroupUserModel {
  String? uid;
  String? name;
  bool? isAdmin;
  bool? textOnlyAdmin;
  String? image;
  String? email;
  Timestamp? lastActive;
  bool? isOnline;
  bool? isAddedToGroup;
  String? fcmToken;
  GroupUserModel({
    this.name,
    this.isAdmin,
    this.uid,
    this.image,
    this.lastActive,
    this.isOnline,
    this.isAddedToGroup,
    this.fcmToken,
    this.textOnlyAdmin,
    this.email,
  });
  factory GroupUserModel.fromJson(Map<String, dynamic> map) {
    return GroupUserModel(
        uid: map['uid'] ?? '',
        isAdmin: map['isAdmin'] ?? false,
        name: map['name'] ?? '',
        image: map['image'] ?? '',
        isOnline: map['isOnline'] ?? false,
        email: map['email'],
        textOnlyAdmin: map['textOnlyAdmin'] ?? false,
        isAddedToGroup: map["isAddedToGroup"] ?? false,
        fcmToken: map['fcmToken'],
        lastActive: map['lastActive']);
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'isAdmin': isAdmin,
      'name': name,
      'image': image,
      'isOnline': isOnline,
      'email': email,
      'textOnlyAdmin': textOnlyAdmin,
      "isAddedToGroup": isAddedToGroup,
      'lastActive': lastActive,
      'fcmToken': fcmToken,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "isAdmin": isAdmin,
      "name": name,
      "image": image,
      'textOnlyAdmin': textOnlyAdmin,
      "isAddedToGroup": isAddedToGroup,
      "isOnline": isOnline,
      'email': email,
      "lastActive": lastActive,
      "fcmToken": fcmToken,
    };
  }
}

class GroupMessages {
  String? dateTime;
  bool? isUserSide = true;
  String? msg;
  bool? isReaded = false;
  String? senderUid;
  String? file;
  String? emoji;
  String? image;
  List<String>? fcmToken;
  List<String>? reciverUid;
  GroupMessageType? groupMessagesType;
  GroupMessages({
    this.senderUid,
    this.dateTime,
    this.emoji,
    this.file,
    this.isUserSide,
    this.isReaded,
    this.msg,
    this.fcmToken,
    this.image,
    this.reciverUid,
    this.groupMessagesType,
  });
  factory GroupMessages.fromJson(Map<String, dynamic> json) {
    final List<dynamic> receiversJson = json['receivers'] ?? [];
    final List<String> receivers =
        receiversJson.map((receiver) => receiver.toString()).toList();
    final List<dynamic> fcmTokenJson = json['fcmToken'] ?? [];
    final List<String> fcmTokens =
        fcmTokenJson.map((token) => token.toString()).toList();
    return GroupMessages(
        dateTime: json['dateTime'],
        msg: json['msg'],
        image: json['image'],
        emoji: json['emoji'],
        isReaded: json['isReaded'],
        senderUid: json['senderUID'],
        file: json['file'],
        fcmToken: fcmTokens,
        groupMessagesType: GroupMessageType.fromJson(json['GroupMessagesType']),
        reciverUid: receivers);
  }
  Map<String, dynamic> toJson() {
    final List<String> receiversJson =
        reciverUid!.map((receiver) => receiver).toList();
    final List<String> fcmTokenJson =
        fcmToken!.map((fcmToken) => fcmToken).toList();
    return {
      'dateTime': dateTime,
      'msg': msg,
      'emoji': emoji,
      'image': image,
      'isReaded': isReaded,
      'senderUID': senderUid,
      'file': file,
      'GroupMessagesType': groupMessagesType?.toJson(),
      'receivers': receiversJson,
      'fcmToken': fcmTokenJson,
    };
  }
}

enum GroupMessageType {
  text,
  file;

  String toJson() => name;

  factory GroupMessageType.fromJson(String json) => values.byName(json);
}
