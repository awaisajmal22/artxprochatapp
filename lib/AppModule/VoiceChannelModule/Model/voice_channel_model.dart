import 'package:flutter/material.dart';

class VoiceChannelModel {
  final int uid;
  String? name;
  bool? isAudioEnabled;
  bool? isVideoEnabled;
  Widget? view;

  VoiceChannelModel({
    required this.uid,
    this.name,
    this.isAudioEnabled,
    this.isVideoEnabled,
    this.view,
  });
}