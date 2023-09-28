
import 'package:get/get.dart';

class UsersModel {
  int? id;
  String? userImage;
  String? userName;
  RxBool? groupCreatedBy;
  List<Message>? message;
  UsersModel({
    this.groupCreatedBy,
    this.id,
    this.userImage,
    this.userName,
    this.message,
  });
}

class Message {
  String? dateTime;
  bool? isUserSide = true;
  String? msg;
  String? receiverUid;
  bool? isReaded = false;
  String? senderUid;
  String? file;
  MessageType? messageType;
  Message({
    this.messageType,
    this.senderUid,
    this.receiverUid,
    this.dateTime,
    this.file,
    this.isUserSide,
    this.isReaded,
    this.msg,
  });
factory Message.fromJson(Map<String, dynamic> json) =>
      Message(
        dateTime: json['dateTime'],
        msg: json['msg'],
        receiverUid: json['receiverUID'],
        isReaded: json['isReaded'],
        senderUid: json['senderUID'],
        file: json['file'],

        messageType:
            MessageType.fromJson(json['messageType']),
      );
  Map<String, dynamic> toJson() => {
        'dateTime': dateTime,
        'msg': msg,
        'receiverUID': receiverUid,
        'isReaded': isReaded,
        'senderUID': senderUid,
        'file': file,
        'messageType': messageType?.toJson(),
      };
       
}

enum MessageType {
  text,
  file;

  String toJson() => name;

  factory MessageType.fromJson(String json) =>
      values.byName(json);
}

