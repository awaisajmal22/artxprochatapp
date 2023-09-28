import 'dart:convert';

import 'package:get/get.dart';

List<GroupChatModel> groupChatModelFromJson(String str) =>
    List<GroupChatModel>.from(
        json.decode(str).map((x) => GroupChatModel.fromJson(x))).obs;

String groupChatModelToJson(List<GroupChatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupChatModel {
  String? groupName;
  RxList<Users>? user;

  GroupChatModel({
    this.groupName,
    this.user,
  });

  factory GroupChatModel.fromJson(Map<String, dynamic> json) => GroupChatModel(
        groupName: json["groupName"],
        user: List<Users>.from(json["user"].map((x) => Users.fromJson(x))).obs,
      );

  Map<String, dynamic> toJson() => {
        "groupName": groupName,
        "user": List<dynamic>.from(user!.map((x) => x.toJson())),
      };
}

class Users {
  String? name;
  int? id;
  String? image;
  RxBool? isAdd;
  Users({
    this.name,
    this.image,
    this.id,
    this.isAdd,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
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
