import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

imagePickerBottomSheet(
    {required List data,
    VoidCallback? fromCamera,
    VoidCallback? fromGallery,
    required BuildContext context,
    VoidCallback? delete}) {
  Get.bottomSheet(
      // barrierColor: Colors.black.withOpacity(0.15),
      Container(
    padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.widthMultiplier * 4,
        vertical: SizeConfig.widthMultiplier * 4),
    height: SizeConfig.heightMultiplier * 40,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        color: Colors.white),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Profile photo',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black,
                fontSize: SizeConfig.textMultiplier * 2.4,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(
          height: 32,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              data.length,
              (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          if (index == 0) {
                            fromCamera!();
                          } else if (index == 1) {
                            fromGallery!();
                          } else if (index == 2) {
                            delete!();
                          }
                        },
                        leading: Icon(
                          data[index].leadingIcon,
                          color: Colors.black,
                        ),
                        title: Text(
                          data[index].title,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      index == data.length - 1
                          ? const SizedBox()
                          : Container(
                              height: 1,
                              width: SizeConfig.widthMultiplier * 60,
                              color: Colors.grey[100],
                            )
                    ],
                  )),
        )
      ],
    ),
  ));
}
