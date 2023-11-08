import 'dart:convert';

SpecificMsgModel SpecificMsgModelFromJson(String str) => SpecificMsgModel.fromJson(json.decode(str));

String SpecificMsgModelToJson(SpecificMsgModel data) => json.encode(data.toJson());

class SpecificMsgModel {
    String? uid;
    String? msg;

    SpecificMsgModel({
        this.uid,
        this.msg,
    });

    factory SpecificMsgModel.fromJson(Map<String, dynamic> json) => SpecificMsgModel(
        uid: json["uid"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "msg": msg,
    };
}
