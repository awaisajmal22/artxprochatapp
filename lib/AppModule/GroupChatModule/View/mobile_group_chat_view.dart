import 'package:artxprochatapp/AppModule/GroupChatModule/Model/groups_model.dart';
import 'package:artxprochatapp/AppModule/GroupChatModule/ViewModel/group_chat_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:artxprochatapp/Utils/TextField/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../AuthModule/SignUp/Model/user_model.dart';
import '../Model/group_chat_model.dart';
import 'Component/mobile_group_people_ListView.dart';

class MobileGroupView extends StatelessWidget {
  final GroupChatViewModel groupVM;
  final Rx<GroupsModel> groupsModel;
  final UserModel currentUser;
  int groupIndex;

  MobileGroupView({
    Key? key,
    required this.groupVM,
    required this.groupsModel,
    required this.groupIndex,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool anyFalse = groupVM.groupMembersList.any((value) =>
        value.textOnlyAdmin == false &&
        value.uid == FirebaseAuth.instance.currentUser!.uid);
    bool allFalse = groupVM.groupMembersList.every((value) =>
        value.textOnlyAdmin == true &&
        value.uid == FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            ),
            MobileGroupPeopleListView(
              groupModel: groupsModel,
              groupIndex: groupIndex,
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 1,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: groupVM.scrollController,
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 4),
                  itemCount: groupVM.messagesList.length,
                  itemBuilder: (context, index) {
                    final isMe = !groupVM.messagesList[index].reciverUid!.any(
                        (element) =>
                            element == FirebaseAuth.instance.currentUser!.uid);
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
                                  groupVM.messagesList[index].file != null
                                      ? Obx(
                                          () => SizedBox(
                                            height:
                                                SizeConfig.widthMultiplier * 40,
                                            width:
                                                SizeConfig.widthMultiplier * 30,
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
                                                        BorderRadius.circular(
                                                            30),
                                                    child: groupVM
                                                                .messagesList[
                                                                    index]
                                                                .msg!
                                                                .contains(
                                                                    'png') ||
                                                            groupVM
                                                                .messagesList[
                                                                    index]
                                                                .msg!
                                                                .contains(
                                                                    'jpeg') ||
                                                            groupVM
                                                                .messagesList[
                                                                    index]
                                                                .msg!
                                                                .contains('jpg')
                                                        ? Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Image.network(
                                                                groupVM
                                                                    .messagesList[
                                                                        index]
                                                                    .file!,
                                                                height: SizeConfig
                                                                        .widthMultiplier *
                                                                    30,
                                                                width: SizeConfig
                                                                        .widthMultiplier *
                                                                    30,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              Positioned(
                                                                top: 10,
                                                                left: 10,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    groupVM.downloadFile(
                                                                        groupVM
                                                                            .messagesList[
                                                                                index]
                                                                            .file!,
                                                                        groupVM
                                                                            .messagesList[index]
                                                                            .msg!);
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .download,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Image.asset(
                                                                groupVM.getImageAccordingExtension(
                                                                    groupVM
                                                                        .messagesList[
                                                                            index]
                                                                        .msg!),
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: SizeConfig
                                                                        .widthMultiplier *
                                                                    30,
                                                                width: SizeConfig
                                                                        .widthMultiplier *
                                                                    30,
                                                              ),
                                                              Positioned(
                                                                top: 10,
                                                                left: 10,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    groupVM.downloadFile(
                                                                        groupVM
                                                                            .messagesList[
                                                                                index]
                                                                            .file!,
                                                                        groupVM
                                                                            .messagesList[index]
                                                                            .file!);
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .download,
                                                                    color: Colors
                                                                        .red,
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
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                                  child: Text(
                                                      groupVM.checkDate(groupVM
                                                          .messagesList[index]
                                                          .dateTime!),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: SizeConfig
                                                                      .textMultiplier *
                                                                  1.6)),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  groupVM.messagesList[index].file != null
                                      ? const SizedBox.shrink()
                                      : Column(
                                          crossAxisAlignment: !isMe
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.end,
                                          children: [
                                            Stack(
                                              alignment: isMe
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: groupVM
                                                                .messagesList[
                                                                    index]
                                                                .emoji ==
                                                            ''
                                                        ? 0
                                                        : 5,
                                                  ),
                                                  child: Container(
                                                      margin: EdgeInsets.only(
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
                                                      padding: EdgeInsets.only(
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
                                                          color: Colors.black,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: GestureDetector(
                                                        onLongPress: () {
                                                          groupVM
                                                              .selectedEmojiIndex
                                                              .value = index;
                                                          groupVM.displayEmoji
                                                              .value = true;
                                                        },
                                                        child: Text(
                                                          '${groupVM.messagesList[index].msg}',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .textMultiplier *
                                                                          2.0),
                                                        ),
                                                      )),
                                                ),
                                                isMe
                                                    ? const SizedBox.shrink()
                                                    : Positioned(
                                                        right: 0,
                                                        bottom: 0,
                                                        child: Container(
                                                          height: SizeConfig
                                                                  .heightMultiplier *
                                                              4,
                                                          width: SizeConfig
                                                                  .widthMultiplier *
                                                              8,
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  color: Colors
                                                                      .black,
                                                                  image: groupVM
                                                                              .messagesList[index]
                                                                              .image! ==
                                                                          null
                                                                      ? null
                                                                      : DecorationImage(
                                                                          image:
                                                                              NetworkImage(
                                                                            groupVM.messagesList[index].image!,
                                                                          ),
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                  boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5), // Shadow color
                                                                  spreadRadius:
                                                                      2, // Spread radius
                                                                  blurRadius:
                                                                      5, // Blur radius
                                                                  offset: Offset(
                                                                      0,
                                                                      3), // Offset in the x and y directions
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                groupVM.messagesList[index]
                                                            .emoji! !=
                                                        ''
                                                    ? Positioned(
                                                        left: isMe ? null : 5,
                                                        bottom: 0,
                                                        right: isMe ? 5 : null,
                                                        child: SizedBox(
                                                          height: 23,
                                                          width: 23,
                                                          child:
                                                              SvgPicture.asset(
                                                            groupVM
                                                                .messagesList[
                                                                    index]
                                                                .emoji!,
                                                            color: groupVM
                                                                    .messagesList[
                                                                        index]
                                                                    .emoji!
                                                                    .contains(
                                                                        'heart')
                                                                ? Colors.red
                                                                : groupVM
                                                                        .messagesList[
                                                                            index]
                                                                        .emoji!
                                                                        .contains(
                                                                            'like')
                                                                    ? Colors
                                                                        .blue
                                                                    : null,
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      0.5,
                                            ),
                                            Align(
                                              alignment: isMe
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              child: Text(
                                                  groupVM.checkDate(groupVM
                                                      .messagesList[index]
                                                      .dateTime!),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              1.6)),
                                            ),
                                            Obx(() => groupVM.displayEmoji
                                                            .value ==
                                                        true &&
                                                    groupVM.selectedEmojiIndex
                                                            .value ==
                                                        index
                                                ? isMe
                                                    ? const SizedBox.shrink()
                                                    : Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Colors.black),
                                                        width: SizeConfig
                                                                .widthMultiplier *
                                                            62,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children:
                                                              List.generate(
                                                                  groupVM
                                                                      .emojiList
                                                                      .length,
                                                                  (i) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                groupVM
                                                                    .updateEmoji(
                                                                  groupName:
                                                                      groupsModel
                                                                          .value
                                                                          .groupName!,
                                                                  docUID: groupVM
                                                                      .messagesList[
                                                                          index]
                                                                      .dateTime!,
                                                                  emoji: groupVM
                                                                      .emojiList[i],
                                                                  senderUID: groupVM
                                                                      .messagesList[
                                                                          index]
                                                                      .senderUid!,
                                                                );
                                                                groupVM
                                                                    .displayEmoji
                                                                    .value = false;
                                                                groupVM
                                                                    .selectedEmojiIndex
                                                                    .value = -1;
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        SizeConfig.widthMultiplier *
                                                                            2,
                                                                    vertical:
                                                                        SizeConfig.heightMultiplier *
                                                                            2),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  groupVM
                                                                      .emojiList[i],
                                                                  color: i == 0
                                                                      ? Colors
                                                                          .blue
                                                                      : i == 1
                                                                          ? Colors
                                                                              .red
                                                                          : null,
                                                                  height: SizeConfig
                                                                          .heightMultiplier *
                                                                      3,
                                                                  width: SizeConfig
                                                                          .widthMultiplier *
                                                                      4,
                                                                ),
                                                              ),
                                                            );
                                                          }, growable: true),
                                                        ),
                                                      )
                                                : const SizedBox.shrink()),
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
            groupVM.groupMembersList.any((e) =>
                    e.uid == FirebaseAuth.instance.currentUser!.uid &&
                    e.textOnlyAdmin == true &&
                    e.isAdmin == true)
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 3,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Obx(
                          () => customFormField(
                              bottomPadding: SizeConfig.heightMultiplier * 1,
                              maxLines: groupVM.textFieldLines.value,
                              onChange: (value) {
                                if (value?.length ==
                                    groupVM.textFieldTextLenght.value) {
                                  groupVM.textFieldLines.value++;
                                  print(value);
                                  groupVM.textFieldTextLenght.value =
                                      28 * groupVM.textFieldLines.value;
                                }
                              },
                              context: context,
                              keyboardType: TextInputType.text,
                              hintText: 'Write...',
                              controller: groupVM.groupChatInputController),
                        )),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (groupVM.groupChatInputController.text != '') {
                              groupVM.sendMessage(
                                currentUser: currentUser,
                                msg: groupVM.groupChatInputController.text,
                                isPickedFile: false,
                                senderUID:
                                    FirebaseAuth.instance.currentUser!.uid,
                                groupmembers: groupsModel.value.members!,
                                groupName: groupsModel.value.groupName!,
                              );
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
                            groupVM.sendMessage(
                              currentUser: currentUser,
                              groupmembers: groupsModel.value.members!,
                              groupName: groupsModel.value.groupName!,
                              senderUID: FirebaseAuth.instance.currentUser!.uid,
                              isPickedFile: true,
                              msg: groupVM.groupChatInputController.text,
                            );
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
                  )
                : SizedBox.shrink(),
            groupVM.groupMembersList.every((e) => e.textOnlyAdmin == false)
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 3,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Obx(
                          () => customFormField(
                              bottomPadding: SizeConfig.heightMultiplier * 1,
                              maxLines: groupVM.textFieldLines.value,
                              onChange: (value) {
                                if (value?.length ==
                                    groupVM.textFieldTextLenght.value) {
                                  groupVM.textFieldLines.value++;
                                  print(value);
                                  groupVM.textFieldTextLenght.value =
                                      28 * groupVM.textFieldLines.value;
                                }
                              },
                              context: context,
                              keyboardType: TextInputType.text,
                              hintText: 'Write...',
                              controller: groupVM.groupChatInputController),
                        )),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (groupVM.groupChatInputController.text != '') {
                              groupVM.sendMessage(
                                currentUser: currentUser,
                                msg: groupVM.groupChatInputController.text,
                                isPickedFile: false,
                                senderUID:
                                    FirebaseAuth.instance.currentUser!.uid,
                                groupmembers: groupsModel.value.members!,
                                groupName: groupsModel.value.groupName!,
                              );
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
                            groupVM.sendMessage(
                              currentUser: currentUser,
                              groupmembers: groupsModel.value.members!,
                              groupName: groupsModel.value.groupName!,
                              senderUID: FirebaseAuth.instance.currentUser!.uid,
                              isPickedFile: true,
                              msg: groupVM.groupChatInputController.text,
                            );
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
                  )
                : SizedBox.shrink(),
            
          ],
        ),
      ),
    );
  }
}
