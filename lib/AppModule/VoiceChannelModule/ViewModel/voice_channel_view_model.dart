import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:artxprochatapp/AppModule/Services/firebase_services.dart';
import 'package:artxprochatapp/AppModule/VoiceChannelModule/Model/channel_name_model.dart';
import 'package:artxprochatapp/Utils/Settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class VoiceChannelViewModel extends GetxController {
  final channelController = TextEditingController();
  RxList<ChannelNameModel> channelsList = <ChannelNameModel>[].obs;
  RxBool loading = false.obs;
  late RtcEngine engine;
  RxList remoteID = [].obs;
  RxDouble xPosition = 0.0.obs;
  RxDouble yPosition = 0.0.obs;
  getChannelsList() async {
    channelsList.value = await FirebaseChannelServices().getChannels();
  }

  createChannel({required ChannelNameModel channel}) async {
    await FirebaseChannelServices().createChannel(channel: channel);
  }

  removeChannel({required String channelName}) async {
    await FirebaseChannelServices().removeChannel(channelName: channelName);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getChannelsList();
    super.onInit();
  }
}
