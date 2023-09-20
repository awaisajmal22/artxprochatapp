import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:record/record.dart';

import '../../../../Utils/SizeConfig/size_config.dart';
import '../../ViewModel/home_view_model.dart';

Widget singleUserInputTile(
    {required VoidCallback recordingvoidCallback,
    required VoidCallback sendvoidCallback,
    required TextEditingController controller,
    required VoidCallback filaCallBak,
    required RxBool isRecording,
    required VoidCallback stopRecording,
    required VoidCallback saveRecording,
    required BuildContext context,
    bool check = true,
    SizedBox? widget,
    required Widget text,
    }) {
 
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.widthMultiplier * 5.0,
        vertical: SizeConfig.heightMultiplier * 1.0),
    height: SizeConfig.heightMultiplier * 8,
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.15), width: 2))),
    child: check == true
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: [
             text,
              Row(
                
                children: [
                  GestureDetector(
                    onTap: stopRecording,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.red,
                            width: 1,
                          )),
                      child: Icon(
                        Icons.close_outlined,
                        color: Colors.red,
                        size: SizeConfig.imageSizeMultiplier * 4,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: saveRecording,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green,
                            width: 1,
                          )),
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                        size: SizeConfig.imageSizeMultiplier * 4,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              )
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(18)),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 5.0,
                      vertical: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget!,
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: TextFormField(
                          cursorColor: Colors.blue,
                          controller: controller,
                          textAlign: TextAlign.left,

                          style: TextStyle(
                              color: Color(0xffBCBCBC),
                              fontSize: SizeConfig.textMultiplier * 1.25,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  right: SizeConfig.widthMultiplier * 5.0,
                                  top: 0,
                                  bottom: 0),
                              hintText: 'Write a message',
                              hintStyle: TextStyle(
                                  color: Color(0xffBCBCBC),
                                  fontSize: SizeConfig.textMultiplier * 1.25,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              border: InputBorder.none),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: filaCallBak,
                            child: Icon(
                              Ionicons.file_tray,
                              color: Color(0xffBCBCBC),
                              size: SizeConfig.imageSizeMultiplier * 4,
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 3.0,
                          ),
                          GestureDetector(
                            onTap: recordingvoidCallback,
                            child: Icon(
                              Ionicons.mic_circle_outline,
                              color: Color(0xffBCBCBC),
                              size: SizeConfig.imageSizeMultiplier * 4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 1.9,
              ),
              GestureDetector(
                onTap: sendvoidCallback,
                child: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              )
            ],
          ),
  );
}
