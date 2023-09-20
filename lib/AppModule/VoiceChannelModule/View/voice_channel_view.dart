import 'package:artxprochatapp/AppModule/VoiceChannelModule/ViewModel/voice_channel_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class VoiceChannelView extends StatelessWidget {
  VoiceChannelView({Key? key}) : super(key: key);
  final voiceVM = Get.find<VoiceChannelViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            voiceVM.engine.leaveChannel();
            Get.back();
          },
          child: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blue,
        title: Text('${voiceVM.channelController.text}'),
        centerTitle: true,
      ),
      body: Obx(
        () => voiceVM.loading.value
            ? const CircularProgressIndicator()
            : Stack(
                children: [
                  Center(
                    child: _remoteVideo(
                      voiceVM: voiceVM,
                      context: context,
                    ),
                  ),
                  Container(
                    height: SizeConfig.heightMultiplier * 60,
                    width: SizeConfig.heightMultiplier * 90,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Stack(
                      children: [
                        Obx(
                          () => Positioned(
                            top: voiceVM.yPosition.value,
                            left: voiceVM.xPosition.value,
                            child: GestureDetector(
                              onPanUpdate: (value) {
                                voiceVM.yPosition.value = value.delta.dy;
                                voiceVM.xPosition.value = value.delta.dx;
                              },
                              child: SizedBox(
                                  height: SizeConfig.heightMultiplier * 10,
                                  width: SizeConfig.widthMultiplier * 20,
                                  child: const RtcLocalView.SurfaceView()),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

Widget _remoteVideo({
  required VoiceChannelViewModel voiceVM,
  required BuildContext context,
}) {
  return SizedBox(child: Obx(() {
    if (voiceVM.remoteID.isNotEmpty) {
      if (voiceVM.remoteID.length == 1) {
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: RtcRemoteView.SurfaceView(
            uid: voiceVM.remoteID[0],
            channelId: voiceVM.channelController.text,
          ),
        );
      } else if (voiceVM.remoteID.length == 2) {
        return Column(
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier * 30,
              width: double.infinity,
              child: RtcRemoteView.SurfaceView(
                uid: voiceVM.remoteID[1],
                channelId: voiceVM.channelController.text,
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 30,
              width: double.infinity,
              child: RtcRemoteView.SurfaceView(
                uid: voiceVM.remoteID[2],
                channelId: voiceVM.channelController.text,
              ),
            )
          ],
        );
      } else {
        return SizedBox(
          height: SizeConfig.heightMultiplier * 100,
          width: SizeConfig.widthMultiplier * 100,
          child: Obx(
            () => GridView.builder(
              itemCount: voiceVM.remoteID.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 11 / 20,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RtcRemoteView.SurfaceView(
                    uid: voiceVM.remoteID[index],
                    channelId: voiceVM.channelController.text,
                  ),
                );
              },
            ),
          ),
        );
      }
    } else {
      return const Center(
        child: Text('Waiting for other users to Join'),
      );
    }
  }));
}
