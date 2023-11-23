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

import '../../../RoutesAndBindings/app_routes.dart';
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
    return GestureDetector(
      onTap: () {
        singleChatVM.isShowBottomSheet.value = false;
        singleChatVM.transform();
      },
      child: Scaffold(
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
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
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
                            onTap: () {
                              Get.toNamed(AppRoutes.audioCallView,
                                  arguments: user);
                            },
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
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
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
                                fileName:
                                    singleChatVM.messagesList[index].file ?? '',
                                date:
                                    singleChatVM.messagesList[index].dateTime!,
                                message: singleChatVM.messagesList[index].msg!,
                                messageType: singleChatVM
                                            .messagesList[index].senderUid ==
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
                          attachFile: () {
                            singleChatVM.isShowBottomSheet.value =
                                !singleChatVM.isShowBottomSheet.value;
                            singleChatVM.transform();
                          },
                          cameraImage: () {
                            singleChatVM.getImageFormCamera(
                              recieverToken: user.fmcToken!,
                              isPickedFile: true,
                              receiverUID: user.uid!,
                              currentUser: singleChatVM.currentUser.value,
                            );
                          },
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
                                  print(
                                    singleChatVM.reciever.value.fmcToken!,
                                  );
                                  singleChatVM.sendTextMessage(
                                    msg: singleChatVM.messageController.text,
                                    recieverToken:
                                        singleChatVM.reciever.value.fmcToken ??
                                            user.fmcToken!,
                                    isPickedFile: false,
                                    receiverUID:
                                        singleChatVM.reciever.value.uid!,
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
              Positioned(
                // left: 20,
                // right: SizeConfig.widthMultiplier * 20,
                bottom: SizeConfig.heightMultiplier * 8.5,
                child: gradient(
                  bottomLeftRadius: 20,
                  bottomRightRadius: 20,
                  topRightRadius: 20,
                  topleftRadius: 20,
                  child: Obx(
                    () => AnimatedContainer(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          //     horizontal: SizeConfig.widthMultiplier * 2,
                          vertical: SizeConfig.heightMultiplier * 1),
                      // transform: Matrix4.rotationZ(
                      //     singleChatVM.rotation.value * 3.1415927 / 360),
                      duration: Duration(milliseconds: 500),
                      height: singleChatVM.height.value,
                      width: singleChatVM.width.value,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Obx(
                        () => Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: List.generate(
                              growable: true,
                              singleChatVM.bottomsheetList.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  if (index == 0) {}
                                  if (index == 1) {
                                    singleChatVM.getImageFormCamera(
                                      recieverToken: user.fmcToken!,
                                      isPickedFile: true,
                                      receiverUID: user.uid!,
                                      currentUser:
                                          singleChatVM.currentUser.value,
                                    );
                                    singleChatVM.isShowBottomSheet.value =
                                        false;
                                    singleChatVM.transform();
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimatedContainer(
                                      alignment: Alignment.center,
                                      duration: Duration(milliseconds: 500),
                                      height:
                                          singleChatVM.innerButtonHeight.value,
                                      width:
                                          singleChatVM.innerButtonWidth.value,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: AnimatedOpacity(
                                        duration: Duration(milliseconds: 1000),
                                        opacity: singleChatVM.opacity.value,
                                        child: Obx(
                                          () => Container(
                                            height: singleChatVM.iconSize.value,
                                            child: Icon(
                                              singleChatVM
                                                  .bottomsheetList[index].icon,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      duration: Duration(milliseconds: 1000),
                                      opacity: singleChatVM.opacity.value,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                SizeConfig.heightMultiplier *
                                                    1),
                                        child: Text(
                                          singleChatVM
                                              .bottomsheetList[index].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontSize: singleChatVM
                                                      .fontSize.value),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
