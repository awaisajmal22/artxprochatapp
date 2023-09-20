import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:artxprochatapp/Utils/Settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class VoiceChannelViewModel extends GetxController {
  final channelController = TextEditingController(text: 'hull'.trim());
  RxBool loading = false.obs;
  late RtcEngine engine;
  RxList remoteID = [].obs;
  RxDouble xPosition = 0.0.obs;
  RxDouble yPosition = 0.0.obs;
  RxBool localUserJoined = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeAgora();
  }

  @override
  void onClose() {
    engine.destroy();
    super.onClose();
  }

  Future<void> initializeAgora() async {
    
    loading.value = true;
    engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    await engine.enableVideo();
    await engine.startPreview();
    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {},
      userJoined: (uid, elapsed) {
        remoteID.add(uid);
      },
      userOffline: (uid, reason) {
        remoteID.remove(uid);
      },
    ));
    await engine
        .joinChannel(null, channelController.text, null, 0)
        .then((value) {
      loading.value = false;
    });
  }
}
