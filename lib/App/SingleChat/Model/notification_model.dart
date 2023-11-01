import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications{
  String? title;
  String? description;
  Timestamp? createdAt;
  String? id;
  String? type;
  String? subId;
  int? status;
  String? senderId;



  Notifications(
      {
        this.title,
        this.description,
        this.createdAt,
        this.id,
        this.type,
        this.subId,
        this.status,
        this.senderId
      }
      );

  static Notifications fromMap(Map<String, dynamic> map){

    Notifications noti=Notifications();
    noti.title = map['title'];
    noti.description = map['description'];
    noti.createdAt = map['createdAt'] as Timestamp;
    noti.id = map['id'];
    noti.type = map['type'];
    noti.subId = map['subId'];
    noti.status = map['status'];
    noti.senderId=map['sender_id'];
    return noti;
  }

  static Map<String,dynamic> toMap(Notifications noti){
    return {
      'title' : noti.title,
      'description' : noti.description,
      'createdAt' : noti.createdAt,
      'id' : noti.id,
      'type' : noti.type,
      'subId' : noti.subId,
      'status' : noti.status,
      'sender_id':noti.senderId
    };
  }

}

