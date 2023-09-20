import 'dart:convert';

import 'package:get/get.dart';

List<GroupChatModel> groupChatModelFromJson(String str) =>
    List<GroupChatModel>.from(
        json.decode(str).map((x) => GroupChatModel.fromJson(x))).obs;

String groupChatModelToJson(List<GroupChatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupChatModel {
  String? groupName;
  RxList<User>? user;

  GroupChatModel({
    this.groupName,
    this.user,
  });

  factory GroupChatModel.fromJson(Map<String, dynamic> json) => GroupChatModel(
        groupName: json["groupName"],
        user: List<User>.from(json["user"].map((x) => User.fromJson(x))).obs,
      );

  Map<String, dynamic> toJson() => {
        "groupName": groupName,
        "user": List<dynamic>.from(user!.map((x) => x.toJson())),
      };
}

class User {
  String? name;
  int? id;
  String? image;
  RxBool? isAdd;
  User({
    this.name,
    this.image,
    this.id,
    this.isAdd,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"],
        image: json["image"],
        isAdd: json["isAdd"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "id": id,
        "isAdd": isAdd
      };
}
