import 'dart:io';

import 'package:artxprochatapp/AppModule/AuthModule/SignUp/Model/user_model.dart';
import 'package:artxprochatapp/AppModule/GroupChatModule/ViewModel/group_chat_view_model.dart';
import 'package:artxprochatapp/AppModule/HomeModule/View/component/single_user_chat_tile.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../HomeModule/ViewModel/home_view_model.dart';
import '../../HomeModule/View/component/add_new_group_dailog.dart';
import '../../HomeModule/View/component/input_chat_tile.dart';
import '../Model/group_chat_model.dart';
import '../Model/groups_model.dart';
import 'mobile_group_chat_view.dart';

class GroupChatView extends StatelessWidget {
  GroupChatView({Key? key}) : super(key: key);
  int groupIndex = Get.arguments[0];
  GroupsModel groupModel = Get.arguments[1];
  UserModel currentUser = Get.arguments[2];

  final homeVM = Get.find<HomeViewModel>();
  final groupVM = Get.find<GroupChatViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isWindows
          ? AppBar(
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xff3079E2),
              title: Text(groupModel.groupName!),
              centerTitle: true,
            )
          : null,
      body: Platform.isWindows
          ? Column(
              children: [
                SizedBox(
                  height: SizeConfig.heightMultiplier * 6,
                  // width: double.maxFinite,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.profileView);
                        },
                        child: Container(
                          height: SizeConfig.heightMultiplier * 5,
                          width: SizeConfig.heightMultiplier * 5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://media.istockphoto.com/id/486596655/photo/snowy-owl-yawning-smiling-in-snow.jpg?s=1024x1024&w=is&k=20&c=pQiiRs6E6as3yy9ltYEcBwjqW8gKx9GV71cHiDahFbY='),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: SizeConfig.heightMultiplier * 20,
                        height: SizeConfig.heightMultiplier * 5,
                        child: Obx(
                          () => groupVM.groupList[groupIndex].userModel!.isEmpty
                              ? const SizedBox.shrink()
                              : Stack(
                                  alignment: Alignment.centerRight,
                                  children: List.generate(
                                    groupVM.groupList[groupIndex].userModel!
                                                .length <
                                            2
                                        ? groupVM.groupList[groupIndex]
                                            .userModel!.length
                                        : groupVM.groupList[groupIndex]
                                                    .userModel!.length <
                                                3
                                            ? groupVM.groupList[groupIndex]
                                                .userModel!.length
                                            : 4,
                                    (index) => Positioned(
                                        left: index * 30,
                                        child: Container(
                                          height:
                                              SizeConfig.heightMultiplier * 5,
                                          width:
                                              SizeConfig.heightMultiplier * 5,
                                          decoration: BoxDecoration(
                                              color: index == 3
                                                  ? Colors.grey
                                                  : null,
                                              shape: BoxShape.circle,
                                              image: index == 3
                                                  ? null
                                                  : DecorationImage(
                                                      image: NetworkImage(
                                                        groupVM
                                                            .groupList[
                                                                groupIndex]
                                                            .userModel![index]
                                                            .userImage!,
                                                      ),
                                                      fit: BoxFit.cover)),
                                          child: index == 3
                                              ? Center(
                                                  child: Text(
                                                    '+${groupVM.groupList[groupIndex].userModel!.length - 3} more',
                                                    style: GoogleFonts.acme(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                        )),
                                    growable: true,
                                  )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: addMemberView(
                                    homeVM, context, groupVM.groupList.length),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.heightMultiplier * 2,
                      )
                    ],
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
            )
          : MobileGroupView(
            currentUser: currentUser,
            groupIndex: groupIndex,
              groupsModel: groupModel.obs,
              groupVM: groupVM,
            ),
    );
  }
}
