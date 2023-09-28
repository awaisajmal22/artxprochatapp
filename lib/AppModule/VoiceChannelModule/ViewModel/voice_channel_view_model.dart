import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:artxprochatapp/AppModule/VoiceChannelModule/Model/channel_name_model.dart';
import 'package:artxprochatapp/Utils/Settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class VoiceChannelViewModel extends GetxController {
  final channelController = TextEditingController();
  RxList<ChannelNameModel> channelList = <ChannelNameModel>[].obs;
  RxList<ChannelNameModel> channelsList = <ChannelNameModel>[].obs;
  RxBool loading = false.obs;
  late RtcEngine engine;
  RxList remoteID = [].obs;
  RxDouble xPosition = 0.0.obs;
  RxDouble yPosition = 0.0.obs;
  // RxBool localUserJoined = false.obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   initializeAgora();
  //   // engine.enableLocalVideo(true);
  // }

  // @override
  // void dispose() {
  //   engine.destroy();
  //   engine.leaveChannel();
  //   super.dispose();
  // }

  // Future<void> initializeAgora() async {
  //   loading.value = true;
  //   engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
  //   await engine.enableVideo();
  //   // await engine.startPreview();
  //   await engine.setChannelProfile(ChannelProfile.Communication);
  //   engine.setEventHandler(RtcEngineEventHandler(
  //     joinChannelSuccess: (channel, uid, elapsed) {
  //       print('channel joined');
  //     },
  //     userJoined: (uid, elapsed) {
  //       remoteID.add(uid);
  //     },
  //     userOffline: (uid, reason) {
  //       remoteID.remove(uid);
  //     },
  //   ));
  // }

  // void joinChannel(String channelName) async {
  //   try {
  //     await engine.joinChannel(null, channelName.trim(), null, 0).then((value) {
  //       loading.value = false;
  //     });
  //   } catch (e) {
  //     print('Error joining channel: $e');
  //   }
  // }
}
