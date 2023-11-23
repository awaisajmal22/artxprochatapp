import 'package:artxprochatapp/App/SingleChat/ViewModel/single_chat_view_model.dart';
import 'package:artxprochatapp/Utils/AppGradient/gradient.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageTile extends StatelessWidget {
  final singleChatVM = Get.put(SingleChatViewModel());
  final String message;
  final String date;
  String fileName;

  final MessageType messageType;
  MessageTile(
      {super.key,
      required this.message,
      required this.messageType,
      this.fileName = '',
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        messageType == MessageType.receive
            ? Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                    top: 20,
                    right: SizeConfig.widthMultiplier * 30,
                    bottom: 15),
                child: ClipPath(
                  clipper: UpperNipMessageClipperTwo(messageType),
                  child: gradient(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: 10,
                        left: 25,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // fileName != ''
                          //     ? Obx(() => LinearProgressIndicator(
                          //           value: singleChatVM.progress.value,
                          //           color: Colors.red,
                          //           minHeight: 2,
                          //         ))
                          //     : SizedBox.shrink(),
                          if (message.contains(".jpeg") ||
                              message.contains('.png') ||
                              message.contains('jpg'))
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                message,
                                height: SizeConfig.heightMultiplier * 20,
                                width: SizeConfig.widthMultiplier * 60,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Text(message),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${timeago.format(DateTime.parse(date))}"),
                                if (message.contains(".jpeg") ||
                                    message.contains('.png') ||
                                    message.contains('jpg'))
                                  Spacer(),
                                if (message.contains(".jpeg") ||
                                    message.contains('.png') ||
                                    message.contains('jpg'))
                                  GestureDetector(
                                    onTap: () {
                                      singleChatVM.downloadFile(
                                          message, fileName);
                                    },
                                    child: Icon(Ionicons.download),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(
                    top: 20, left: SizeConfig.widthMultiplier * 30, bottom: 15),
                child: ClipPath(
                  clipper: UpperNipMessageClipperTwo(messageType),
                  child: gradient(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        right: 25,
                        left: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // fileName != ''
                          //     ? Obx(() => LinearProgressIndicator(
                          //           value: singleChatVM.progress.value,
                          //           color: Colors.red,
                          //           minHeight: 2,
                          //         ))
                          //     : SizedBox.shrink(),
                          if (message.contains(".jpeg") ||
                              message.contains('.png') ||
                              message.contains('jpg'))
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                message,
                                height: SizeConfig.heightMultiplier * 20,
                                width: SizeConfig.widthMultiplier * 60,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Text(message),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (message.contains(".jpeg") ||
                                    message.contains('.png') ||
                                    message.contains('jpg'))
                                  GestureDetector(
                                    onTap: () {
                                      print(fileName);
                                      singleChatVM.downloadFile(
                                          message, fileName);
                                    },
                                    child: Icon(Ionicons.download),
                                  ),
                                if (message.contains(".jpeg") ||
                                    message.contains('.png') ||
                                    message.contains('jpg'))
                                  Spacer(),
                                Text("${timeago.format(DateTime.parse(date))}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
