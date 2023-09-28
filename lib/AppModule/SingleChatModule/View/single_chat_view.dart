import 'dart:io';
import 'dart:typed_data';

import 'package:artxprochatapp/RoutesAndBindings/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import '../../../Utils/SizeConfig/size_config.dart';
import '../../../Utils/TextField/text_form_field.dart';
import '../../AuthModule/SignUp/Model/user_model.dart';
import '../Model/users_model.dart';
import '../ViewModel/single_chat_view_model.dart';

class SingleChatView extends StatelessWidget {
  SingleChatView({
    Key? key,
  }) : super(key: key);
  final singleChatVM = Get.find<SingleChatViewModel>();
  late PDFViewController _pdfViewController;

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
                                singleChatVM.singleUser!.value.name!,
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2.4),
                              ),
                              Text(
                                singleChatVM.singleUser!.value.isOnline == true
                                    ? 'Online'
                                    : 'Offline',
                                style: TextStyle(
                                    color: singleChatVM
                                                .singleUser!.value.isOnline ==
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
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 4),
                            itemCount: singleChatVM.messagesList.length,
                            itemBuilder: (context, index) {
                              final isMe = singleChatVM
                                      .messagesList[index].receiverUid !=
                                  singleChatVM.messagesList[index].senderUid;
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
                                                ? SizedBox(
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
                                                            child: singleChatVM
                                                                    .messagesList[
                                                                        index]
                                                                    .file!
                                                                    .contains(
                                                                        'pdf')
                                                                ? Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    children: [
                                                                      PDFView(
                                                                        defaultPage:
                                                                            1,
                                                                        filePath: singleChatVM
                                                                            .messagesList[index]
                                                                            .file!,
                                                                        pageSnap:
                                                                            false,
                                                                        fitEachPage:
                                                                            true,
                                                                      ),
                                                                      Positioned(
                                                                        top: 10,
                                                                        left:
                                                                            10,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {},
                                                                          child:
                                                                              const Icon(
                                                                            Icons.download,
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : singleChatVM
                                                                            .messagesList[
                                                                                index]
                                                                            .file!
                                                                            .contains(
                                                                                'png') ||
                                                                        singleChatVM
                                                                            .messagesList[
                                                                                index]
                                                                            .file!
                                                                            .contains(
                                                                                'jpeg') ||
                                                                        singleChatVM
                                                                            .messagesList[index]
                                                                            .file!
                                                                            .contains('jpg')
                                                                    ? Stack(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        children: [
                                                                          Image
                                                                              .network(
                                                                            singleChatVM.messagesList[index].file!,
                                                                            height:
                                                                                SizeConfig.widthMultiplier * 30,
                                                                            width:
                                                                                SizeConfig.widthMultiplier * 30,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                          Positioned(
                                                                            top:
                                                                                10,
                                                                            left:
                                                                                10,
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                GallerySaver.saveImage(singleChatVM.messagesList[index].file!);
                                                                              },
                                                                              child: const Icon(
                                                                                Icons.download,
                                                                                color: Colors.red,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Stack(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            singleChatVM.getImageAccordingExtension(singleChatVM.messagesList[index].file!),
                                                                            fit:
                                                                                BoxFit.cover,
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
                                                                              onTap: () {},
                                                                              child: const Icon(
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
                                                                  .centerLeft
                                                              : Alignment
                                                                  .centerRight,
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
                                                          Container(
                                                              margin: EdgeInsets.only(
                                                                  right: isMe
                                                                      ? 0
                                                                      : SizeConfig
                                                                              .widthMultiplier *
                                                                          3),
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: SizeConfig
                                                                        .widthMultiplier *
                                                                    3,
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
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Text(
                                                                '${singleChatVM.messagesList[index].msg}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            SizeConfig.textMultiplier *
                                                                                2.0),
                                                              )),
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
                                                                            singleChatVM.singleUser!.value.image!,
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
                                      senderUID: FirebaseAuth
                                          .instance.currentUser!.uid,
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
                                    senderUID:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    isPickedFile: true,
                                    msg: singleChatVM.singleChatController.text,
                                    receiverUID:
                                        singleChatVM.singleUser!.value.uid!);
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
