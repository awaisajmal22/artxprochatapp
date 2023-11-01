import 'dart:math';

import 'package:artxprochatapp/App/Auth/Signup/Model/user_model.dart';
import 'package:artxprochatapp/App/SingleChat/View/component/emoji_picker.dart';
import 'package:artxprochatapp/App/SingleChat/ViewModel/single_chat_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../Utils/AppGradient/gradient.dart';
import '../../../Utils/PopupMenu/popup_menu_view.dart';
import '../../../Utils/TextField/text_form_field.dart';
import 'component/message_tile.dart';

class SingleChatView extends StatelessWidget {
  SingleChatView({super.key});
  UserModel user = Get.arguments;
  final singleChatVM = Get.find<SingleChatViewModel>();
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
                      children: [
                        Text(
                          '${user.name}',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 20,
                                    color: Theme.of(context).dividerColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          singleChatVM.reciever.value.isOnline == true
                              ? 'Online'
                              : 'Offline',
                          style: TextStyle(
                              color:
                                  singleChatVM.reciever.value.isOnline == true
                                      ? Colors.green
                                      : Colors.grey),
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
                          popUpMenuList: singleChatVM.popupMenuList,
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
              () => singleChatVM.messagesList.isEmpty
                  ? Center(
                      child: Text('No Message Yet...'),
                    )
                  : ListView.builder(
                      controller: singleChatVM.scrollController,
                      itemCount: singleChatVM.messagesList.length,
                      itemBuilder: (context, index) {
                        return MessageTile(
                          message: singleChatVM.messagesList[index].msg!,
                          messageType:
                              singleChatVM.messagesList[index].senderUid ==
                                      singleChatVM.currentUserUID
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
                    isShowCamera: singleChatVM.isShowCamera.value,
                    attachFile: () {},
                    cameraImage: () {},
                    topPadding: 15,
                    context: context,
                    controller: singleChatVM.messageController,
                    hintText: 'Message...',
                    onChange: (value) {
                      if (value.isNotEmpty) {
                        singleChatVM.isShowCamera.value = false;
                      } else if (value.isEmpty) {
                        singleChatVM.isShowCamera.value = true;
                      }
                    },
                    keyboardType: TextInputType.text,
                  ),
                )),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 2,
                ),
                Obx(
                  () => singleChatVM.isShowCamera.value == true
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
                            singleChatVM.sendTextMessage(
                              msg: singleChatVM.messageController.text,
                              recieverToken:
                                  singleChatVM.reciever.value.fmcToken!,
                              isPickedFile: false,
                              receiverUID: singleChatVM.reciever.value.uid!,
                              currentUser: singleChatVM.currentUser.value,
                            );
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
            // emojiPicker(
            //     onSelectEmoji: (category, emoji) {
            //       singleChatVM.messageController.text =
            //           singleChatVM.messageController.text + emoji.emoji;
            //     },
            //     context: context,
            //     emojiShowing: singleChatVM.isEmojiShowing,
            //     controller: singleChatVM.emojiController,
            //     onBackspacePressed: singleChatVM.onBackspacePressed)
          ],
        ),
      ),
    );
  }
}
