import 'dart:io';

import 'package:artxprochatapp/RoutesAndBindings/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Utils/SizeConfig/size_config.dart';
import '../../../VoiceChannelModule/ViewModel/voice_channel_view_model.dart';
import '../../ViewModel/home_view_model.dart';
import 'add_new_group_dailog.dart';

class userListView extends StatelessWidget {
  userListView({Key? key, required this.homeVM, })
      : super(key: key);
  
  final HomeViewModel homeVM;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Color(0xff3079E2)),
                width: SizeConfig.widthMultiplier * 30,
                height: SizeConfig.heightMultiplier * 40,
                child: ListView.builder(
                  itemCount: homeVM.userList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            homeVM.selectedTileIndex.value = index;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: homeVM.selectedTileIndex.value == index
                                    ? Color(0xff4824E0)
                                    : Colors.white30),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    homeVM.userList[index].image!,
                                    height: SizeConfig.heightMultiplier * 4,
                                    width: SizeConfig.widthMultiplier * 8,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${homeVM.userList[index].name}',
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: homeVM.selectedTileIndex.value ==
                                              index
                                          ? Colors.white
                                          : Color(0xff4824E0),
                                      fontSize:
                                          SizeConfig.textMultiplier * 1.4),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: SizeConfig.widthMultiplier * 30,
                  height: SizeConfig.heightMultiplier * 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Groups',
                        style: GoogleFonts.acme(
                            fontSize: SizeConfig.textMultiplier * 2,
                            height: SizeConfig.heightMultiplier * 0.083),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          // showAddNewGroupDailog(
                          //     context: context, homeVM: homeVM);
                          Get.toNamed(AppRoutes.voicChannelView, arguments: [
                            
                          ]);
                        },
                        onHover: (value) {
                          homeVM.addnewGroupHover.value = value;
                        },
                        child: Obx(
                          () => Container(
                            height: SizeConfig.heightMultiplier * 2,
                            width: SizeConfig.heightMultiplier * 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: homeVM.addnewGroupHover.value == false
                                    ? Color(0xff4824E0).withAlpha(150)
                                    : Colors.grey),
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                width: SizeConfig.widthMultiplier * 30,
                color: Colors.black,
              ),
              Obx(
                () => Container(
                  color: Color(0xff3079E2),
                  height: SizeConfig.heightMultiplier * 12.2,
                  width: SizeConfig.widthMultiplier * 30,
                  child: homeVM.groupChatList.isNotEmpty
                      ? Obx(
                          () => ListView.builder(
                            itemCount: homeVM.groupChatList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.groupView,
                                        arguments: [
                                          index,
                                          homeVM.groupChatList[index].groupName
                                        ]);
                                  },
                                  title: Text(
                                      "${homeVM.groupChatList[index].groupName}"));
                            },
                          ),
                        )
                      : SizedBox.shrink(),
                ),
              )
            ],
          )
        : Container(
            color: Color(0xff3079E2),
            height: SizeConfig.heightMultiplier * 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Chats',
                    style: GoogleFonts.acme(
                        fontSize: SizeConfig.textMultiplier * 3,
                        height: SizeConfig.heightMultiplier * 0.083),
                  ),
                ),
                Container(
                  height: 1,
                  width: SizeConfig.widthMultiplier * 30,
                  color: Colors.black,
                ),
                Container(
                  decoration: BoxDecoration(color: Color(0xff3079E2)),
                  width: SizeConfig.widthMultiplier * 30,
                  height: SizeConfig.heightMultiplier * 29.8,
                  child: ListView.builder(
                    itemCount: homeVM.userList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: homeVM.selectedTileIndex.value == index
                                    ? Color(0xff4824E0)
                                    : Colors.white30),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(5),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  homeVM.userList[index].image!,
                                  height: SizeConfig.heightMultiplier * 4,
                                  width: SizeConfig.widthMultiplier * 6,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              onTap: () {
                                homeVM.selectedTileIndex.value = index;
                              },
                              title: Text(
                                '${homeVM.userList[index].name}',
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color:
                                        homeVM.selectedTileIndex.value == index
                                            ? Colors.white
                                            : Color(0xff4824E0),
                                    fontSize: SizeConfig.textMultiplier * 1.4),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 1,
                  width: SizeConfig.widthMultiplier * 30,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: SizeConfig.widthMultiplier * 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Groups',
                          style: GoogleFonts.acme(
                              fontSize: SizeConfig.textMultiplier * 2,
                              height: SizeConfig.heightMultiplier * 0.083),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            // showAddNewGroupDailog(
                            //     context: context, homeVM: homeVM);
                            await [Permission.microphone, Permission.camera].request().then((value) => Get.toNamed(AppRoutes.voicChannelView, ));
                            
                          },
                          onHover: (value) {
                            homeVM.addnewGroupHover.value = value;
                          },
                          child: Obx(
                            () => Container(
                              height: SizeConfig.heightMultiplier * 2,
                              width: SizeConfig.heightMultiplier * 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: homeVM.addnewGroupHover.value == false
                                      ? Color(0xff4824E0).withAlpha(150)
                                      : Colors.grey),
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: SizeConfig.widthMultiplier * 30,
                  color: Colors.black,
                ),
                Obx(
                  () => Container(
                    color: Color(0xff3079E2),
                    height: SizeConfig.heightMultiplier * 12.2,
                    width: SizeConfig.widthMultiplier * 30,
                    child: homeVM.groupChatList.isNotEmpty
                        ? Obx(
                            () => ListView.builder(
                              itemCount: homeVM.groupChatList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.groupView,
                                          arguments: [
                                            index,
                                            homeVM
                                                .groupChatList[index].groupName
                                          ]);
                                    },
                                    title: Text(
                                        "${homeVM.groupChatList[index].groupName}"));
                              },
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                )
              ],
            ),
          );
  }
}
