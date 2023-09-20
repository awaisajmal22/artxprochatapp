import 'package:artxprochatapp/AppModule/HomeModule/Model/chat_model.dart';
import 'package:artxprochatapp/AppModule/HomeModule/ViewModel/home_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../VoiceChannelModule/ViewModel/voice_channel_view_model.dart';
import 'component/chat_list_view.dart';
import 'component/input_chat_tile.dart';
import 'component/single_user_chat_tile.dart';

class HomeView extends StatelessWidget {
  HomeView({
    Key? key,
  }) : super(key: key);
  final homeVM = Get.find<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userListView(homeVM: homeVM,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                    child: Row(
                      children: [
                        Container(
                          height: SizeConfig.heightMultiplier * 0.2,
                          width: SizeConfig.widthMultiplier * 0.2,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    homeVM
                                        .userList[
                                            homeVM.selectedTileIndex.value]
                                        .image!,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          homeVM.userList[homeVM.selectedTileIndex.value].name!,
                          style: TextStyle(
                              color: Color(0xff4824E0),
                              fontSize: SizeConfig.textMultiplier * 1.7),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier / 6.0,
                            vertical: SizeConfig.heightMultiplier / 2.0),
                        // shrinkWrap: true,
                        itemCount: homeVM.chatList.length,
                        itemBuilder: (context, oldIndex) {
                          final index = (homeVM.chatList.length - 1) - oldIndex;
                          final item = homeVM.chatList[index];
                          return singleUserChatTile(
                            homeVM: homeVM,
                            // time: item.time,
                            check: homeVM.random.value.nextBool(),
                            msg: item,
                          );
                        }),
                  ),
                ),
                Obx(
                  () => singleUserInputTile(
                    text: homeVM.buildText(context),
                    check: homeVM.isRocordingStart.value,
                    context: context,
                    saveRecording: () {
                      homeVM.stopRecording().then((value) {
                        homeVM.isRocordingStart.value = false;
                        homeVM.chatList.insert(0, value);
                        print("Path" + value);
                      });
                    },
                    stopRecording: () {
                      homeVM.stopRecording();
                      homeVM.recoder.dispose();
                      homeVM.isRocordingStart.value = false;
                    },
                    isRecording: homeVM.isRecording,
                    widget: SizedBox(
                      height: 30,
                      child: Obx(
                        () => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                homeVM.pickedData.isNotEmpty
                                    ? homeVM.pickedData.length
                                    : homeVM.pickedData.length, (index) {
                              // if (index < 3) {
                              return SizedBox(
                                height: 40,
                                width: 30,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    homeVM.getIconUsingExtension(index),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: GestureDetector(
                                              onTap: () {
                                                homeVM.pickedData
                                                    .removeAt(index);
                                                homeVM.fileExtension
                                                    .removeAt(index);
                                              },
                                              child: const Icon(
                                                Icons.close_outlined,
                                                size: 10,
                                                color: Colors.black,
                                              )),
                                        ))
                                  ],
                                ),
                              );
                              // } else {
                              //   return SizedBox.shrink();
                              // }
                            })),
                      ),
                    ),
                    filaCallBak: () {
                      homeVM.pickFiles();
                    },
                    controller: homeVM.chatIpnutController,
                    recordingvoidCallback: () {
                      homeVM.startRecording();
                      homeVM.isRocordingStart.value = true;
                    },
                    sendvoidCallback: () {
                      homeVM.chatList
                          .insert(0, homeVM.chatIpnutController.text);
                      // homeVM.newChatList.add(homeVM.chatList.firstWhere(
                      //     (element) =>
                      //         element.id ==
                      //         homeVM.userList[homeVM.selectedTileIndex.value]
                      //             .id));

                      print(homeVM.chatList.length);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
