import 'dart:io';

import 'package:artxprochatapp/AppModule/GroupChatModule/Model/groups_model.dart';
import 'package:artxprochatapp/AppModule/ProfileModule/ViewModel/profile_view_model.dart';
import 'package:artxprochatapp/Utils/CustomButton/elevated_button.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:artxprochatapp/Utils/TextField/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../AuthModule/SignUp/Model/user_model.dart';
import '../../SingleChatModule/Model/users_model.dart';


class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final profileVM = Get.find<ProfileViewModel>();
  
  Rx<UserModel> userData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 2),
          children: [
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: GestureDetector(
            //     onTap: () {
            //       Get.back();
            //     },
            //     child: Icon(
            //       Icons.arrow_back,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Platform.isAndroid
                    ? SizeConfig.widthMultiplier * 20
                    : SizeConfig.widthMultiplier * 58,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 20,
                    width: SizeConfig.widthMultiplier * 30,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            userData.value.uid == profileVM.currentUID
                                ? profileVM.getImageFormStorage()
                                : null;
                          },
                          child: Obx(
                            () => profileVM.imagePath.value != ''
                                ? Container(
                                    height: SizeConfig.heightMultiplier * 20,
                                    width: SizeConfig.widthMultiplier * 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(File(
                                                profileVM.imagePath.value)),
                                            fit: BoxFit.cover)),
                                    child: profileVM.imagePath.value == ''
                                        ? const Icon(Icons.person)
                                        : null,
                                  )
                                : Container(
                                    height: SizeConfig.heightMultiplier * 20,
                                    width: SizeConfig.widthMultiplier * 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: userData.value.image == ''
                                            ? null
                                            : DecorationImage(
                                                image: NetworkImage(
                                                    userData.value.image!),
                                                fit: BoxFit.cover)),
                                    child: userData.value.image == ''
                                        ? const Icon(Icons.person)
                                        : null,
                                  ),
                          ),
                        ),
                        userData.value.uid == profileVM.currentUID
                            ? Positioned(
                                bottom: SizeConfig.heightMultiplier * 2.5,
                                right: SizeConfig.widthMultiplier * 3,
                                child: Icon(
                                  Ionicons.camera,
                                  color: Colors.black,
                                  size: SizeConfig.widthMultiplier * 8,
                                ))
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  customFormField(
                      onChange: (value) {},
                      readOnly: userData.value.uid == profileVM.currentUID
                          ? false
                          : true,
                      context: context,
                      keyboardType: TextInputType.text,
                      hintText: "Name",
                      controller: profileVM.nameController
                        ..text = userData.value.name!),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  customFormField(
                      onChange: (value) {},
                      readOnly: true,
                      context: context,
                      keyboardType: TextInputType.text,
                      hintText: 'Email',
                      controller: profileVM.emailController
                        ..text = userData.value.email!),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                  userData.value.uid == profileVM.currentUID
                      ? CustomElevatedButton(
                          title: 'Update',
                          onPressed: () {
                            if (profileVM.nameController.text != '') {
                              if (profileVM.imagePath.value.isEmpty ||
                                  profileVM.imagePath.value == '')
                                profileVM.updateProfile(
                                    profileImage: null,
                                    url: userData.value.image,
                                    uid: userData.value.uid!,
                                    name: profileVM.nameController.text);
                            } else {
                              profileVM.updateProfile(
                                  profileImage: File(profileVM.imagePath.value),
                                  url: null,
                                  uid: userData.value.uid!,
                                  name: profileVM.nameController.text);
                            }
                          })
                      : SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class GroupProfileView extends StatelessWidget {
  GroupProfileView({Key? key}) : super(key: key);
  final profileVM = Get.find<ProfileViewModel>();
  
  Rx<GroupUserModel> userData = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 2),
          children: [
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: GestureDetector(
            //     onTap: () {
            //       Get.back();
            //     },
            //     child: Icon(
            //       Icons.arrow_back,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Platform.isAndroid
                    ? SizeConfig.widthMultiplier * 20
                    : SizeConfig.widthMultiplier * 58,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 20,
                    width: SizeConfig.widthMultiplier * 30,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            userData.value.uid == profileVM.currentUID
                                ? profileVM.getImageFormStorage()
                                : null;
                          },
                          child: Obx(
                            () => profileVM.imagePath.value != ''
                                ? Container(
                                    height: SizeConfig.heightMultiplier * 20,
                                    width: SizeConfig.widthMultiplier * 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(File(
                                                profileVM.imagePath.value)),
                                            fit: BoxFit.cover)),
                                    child: profileVM.imagePath.value == ''
                                        ? const Icon(Icons.person)
                                        : null,
                                  )
                                : Container(
                                    height: SizeConfig.heightMultiplier * 20,
                                    width: SizeConfig.widthMultiplier * 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: userData.value.image == ''
                                            ? null
                                            : DecorationImage(
                                                image: NetworkImage(
                                                    userData.value.image!),
                                                fit: BoxFit.cover)),
                                    child: userData.value.image == ''
                                        ? const Icon(Icons.person)
                                        : null,
                                  ),
                          ),
                        ),
                        userData.value.uid == profileVM.currentUID
                            ? Positioned(
                                bottom: SizeConfig.heightMultiplier * 2.5,
                                right: SizeConfig.widthMultiplier * 3,
                                child: Icon(
                                  Ionicons.camera,
                                  color: Colors.black,
                                  size: SizeConfig.widthMultiplier * 8,
                                ))
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  customFormField(
                      onChange: (value) {},
                      readOnly: userData.value.uid == profileVM.currentUID
                          ? false
                          : true,
                      context: context,
                      keyboardType: TextInputType.text,
                      hintText: "Name",
                      controller: profileVM.nameController
                        ..text = userData.value.name!),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  customFormField(
                      onChange: (value) {},
                      readOnly: true,
                      context: context,
                      keyboardType: TextInputType.text,
                      hintText: 'Email',
                      controller: profileVM.emailController
                        ..text = userData.value.email!),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                  userData.value.uid == profileVM.currentUID
                      ? CustomElevatedButton(
                          title: 'Update',
                          onPressed: () {
                            if (profileVM.nameController.text != '') {
                              if (profileVM.imagePath.value.isEmpty ||
                                  profileVM.imagePath.value == '')
                                profileVM.updateProfile(
                                    profileImage: null,
                                    url: userData.value.image,
                                    uid: userData.value.uid!,
                                    name: profileVM.nameController.text);
                            } else {
                              profileVM.updateProfile(
                                  profileImage: File(profileVM.imagePath.value),
                                  url: null,
                                  uid: userData.value.uid!,
                                  name: profileVM.nameController.text);
                            }
                          })
                      : SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

