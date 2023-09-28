import 'dart:io';

import 'package:artxprochatapp/AppModule/ProfileModule/ViewModel/profile_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:artxprochatapp/Utils/TextField/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../SingleChatModule/Model/users_model.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final profileVM = Get.find<ProfileViewModel>();
  UsersModel userData = Get.arguments;
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
                      : SizeConfig.widthMultiplier * 58),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      profileVM.getImageFormStorage();
                    },
                    child: Container(
                      height: SizeConfig.heightMultiplier * 20,
                      width: SizeConfig.widthMultiplier * 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: userData.userImage == ''
                              ? null
                              : DecorationImage(
                                  image: NetworkImage(userData.userImage!),
                                  fit: BoxFit.cover)),
                      child:
                          userData.userImage == '' ? Icon(Icons.person) : null,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  customFormField(
                      onChange: (value) {},
                      readOnly: true,
                      context: context,
                      keyboardType: TextInputType.text,
                      hintText: userData.userName!,
                      controller: profileVM.nameController),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  customFormField(
                      onChange: (value) {},
                      readOnly: true,
                      context: context,
                      keyboardType: TextInputType.text,
                      hintText: 'Name',
                      controller: profileVM.emailController),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
