// ignore: file_names
// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'package:artxprochatapp/App/SingleChat/Model/message_model.dart';
import 'package:artxprochatapp/App/SingleChat/Model/notification_model.dart';
// import 'package:artxprochatapp/AppModule/AuthModule/SignUp/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class FirebaseMessagesServices {
  static String serverToken =
      'AAAAe4QjFhY:APA91bHC6NiEDKAz89cl5xhNPnwpQnf39KZoWkyaC-a8q1pC3Oq2nnIaA4v-ih6Y4NfNahAkt9EzD2qjOJbiq0Y4k9P-AI8E7swsSatWrUYb06ZoKn47Rsso0wv6rNRmgCJAdc6H_hDI';
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static Future<Map<String, dynamic>> sendAndRetrieveMessage(
      String fcm, String title, String body, String type) async {
    print('///inside send and retrieve message, fcm token $fcm');
    await firebaseMessaging.requestPermission(
        sound: true, badge: true, alert: true, provisional: false);
    print("Here we got ::: ");
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': <String, dynamic>{
            'title': title,
            'body': body,
            'type': type,
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '${Timestamp.now().millisecondsSinceEpoch}',
            'status': 'done'
          },
          'to': fcm,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    return completer.future;
  }

  static Future saveNotification(
      Notifications notification, Message message) async {
    print('///inside save notification');
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(message.receiverUid)
        .collection('chat')
        .doc(message.senderUid)
        .collection('messages')
        .doc(message.dateTime)
        .collection('notifications')
        .doc(message.receiverUid);
    notification.id = docRef.id;
    notification.senderId = FirebaseAuth.instance.currentUser!.uid;
    notification.createdAt = Timestamp.now();
    print('///inside save notification before set  ${message.fmcToken}');
    await docRef.set(Notifications.toMap(notification));
    print('///inside save notification after set ');
    // if(user.activeStatus==2){
    //   return;
    // }
    if (message.fmcToken == null || message.fmcToken!.isEmpty) {
      return;
    }
    // if(user.showNotification==1){
    //
    //   return;
    // }
    print('///inside save notification after set ------------');

    sendAndRetrieveMessage(message.fmcToken!, notification.title!,
        notification.description!, notification.type!);
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> streamUserNotifications(
      String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .get();
  }

  addMesageToChat({
    required String receiverUID,
    required Message message,
  }) async {
    // senderUID.value = message.senderUid!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverUID)
        .collection('messages')
        .doc(message.dateTime)
        .set(message.toJson());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverUID)
        .set({
      "uid": receiverUID,
      "msg": message.msg,
      "dateTime": message.dateTime
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "isMessage": true,
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUID)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .doc(message.dateTime)
        .set(message.toJson());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUID)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "msg": message.msg,
      "dateTime": message.dateTime
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUID)
        .update({
      "isMessage": true,
    });
  }

  updateEmoji(
      {required String senderUID,
      required String emoji,
      required String docUID}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(senderUID)
        .collection('messages')
        .doc(docUID)
        .update({'emoji': emoji});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(senderUID)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .doc(docUID)
        .update({'emoji': emoji});
  }
}
