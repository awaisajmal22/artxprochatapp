import 'package:artxprochatapp/AppModule/GroupChatModule/Model/groups_model.dart';
import 'package:artxprochatapp/AppModule/Services/firebase_services.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:artxprochatapp/Utils/Toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Utils/TextField/text_form_field.dart';
import '../../ViewModel/group_chat_view_model.dart';

addMemberToGroupDialog({
  required BuildContext context,
  required Rx<GroupsModel> group,
  required GroupChatViewModel groupVM,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.widthMultiplier * 5,
            vertical: SizeConfig.heightMultiplier * 2,
          ),
          height: SizeConfig.heightMultiplier * 60,
          width: SizeConfig.widthMultiplier * 60,
          child: Column(
            children: [
              customSearchFormField(
                textColor: Colors.white,
                onChanged: (value) {
                  print(groupVM.searchList.length);
                  if (groupVM.searchController.text.isEmpty) {
                    groupVM.searchList.value = [];
                  } else {
                    groupVM.searchList.value = groupVM.searchUsers(value!);
                  }
                },
                context: context,
                keyboardType: TextInputType.text,
                hintText: 'Search User...',
                controller: groupVM.searchController,
              ),
              Expanded(
                child: Obx(() => groupVM.userChatList.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.builder(
                        itemCount: groupVM.searchList.isEmpty
                            ? groupVM.userChatList.length
                            : groupVM.searchList.length,
                        itemBuilder: (context, index) {
                          final data = groupVM.searchList.isEmpty
                              ? groupVM.userChatList[index]
                              : groupVM.searchList[index];

                          bool userExists = groupVM.groupMembersList
                              .any((user) => user.uid == data.uid);
                          return data.uid ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? const SizedBox.shrink()
                              : Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                        height: SizeConfig.heightMultiplier * 4,
                                        width: SizeConfig.widthMultiplier * 8,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(data.image!),
                                                fit: BoxFit.cover)),
                                      ),
                                      title: Text(
                                        data.name!,
                                        style: GoogleFonts.acme()
                                            .copyWith(color: Colors.black),
                                      ),
                                      trailing: GestureDetector(
                                          onTap: () {
                                            final newMember = GroupUserModel(
                                              fcmToken: data.fmcToken,
                                              image: data.image,
                                              isAdmin: false,
                                              isAddedToGroup: true,
                                              isOnline: data.isOnline,
                                              name: data.name,
                                              uid: data.uid,
                                              email: data.email,
                                              textOnlyAdmin: false,
                                              lastActive: data.lastActive,
                                            );
                                            if (userExists) {
                                              // ignore: void_checks
                                              return toast(
                                                  title: 'User Already Exist..',
                                                  backgroundColor:
                                                      Colors.black);
                                            } else {
                                              groupVM.addMembersToGroup(
                                                  group: group.value,
                                                  newMember: newMember);
                                              
                                            }
                                          },
                                          child: Icon(userExists
                                              ? Icons.check
                                              : Icons.add)),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 1,
                                    )
                                  ],
                                );
                        },
                      )),
              )
            ],
          ),
        ),
      );
    },
  );
}
