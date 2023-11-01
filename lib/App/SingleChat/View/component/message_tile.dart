import 'package:artxprochatapp/Utils/AppGradient/gradient.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final MessageType messageType;
  const MessageTile(
      {super.key, required this.message, required this.messageType});

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
                      child: Text(message),
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
                      child: Text(message),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
