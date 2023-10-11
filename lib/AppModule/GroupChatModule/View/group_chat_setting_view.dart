import 'dart:io';

import 'package:artxprochatapp/AppModule/GroupChatModule/Model/group_chat_model.dart';
import 'package:artxprochatapp/AppModule/GroupChatModule/ViewModel/group_chat_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../Utils/CustomButton/elevated_button.dart';
import '../../Services/firebase_services.dart';
import '../Model/groups_model.dart';
import 'Component/add_members_to_group_dialog.dart';

class GroupChatSettingView extends StatelessWidget {
  GroupChatSettingView({Key? key}) : super(key: key);
  GroupsModel groupData = Get.arguments[0];
  RxList<GroupUserModel> members = Get.arguments[1];

  final groupVM = Get.find<GroupChatViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Platform.isAndroid
          ? SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 3,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.black,
                            size: SizeConfig.widthMultiplier * 8,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 3,
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0,
                    ),
                    child: Image.network(
                      groupData.groupImage!,
                      height: SizeConfig.heightMultiplier * 20,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 3,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Users',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: Colors.black,
                                fontSize: SizeConfig.textMultiplier * 3.0,
                                fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Expanded(
                      child: Obx(
                    () => ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 3,
                      ),
                      itemCount: members.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final data = members[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.heightMultiplier * 2),
                          child: Column(
                            children: [
                              data.isAdmin == true &&
                                      data.uid ==
                                          FirebaseAuth.instance.currentUser!.uid
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Text Only Admin'),
                                            Switch(
                                                value: data.textOnlyAdmin!,
                                                onChanged: (value) {
                                                  groupVM.textOnlyAdmin(
                                                      groupData: groupData,
                                                      members: members,
                                                      groupName:
                                                          groupData.groupName!,
                                                      textOnlyAdminValue:
                                                          value);
                                                })
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CustomElevatedButton(
                                              textColor: Colors.white,
                                              backgroundColor: Colors.black,
                                              onPressed: () {
                                                addMemberToGroupDialog(
                                                    context: context,
                                                    group: groupData.obs,
                                                    groupVM: groupVM);
                                              },
                                              title: 'New User',
                                            ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      3,
                                            ),
                                            Expanded(
                                                child: CustomElevatedButton(
                                              title: 'Delete Group',
                                              onPressed: () {
                                                groupVM.deleteGroup(
                                                    membersList:
                                                        groupData.members!,
                                                    groupName:
                                                        groupData.groupName!);
                                                Get.offAllNamed(
                                                    AppRoutes.homeView);
                                                print(groupData.groupName);
                                              },
                                              textColor: Colors.white,
                                              backgroundColor: Colors.red,
                                            )),
                                          ],
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
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
                                              border: data.isAdmin == true
                                                  ? Border.all(
                                                      color: Colors.blue,
                                                      width: 2)
                                                  : null,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image:
                                                      NetworkImage(data.image!),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Text(
                                          data.name!,
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
                                          backgroundColor: data.isAdmin == true
                                              ? Colors.blue
                                              : Colors.black,
                                          title: 'Full Access',
                                          onPressed: () {
                                            if (groupData.uid!.contains(
                                                FirebaseAuth.instance
                                                    .currentUser!.uid)) {
                                              groupVM.makeAdmin(
                                                  textOnlyAdminValue:
                                                      data.textOnlyAdmin!,
                                                  memberUID: data.uid!,
                                                  members: members,
                                                  groupData: groupData);
                                            }
                                          })),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 1,
                                  ),
                                  Expanded(
                                      child: CustomElevatedButton(
                                          verticalPadding: 12,
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          textColor: Colors.white,
                                          backgroundColor: data.isAdmin == false
                                              ? Colors.grey
                                              : Colors.black,
                                          title: 'Ragular Access',
                                          onPressed: () {})),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 1,
                                  ),
                                  data.isAdmin == false ||
                                          // data.isAdmin == true &&
                                          groupData.uid!.contains(FirebaseAuth
                                              .instance.currentUser!.uid)
                                      ? GestureDetector(
                                          onTap: () {
                                            final removedMember =
                                                GroupUserModel(
                                              image: data.image,
                                              isAdmin: false,
                                              isAddedToGroup: true,
                                              isOnline: data.isOnline,
                                              name: data.name,
                                              uid: data.uid,
                                              lastActive: data.lastActive,
                                            );

                                            groupVM.removeMemberToGroup(
                                                group: groupData,
                                                removedMember: removedMember);
                                          },
                                          child: Container(
                                            height:
                                                SizeConfig.heightMultiplier * 8,
                                            width:
                                                SizeConfig.widthMultiplier * 10,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                      'assets/images/delete.png',
                                                    ),
                                                    fit: BoxFit.contain)),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ))
                ],
              ),
            )
          : null,
    );
  }
}
