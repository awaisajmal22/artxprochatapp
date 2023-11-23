import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../../../Utils/AppGradient/gradient.dart';
import '../../../../Utils/app_utils.dart';
import '../../../Auth/Signup/Model/user_model.dart';
import '../ViewModel/audio_call_view_model.dart';
import 'component/custom_avatar.dart';
import 'component/user_call.dart';

class AudioCallView extends StatelessWidget {
  UserModel userModel = Get.arguments;
  final audioCallVM = Get.find<AudioCallViewModel>();
  AudioCallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gradient(
        child: SafeArea(
          child: ZegoUIKitPrebuiltCall(
            appID: AppStatics.appID,
            appSign: AppStatics.appSignIn,
            userID: userModel.uid!,
            userName: userModel.name!,
            callID: userModel.uid!,
            controller: audioCallVM.callController,
            config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()

              ..onOnlySelfInRoom = (context) {
                Get.back();
              },
          ),
        ),
      ),
    );
  }
}
