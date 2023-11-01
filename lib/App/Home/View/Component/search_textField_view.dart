import 'dart:io';

import 'package:artxprochatapp/App/Home/Model/wraper_tab_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget searchFormField({
  required BuildContext context,
  required TextInputType keyboardType,
  TextInputAction textInputAction = TextInputAction.next,
  bool obsecureText = false,
  required String hintText,
  required TextEditingController controller,
  bool readOnly = false,
  int maxLines = 1,
  Function(String?)? onChange,
  double bottomPadding = 0.0,
  required VoidCallback onBackButton,
  required VoidCallback onCancel,
  required RxBool onCancelCheck,
  required RxBool selectedWraper,
  required WraperModel wraper,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).canvasColor.withOpacity(0.15)),
    child: Row(
      children: [
        GestureDetector(
          onTap: onBackButton,
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).dividerColor,
          ),
        ),
        SizedBox(
          width: SizeConfig.widthMultiplier * 1,
        ),
        Obx(()=> selectedWraper.value == true ? Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .canvasColor
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                   wraper.icon,
                                    color: Theme.of(context).dividerColor,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 2,
                                  ),
                                  Text(wraper.title)
                                ],
                              ),
                            ) : SizedBox.shrink()), SizedBox(
          width: SizeConfig.widthMultiplier * 1,
        ),
                            
        Expanded(
          child: TextFormField(
            readOnly: readOnly,
            controller: controller,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Platform.isAndroid ? Colors.white : Colors.black,
                ),
            maxLines: maxLines,
            onChanged: (value) {
              onChange!(value);
            },
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obsecureText,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: Platform.isAndroid
                  ? Colors.transparent
                  : Theme.of(context).primaryColor,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Platform.isAndroid ? Colors.white : Colors.black),
            ),
            
          ),
        ),
        
        SizedBox(
          width: SizeConfig.widthMultiplier * 1,
        ),
   Obx(()=>    onCancelCheck.value == true
            ? GestureDetector(
                onTap: onCancel,
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).dividerColor,
                ),
              )
            : SizedBox.shrink(),),
      ],
    ),
  );
}
