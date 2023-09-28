import 'package:artxprochatapp/AppModule/GroupChatModule/ViewModel/group_chat_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:artxprochatapp/Utils/TextField/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../Model/group_chat_model.dart';
import 'Component/mobile_group_people_ListView.dart';

class MobileGroupView extends StatelessWidget {
  final GroupChatViewModel groupVM;

  MobileGroupView({Key? key, required this.groupVM, required this.groupIndex})
      : super(key: key);
  int groupIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            ),
            MobileGroupPeopleListView(groupIndex: groupIndex),
            SizedBox(
              height: SizeConfig.heightMultiplier * 1,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 4),
                reverse: true,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: index == 3
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: SizeConfig.widthMultiplier * 20,
                          maxWidth: SizeConfig.widthMultiplier * 70,
                        ),
                        child: Stack(
                          alignment: index == 3
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    right: index == 3
                                        ? 0
                                        : SizeConfig.widthMultiplier * 3),
                                padding: EdgeInsets.only(
                                  left: SizeConfig.widthMultiplier * 3,
                                  top: SizeConfig.widthMultiplier * 3,
                                  bottom: SizeConfig.widthMultiplier * 3,
                                  right: SizeConfig.widthMultiplier * 6,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'Ho my name os akdldl hshsaahs gsahhsa assassb fdfd ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: Colors.white,
                                          fontSize:
                                              SizeConfig.textMultiplier * 2.0),
                                )),
                            index == 3
                                ? const SizedBox.shrink()
                                : Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      height: SizeConfig.heightMultiplier * 4,
                                      width: SizeConfig.widthMultiplier * 8,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.black,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://images.pexels.com/photos/18295330/pexels-photo-18295330/free-photo-of-black-and-white-photo-of-a-collapsed-wooden-fence-on-a-sand-beach.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), // Shadow color
                                              spreadRadius: 2, // Spread radius
                                              blurRadius: 5, // Blur radius
                                              offset: Offset(0,
                                                  3), // Offset in the x and y directions
                                            ),
                                          ]),
                                    ),
                                  )
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
    );
  }
}
