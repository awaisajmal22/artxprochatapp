import 'dart:io';

import 'package:artxprochatapp/AppModule/VoiceChannelModule/ViewModel/voice_channel_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/CustomButton/elevated_button.dart';
import '../../../../Utils/TextField/text_form_field.dart';
import '../../../../Utils/Toast/toast.dart';
import '../../Model/channel_name_model.dart';

voiceChannelDialog({
  required BuildContext context,
}) {
  final voiceVM = Get.put(VoiceChannelViewModel());
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(SizeConfig.widthMultiplier * 12)),
        backgroundColor: Colors.blue,
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(SizeConfig.widthMultiplier * 12),
            color: Colors.blue,
          ),
          height: SizeConfig.heightMultiplier * 30,
          width: SizeConfig.widthMultiplier * 80,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(SizeConfig.widthMultiplier * 3),
            child: Column(
              children: [
                customFormField(
                    context: context,
                    controller: voiceVM.channelController,
                    hintText: 'Add Channel Name',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                CustomElevatedButton(
                  onPressed: () async {
                    await [Permission.camera, Permission.microphone]
                        .request()
                        .then((value) {
                      if (voiceVM.channelController.text.isEmpty) {
                        if (Platform.isAndroid) {
                          
                          toast(title: 'Please Enter the Channel Name..',textColor: Colors.black,);
                        } else if (Platform.isWindows) {
                          showSnackBar(
                          
                              context: context,
                              title: 'Please Enter the Channel Name..');
                        }
                      } else if (voiceVM.channelsList
                          .contains(voiceVM.channelController.text.trim())) {
                        if (Platform.isAndroid) {
                          toast(
                            textColor: Colors.black,
                              title:
                                  'Try another name this Channel is Already Created..');
                        }else if(Platform.isWindows){
                           showSnackBar(
                              context: context,
                              title: 'Try another name this Channel is Already Created..');
                        }
                      } else {
                        // voiceVM
                        //     .joinChannel(voiceVM.channelController.text.trim());
                        voiceVM.channelsList
                            .add(ChannelNameModel(channelName: voiceVM.channelController.text));
                        Get.back();
                        Get.toNamed(
                          AppRoutes.voicChannelView,
                        )?.then((value) {
                          voiceVM.channelController.clear();
                        });

                        print(voiceVM.channelsList.length);
                      }
                    });
                  },
                  title: 'Create',
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
