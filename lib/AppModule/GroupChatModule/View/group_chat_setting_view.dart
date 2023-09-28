import 'dart:io';

import 'package:artxprochatapp/AppModule/GroupChatModule/Model/group_chat_model.dart';
import 'package:artxprochatapp/AppModule/GroupChatModule/ViewModel/group_chat_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/CustomButton/elevated_button.dart';

class GroupChatSettingView extends StatelessWidget {
  GroupChatSettingView({Key? key}) : super(key: key);
  GroupChatModel groupData = Get.arguments[0];
  int groupIndex = Get.arguments[1];

  final groupVM = Get.put(GroupChatViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Platform.isAndroid
          ? SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 3,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        groupData.groupName!,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: Colors.black,
                                fontSize: SizeConfig.textMultiplier * 3.0,
                                fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      children: [
                        CustomElevatedButton(
                          textColor: Colors.white,
                          backgroundColor: Colors.black,
                          onPressed: () {},
                          title: 'New User',
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 3,
                        ),
                        Expanded(
                            child: CustomElevatedButton(
                          title: 'Delete Group',
                          onPressed: () {
                            groupVM.groupList.removeAt(groupIndex);
                            print(groupVM.groupList.length);
                            Get.toNamed(AppRoutes.homeView);
                          },
                          textColor: Colors.white,
                          backgroundColor: Colors.red,
                        )),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Members',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: Colors.black,
                                fontSize: SizeConfig.textMultiplier * 3.0,
                                fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: groupData.userModel!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.heightMultiplier * 2),
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 10,
                                // color: Colors.red,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height:
                                              SizeConfig.heightMultiplier * 10,
                                          width:
                                              SizeConfig.widthMultiplier * 12,
                                          decoration: BoxDecoration(
                                              border: groupData
                                                          .userModel![index]
                                                          .groupCreatedBy ==
                                                      true
                                                  ? Border.all(
                                                      color: Colors.blue,
                                                      width: 2)
                                                  : null,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(groupData
                                                      .userModel![index]
                                                      .userImage!),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Text(
                                          groupData.userModel![index].userName!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomElevatedButton(
                                          verticalPadding: 12,
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          textColor: Colors.white,
                                          backgroundColor: groupData
                                                      .userModel![index]
                                                      .groupCreatedBy ==
                                                  true
                                              ? Colors.blue
                                              : Colors.black,
                                          title: 'Full Access',
                                          onPressed: () {})),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 1,
                                  ),
                                  Expanded(
                                      child: CustomElevatedButton(
                                          verticalPadding: 12,
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          textColor: Colors.white,
                                          backgroundColor: Colors.black,
                                          title: 'Ragular Access',
                                          onPressed: () {})),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 1,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      height: SizeConfig.heightMultiplier * 8,
                                      width: SizeConfig.widthMultiplier * 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                'assets/images/delete.png',
                                              ),
                                              fit: BoxFit.contain)),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ))
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
