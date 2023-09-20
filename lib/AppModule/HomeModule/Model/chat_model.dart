// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  String? name;
  int? id;
  String? image;


  ChatModel({
    this.name,
    this.image,
    this.id,

  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        name: json["name"],
        id: json["id"],
        image: json["image"],
       
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "id": id,
       
      };
}

List<MessageModel> messageModelFromJson(String str) => List<MessageModel>.from(
    json.decode(str).map((x) => MessageModel.fromJson(x)));

String messageModelToJson(List<MessageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageModel {
  String msg;
  String time;
  RxBool isPlay;

  MessageModel({
    required this.msg,
    required this.time,
    required this.isPlay,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        msg: json["msg"],
        time: json["time"],
        isPlay: json["isPlay"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "time": time,
        "isPlay": isPlay,
      };
}
