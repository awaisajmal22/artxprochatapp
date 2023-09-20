import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../Utils/SizeConfig/size_config.dart';
import 'package:intl/intl.dart';

import '../../ViewModel/home_view_model.dart';

Widget singleUserChatTile({
  required bool check,
  required String msg,
  //  required String time,
  required HomeViewModel homeVM,
}) {
  return Align(
    alignment: (check == false ? Alignment.topLeft : Alignment.topRight),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ignore: unrelated_type_equality_checks
        check == false
            ? Container(
                margin: EdgeInsets.only(
                    right: SizeConfig.widthMultiplier * 1.2,
                    top: SizeConfig.heightMultiplier * 1.0),
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2016/02/22/10/06/hedgehog-1215140__340.jpg'),
                        fit: BoxFit.cover)),
              )
            : const SizedBox.shrink(),

        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                // height: msg.contains('.m4a')
                //     ? SizeConfig.heightMultiplier * 5
                //     : SizeConfig.heightMultiplier * 3,
                width: msg.contains('.m4a')
                    ? SizeConfig.widthMultiplier * 35
                    : SizeConfig.widthMultiplier * 30,
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.heightMultiplier * 1.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      topRight: const Radius.circular(10),
                      bottomRight: check == false
                          ? const Radius.circular(10)
                          : const Radius.circular(0),
                      bottomLeft: check == true
                          ? const Radius.circular(10)
                          : const Radius.circular(0)),
                  color: (check == false
                      ? Colors.blue
                      : Colors.grey.withOpacity(0.1)),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 1.5,
                  vertical: SizeConfig.heightMultiplier * 1.5,
                ),
                child: msg.contains('.m4a')
                    ? Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            homeVM.isPlaying.value == false
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    width: SizeConfig.widthMultiplier * 20,
                                    child: Slider(
                                      value: homeVM.audioPlayer.duration == null
                                          ? 0.0
                                          : homeVM.audioPlayer.duration!
                                              .inMilliseconds
                                              .toDouble(),
                                      onChanged: (onChange) {
                                        homeVM.audioPlayer.seek(
                                            (onChange / 1000).roundToDouble()
                                                as Duration);
                                      },
                                      min: 0.0,
                                      max: homeVM
                                          .audioPlayer.duration!.inMilliseconds
                                          .toDouble(),
                                    ),
                                  ),
                            // Text(
                            //   "Audio Message (${homeVM.formatDuration(homeVM.audioPlayer.duration)})",
                            //   style: TextStyle(
                            //       fontSize: SizeConfig.textMultiplier * 1.3),
                            // ),
                            GestureDetector(
                              onTap: () {
                                homeVM.isPlaying.value =
                                    !homeVM.isPlaying.value;
                                if (homeVM.isPlaying.value == true) {
                                  homeVM.playAudio(msg);
                                } else {
                                  homeVM.stopAudioPlay();
                                }
                              },
                              child: Icon(
                                homeVM.isPlaying.value == true
                                    ? Ionicons.pause
                                    : Ionicons.play,
                                size: SizeConfig.heightMultiplier * 2,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        msg,
                        maxLines: 50,
                      ),
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 1.0,
              ),
              // Text('${time}'
              // )
            ],
          ),
        ),
      ],
    ),
  );
}
