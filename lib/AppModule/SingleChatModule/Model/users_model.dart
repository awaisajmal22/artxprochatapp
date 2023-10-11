import 'package:get/get.dart';

class Message {
  String? dateTime;
  bool? isUserSide = true;
  String? msg;
  String? receiverUid;
  bool? isReaded = false;
  String? senderUid;
  String? file;
  String? emoji;
  MessageType? messageType;
  String? fmcToken;
  Message({
    this.messageType,
    this.senderUid,
    this.receiverUid,
    this.dateTime,
    this.emoji,
    this.file,
    this.isUserSide,
    this.isReaded,
    this.msg,
    this.fmcToken,
  });
  factory Message.fromJson(Map<String, dynamic> json) => Message(
        dateTime: json['dateTime'],
        msg: json['msg'],
        emoji: json['emoji'],
        receiverUid: json['receiverUID'],
        isReaded: json['isReaded'],
        senderUid: json['senderUID'],
        file: json['file'],
        fmcToken: json['fmcToken'],
        messageType: MessageType.fromJson(json['messageType']),
      );
  Map<String, dynamic> toJson() => {
        'dateTime': dateTime,
        'msg': msg,
        'emoji': emoji,
        'receiverUID': receiverUid,
        'isReaded': isReaded,
        'senderUID': senderUid,
        'file': file,
        'fmcToken': fmcToken,
        'messageType': messageType?.toJson(),
      };
}

enum MessageType {
  text,
  file;

  String toJson() => name;

  factory MessageType.fromJson(String json) => values.byName(json);
}
