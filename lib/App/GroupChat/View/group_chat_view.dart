import 'dart:math';

import 'package:artxprochatapp/App/Auth/Signup/Model/user_model.dart';
import 'package:artxprochatapp/App/CreatGroup/Model/group_model.dart';
import 'package:artxprochatapp/App/GroupChat/ViewModel/group_chat_view_model.dart';
import 'package:artxprochatapp/App/SingleChat/View/component/emoji_picker.dart';
import 'package:artxprochatapp/App/SingleChat/ViewModel/single_chat_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../Utils/AppGradient/gradient.dart';
import '../../../../Utils/PopupMenu/popup_menu_view.dart';
import '../../../../Utils/TextField/text_form_field.dart';
import 'component/message_tile.dart';

class GroupChatView extends StatelessWidget {
  GroupChatView({super.key});
  GroupModel group = Get.arguments;
  final groupChatVM = Get.find<GroupChatViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: gradient(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 3,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${group.groupName}',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 20,
                                    color: Theme.of(context).dividerColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "${group.members!.length} Members",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(Ionicons.videocam),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 4,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(Ionicons.call),
                        ),
                        popUpMenu(
                          popUpMenuList: groupChatVM.popupMenuList,
                          context,
                          (value) {},
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          preferredSize: Size(SizeConfig.widthMultiplier * 100,
              SizeConfig.heightMultiplier * 6.5)),
      body: Container(
        color: Theme.of(context).dividerColor,
        child: Column(
          children: [
            Expanded(
                child: Obx(
              () => groupChatVM.messagesList.isEmpty
                  ? Center(
                      child: Text('No Message Yet...'),
                    )
                  : ListView.builder(
                      controller: groupChatVM.scrollController,
                      itemCount: groupChatVM.messagesList.length,
                      itemBuilder: (context, index) {
                        return MessageTile(
                          date: groupChatVM.messagesList[index].dateTime!,
                          message: groupChatVM.messagesList[index].msg!,
                          messageType:
                              groupChatVM.messagesList[index].senderUid ==
                                      groupChatVM.currentUserUID
                                  ? MessageType.send
                                  : MessageType.receive,
                        );
                      },
                    ),
            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: SizeConfig.widthMultiplier * 2,
                ),
                Expanded(
                    child: Obx(
                  () => chatFormField(
                    isShowCamera: groupChatVM.isShowCamera.value,
                    attachFile: () {},
                    cameraImage: () {},
                    topPadding: 15,
                    context: context,
                    controller: groupChatVM.messageController,
                    hintText: 'Message...',
                    onChange: (value) {
                      if (value.isNotEmpty) {
                        groupChatVM.isShowCamera.value = false;
                      } else if (value.isEmpty) {
                        groupChatVM.isShowCamera.value = true;
                      }
                    },
                    keyboardType: TextInputType.text,
                  ),
                )),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 2,
                ),
                Obx(
                  () => groupChatVM.isShowCamera.value == true
                      ? GestureDetector(
                          onTap: () {},
                          child: gradientCircle(
                              child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(Ionicons.mic),
                          )),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (groupChatVM.messageController.text != '') {
                              groupChatVM.sendMessage(
                                currentUser: groupChatVM.currentUserData.value,
                                msg: groupChatVM.messageController.text,
                                isPickedFile: false,
                                senderUID:
                                    FirebaseAuth.instance.currentUser!.uid,
                                groupmembers: group.members!,
                                groupName: group.groupName!,
                              );
                            }
                          },
                          child: gradientCircle(
                              child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Icon(Ionicons.send),
                          )),
                        ),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 2,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.widthMultiplier * 2,
            ),
          ],
        ),
      ),
    );
  }
}
