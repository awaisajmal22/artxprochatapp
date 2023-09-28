import 'dart:io';

import 'package:artxprochatapp/AppModule/HomeModule/Model/chat_model.dart';
import 'package:artxprochatapp/AppModule/HomeModule/ViewModel/home_view_model.dart';
import 'package:artxprochatapp/RoutesAndBindings/app_routes.dart';
import 'package:artxprochatapp/Utils/CustomButton/elevated_button.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:artxprochatapp/Utils/TextField/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../../GroupChatModule/ViewModel/group_chat_view_model.dart';
import '../../SingleChatModule/ViewModel/single_chat_view_model.dart';
import '../../VoiceChannelModule/ViewModel/voice_channel_view_model.dart';
import 'component/chat_list_view.dart';
import 'component/mobile_groups_list.dart';
import 'component/input_chat_tile.dart';
import 'component/single_user_chat_tile.dart';
import 'mobile_home_view.dart';

class HomeView extends StatelessWidget {
  HomeView({
    Key? key,
  }) : super(key: key);
  final homeVM = Get.find<HomeViewModel>();
  final groupVM = Get.find<GroupChatViewModel>();
  final singleChatVM = Get.find<SingleChatViewModel>();
  final voiceVM = Get.put(VoiceChannelViewModel());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Platform.isAndroid
          ? Drawer(
              width: SizeConfig.widthMultiplier * 50,
              child: Obx(
                () => Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.profileView,
                            arguments: singleChatVM.userChatList[0]);
                      },
                      child: SizedBox(
                        height: SizeConfig.heightMultiplier * 20,
                        width: SizeConfig.widthMultiplier * 30,
                        child: Stack(
                          children: [
                            Container(
                              height: SizeConfig.heightMultiplier * 20,
                              width: SizeConfig.widthMultiplier * 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: homeVM.userData.value.image == ''
                                      ? null
                                      : DecorationImage(
                                          image: NetworkImage(
                                              homeVM.userData.value.image!),
                                          fit: BoxFit.cover)),
                              child: singleChatVM.usersList[0].userImage == ''
                                  ? Icon(Icons.person)
                                  : null,
                            ),
                            Positioned(
                                top: SizeConfig.heightMultiplier * 2,
                                left: SizeConfig.widthMultiplier * 2,
                                child: Container(
                                  height: SizeConfig.heightMultiplier * 4,
                                  width: SizeConfig.widthMultiplier * 6,
                                  decoration: BoxDecoration(
                                      color:
                                          homeVM.userData.value.isOnline == true
                                              ? Colors.green
                                              : Colors.grey,
                                      shape: BoxShape.circle),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    Text(
                      homeVM.userData.value.name!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Obx(
                      () => Column(
                        children: List.generate(
                          homeVM.mobileTileList.length,
                          (index) => ListTile(
                            onTap: () {
                              print("Print" + "${voiceVM.channelList.length}");
                              homeVM.mobileTileList[index].onTap!();
                              homeVM.selectedMobileTileIndex.value = index;
                            },
                            tileColor:
                                homeVM.selectedMobileTileIndex.value == index
                                    ? Colors.white.withAlpha(150)
                                    : Colors.black,
                            leading: Icon(
                              homeVM.mobileTileList[index].icon,
                              color:
                                  homeVM.selectedMobileTileIndex.value == index
                                      ? Colors.black
                                      : Colors.white,
                            ),
                            title: Text(
                              homeVM.mobileTileList[index].title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: homeVM.selectedMobileTileIndex
                                                  .value ==
                                              index
                                          ? Colors.black
                                          : Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 10),
                      child: CustomElevatedButton(
                          title: 'Logout',
                          onPressed: () {
                            homeVM.signOut();
                          }),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    )
                  ],
                ),
              ),
            )
          : null,
      key: _scaffoldKey,
      body: Platform.isWindows
          ? SafeArea(
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userListView(
                  homeVM: homeVM,
                ),
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
                                              .userList[homeVM
                                                  .selectedTileIndex.value]
                                              .image!,
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                homeVM.userList[homeVM.selectedTileIndex.value]
                                    .name!,
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
                                final index =
                                    (homeVM.chatList.length - 1) - oldIndex;
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
            ))
          : MobileHomeView(
              singleChatVM: singleChatVM,
              homeVM: homeVM,
              scaffoldKey: _scaffoldKey,
              groupVM: groupVM),
    );
  }
}
