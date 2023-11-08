import 'package:artxprochatapp/Utils/AppGradient/gradient.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageTile extends StatelessWidget {
  final String message;
  final String date;
  final MessageType messageType;
  const MessageTile(
      {super.key,
      required this.message,
      required this.messageType,
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(message),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child:
                                Text("${timeago.format(DateTime.parse(date))}"),
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
                          Text(message),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child:
                                Text("${timeago.format(DateTime.parse(date))}"),
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
