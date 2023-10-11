import 'dart:io';
import 'dart:typed_data';

import 'package:artxprochatapp/RoutesAndBindings/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import '../../../Utils/SizeConfig/size_config.dart';
import '../../../Utils/TextField/text_form_field.dart';
import '../../AuthModule/SignUp/Model/user_model.dart';
import '../../HomeModule/ViewModel/home_view_model.dart';
import '../Model/users_model.dart';
import '../ViewModel/single_chat_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SingleChatView extends StatelessWidget {
  SingleChatView({
    Key? key,
  }) : super(key: key);
  final singleChatVM = Get.find<SingleChatViewModel>();
  final homeVM = Get.find<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => singleChatVM.singleUser.value.uid == null
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 3),
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: SizeConfig.heightMultiplier * 6,
                              width: SizeConfig.widthMultiplier * 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/Group.png'),
                                      fit: BoxFit.cover),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 2, // Spread radius
                                      blurRadius: 5, // Blur radius
                                      offset: Offset(0,
                                          3), // Offset in the x and y directions
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 3,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.profileView,
                                  arguments: singleChatVM.singleUser);
                            },
                            child: Container(
                              height: SizeConfig.heightMultiplier * 6,
                              width: SizeConfig.widthMultiplier * 10,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          singleChatVM.singleUser.value.image!),
                                      fit: BoxFit.cover),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 2, // Spread radius
                                      blurRadius: 5, // Blur radius
                                      offset: Offset(0,
                                          3), // Offset in the x and y directions
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 2,
                          ),
                          Column(
                            children: [
                              Text(
                                singleChatVM.singleUser.value.name!,
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2.4),
                              ),
                              Text(
                                singleChatVM.singleUser.value.isOnline == true
                                    ? 'Online'
                                    : 'Offline',
                                style: TextStyle(
                                    color: singleChatVM
                                                .singleUser.value.isOnline ==
                                            true
                                        ? Colors.green
                                        : Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1,
                      ),
                      Expanded(
                        child: Obx(
                          () => ListView.builder(
                            controller: singleChatVM.scrollController,
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4),
                            itemCount: singleChatVM.messagesList.length,
                            itemBuilder: (context, index) {
                              final isMe = singleChatVM
                                      .messagesList[index].receiverUid !=
                                  singleChatVM.currentUser!.uid;
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: SizeConfig.widthMultiplier * 20,
                                      maxWidth: SizeConfig.widthMultiplier * 70,
                                    ),
                                    child: Stack(
                                      alignment: isMe
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      children: [
                                        Column(
                                          children: [
                                            singleChatVM.messagesList[index]
                                                        .file !=
                                                    null
                                                ? Obx(
                                                    () => SizedBox(
                                                      height: SizeConfig
                                                              .widthMultiplier *
                                                          40,
                                                      width: SizeConfig
                                                              .widthMultiplier *
                                                          30,
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .widthMultiplier *
                                                                30,
                                                            width: SizeConfig
                                                                    .widthMultiplier *
                                                                30,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              child: singleChatVM.messagesList[index].msg!.contains('png') ||
                                                                      singleChatVM
                                                                          .messagesList[
                                                                              index]
                                                                          .msg!
                                                                          .contains(
                                                                              'jpeg') ||
                                                                      singleChatVM
                                                                          .messagesList[
                                                                              index]
                                                                          .msg!
                                                                          .contains(
                                                                              'jpg')
                                                                  ? Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        Image
                                                                            .network(
                                                                          singleChatVM
                                                                              .messagesList[index]
                                                                              .file!,
                                                                          height:
                                                                              SizeConfig.widthMultiplier * 30,
                                                                          width:
                                                                              SizeConfig.widthMultiplier * 30,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        Positioned(
                                                                          top:
                                                                              10,
                                                                          left:
                                                                              10,
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              singleChatVM.downloadFile(singleChatVM.messagesList[index].file!, singleChatVM.messagesList[index].msg!);
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.download,
                                                                              color: Colors.red,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          singleChatVM.getImageAccordingExtension(singleChatVM
                                                                              .messagesList[index]
                                                                              .msg!),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              SizeConfig.widthMultiplier * 30,
                                                                          width:
                                                                              SizeConfig.widthMultiplier * 30,
                                                                        ),
                                                                        Positioned(
                                                                          top:
                                                                              10,
                                                                          left:
                                                                              10,
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              singleChatVM.downloadFile(singleChatVM.messagesList[index].file!, singleChatVM.messagesList[index].file!);
                                                                            },
                                                                            child:
                                                                                const Icon(
                                                                              Icons.download,
                                                                              color: Colors.red,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: SizeConfig
                                                                    .heightMultiplier *
                                                                0.5,
                                                          ),
                                                          Align(
                                                            alignment: isMe
                                                                ? Alignment
                                                                    .centerRight
                                                                : Alignment
                                                                    .centerLeft,
                                                            child: Text(
                                                                singleChatVM.checkDate(
                                                                    singleChatVM
                                                                        .messagesList[
                                                                            index]
                                                                        .dateTime!),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            SizeConfig.textMultiplier *
                                                                                1.6)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                            singleChatVM.messagesList[index]
                                                        .file !=
                                                    null
                                                ? const SizedBox.shrink()
                                                : Column(
                                                    crossAxisAlignment: !isMe
                                                        ? CrossAxisAlignment
                                                            .start
                                                        : CrossAxisAlignment
                                                            .end,
                                                    children: [
                                                      Stack(
                                                        alignment: isMe
                                                            ? Alignment
                                                                .centerRight
                                                            : Alignment
                                                                .centerLeft,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              bottom: singleChatVM
                                                                          .messagesList[
                                                                              index]
                                                                          .emoji ==
                                                                      ''
                                                                  ? 0
                                                                  : 5,
                                                            ),
                                                            child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .widthMultiplier *
                                                                      3,
                                                                  right: isMe
                                                                      ? SizeConfig
                                                                              .widthMultiplier *
                                                                          3
                                                                      : SizeConfig
                                                                              .widthMultiplier *
                                                                          3,
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: SizeConfig
                                                                          .widthMultiplier *
                                                                      5,
                                                                  top: SizeConfig
                                                                          .widthMultiplier *
                                                                      3,
                                                                  bottom: SizeConfig
                                                                          .widthMultiplier *
                                                                      3,
                                                                  right: SizeConfig
                                                                          .widthMultiplier *
                                                                      6,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child:
                                                                    GestureDetector(
                                                                  onLongPress:
                                                                      () {
                                                                    singleChatVM
                                                                        .selectedEmojiIndex
                                                                        .value = index;
                                                                    singleChatVM
                                                                        .displayEmoji
                                                                        .value = true;
                                                                  },
                                                                  child: Text(
                                                                    '${singleChatVM.messagesList[index].msg}',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodySmall!
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: SizeConfig.textMultiplier * 2.0),
                                                                  ),
                                                                )),
                                                          ),
                                                          isMe
                                                              ? const SizedBox
                                                                  .shrink()
                                                              : Positioned(
                                                                  right: 0,
                                                                  bottom: 0,
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        SizeConfig.heightMultiplier *
                                                                            4,
                                                                    width: SizeConfig
                                                                            .widthMultiplier *
                                                                        8,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(30),
                                                                        color: Colors.black,
                                                                        image: DecorationImage(
                                                                          image:
                                                                              NetworkImage(
                                                                            singleChatVM.singleUser.value.image!,
                                                                          ),
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5), // Shadow color
                                                                            spreadRadius:
                                                                                2, // Spread radius
                                                                            blurRadius:
                                                                                5, // Blur radius
                                                                            offset:
                                                                                Offset(0, 3), // Offset in the x and y directions
                                                                          ),
                                                                        ]),
                                                                  ),
                                                                ),
                                                          singleChatVM
                                                                      .messagesList[
                                                                          index]
                                                                      .emoji! !=
                                                                  ''
                                                              ? Positioned(
                                                                  left: isMe
                                                                      ? null
                                                                      : 5,
                                                                  bottom: 0,
                                                                  right: isMe
                                                                      ? 5
                                                                      : null,
                                                                  child:
                                                                      SizedBox(
                                                                    height: 23,
                                                                    width: 23,
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      singleChatVM
                                                                          .messagesList[
                                                                              index]
                                                                          .emoji!,
                                                                      color: singleChatVM
                                                                              .messagesList[index]
                                                                              .emoji!
                                                                              .contains('heart')
                                                                          ? Colors.red
                                                                          : singleChatVM.messagesList[index].emoji!.contains('like')
                                                                              ? Colors.blue
                                                                              : null,
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox
                                                                  .shrink(),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: SizeConfig
                                                                .heightMultiplier *
                                                            0.5,
                                                      ),
                                                      Align(
                                                        alignment: isMe
                                                            ? Alignment
                                                                .centerRight
                                                            : Alignment
                                                                .centerLeft,
                                                        child: Text(
                                                            singleChatVM.checkDate(
                                                                singleChatVM
                                                                    .messagesList[
                                                                        index]
                                                                    .dateTime!),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    fontSize:
                                                                        SizeConfig.textMultiplier *
                                                                            1.6)),
                                                      ),
                                                      Obx(() => singleChatVM
                                                                      .displayEmoji
                                                                      .value ==
                                                                  true &&
                                                              singleChatVM
                                                                      .selectedEmojiIndex
                                                                      .value ==
                                                                  index
                                                          ? isMe
                                                              ? const SizedBox
                                                                  .shrink()
                                                              : Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Colors
                                                                          .black),
                                                                  width: SizeConfig
                                                                          .widthMultiplier *
                                                                      62,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: List.generate(
                                                                        singleChatVM
                                                                            .emojiList
                                                                            .length,
                                                                        (i) {
                                                                      return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          singleChatVM
                                                                              .updateEmojie(
                                                                            docUID:
                                                                                singleChatVM.messagesList[index].dateTime!,
                                                                            emoji:
                                                                                singleChatVM.emojiList[i],
                                                                            senderUID:
                                                                                singleChatVM.messagesList[index].senderUid!,
                                                                          );
                                                                          singleChatVM
                                                                              .displayEmoji
                                                                              .value = false;
                                                                          singleChatVM
                                                                              .selectedEmojiIndex
                                                                              .value = -1;
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: SizeConfig.widthMultiplier * 2,
                                                                              vertical: SizeConfig.heightMultiplier * 2),
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            singleChatVM.emojiList[i],
                                                                            color: i == 0
                                                                                ? Colors.blue
                                                                                : i == 1
                                                                                    ? Colors.red
                                                                                    : null,
                                                                            height:
                                                                                SizeConfig.heightMultiplier * 3,
                                                                            width:
                                                                                SizeConfig.widthMultiplier * 4,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                        growable:
                                                                            true),
                                                                  ),
                                                                )
                                                          : const SizedBox
                                                              .shrink()),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 3,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Obx(
                              () => customFormField(
                                  bottomPadding:
                                      SizeConfig.heightMultiplier * 1,
                                  maxLines: singleChatVM.textFieldLines.value,
                                  onChange: (value) {
                                    if (value!.length ==
                                        singleChatVM
                                            .textFieldTextLenght.value) {
                                      singleChatVM.textFieldLines.value++;
                                      print(value);
                                      singleChatVM.textFieldTextLenght.value =
                                          26 *
                                              singleChatVM.textFieldLines.value;
                                    }
                                  },
                                  context: context,
                                  keyboardType: TextInputType.text,
                                  hintText: 'Write...',
                                  controller:
                                      singleChatVM.singleChatController),
                            )),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (singleChatVM.singleChatController.text !=
                                    '') {
                                  singleChatVM.sendMessage(
                                      currentUser: homeVM.userData.value,
                                      recieverToken: singleChatVM
                                          .singleUser.value.fmcToken!,
                                      isPickedFile: false,
                                      msg: singleChatVM
                                          .singleChatController.text,
                                      receiverUID:
                                          singleChatVM.singleUser!.value.uid!);
                                }
                              },
                              child: Container(
                                height: SizeConfig.heightMultiplier * 6,
                                width: SizeConfig.widthMultiplier * 8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                      'assets/images/chat.png',
                                    ))),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                singleChatVM.sendMessage(
                                    currentUser: homeVM.userData.value,
                                    recieverToken:
                                        singleChatVM.singleUser.value.fmcToken!,
                                    isPickedFile: true,
                                    msg: singleChatVM.singleChatController.text,
                                    receiverUID:
                                        singleChatVM.singleUser.value.uid!);
                              },
                              child: Container(
                                height: SizeConfig.heightMultiplier * 6,
                                width: SizeConfig.widthMultiplier * 8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                      'assets/images/camera.png',
                                    ))),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 2,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: SizeConfig.heightMultiplier * 6,
                                width: SizeConfig.widthMultiplier * 8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                      'assets/images/mic.png',
                                    ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
