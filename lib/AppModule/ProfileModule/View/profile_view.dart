import 'dart:io';

import 'package:artxprochatapp/AppModule/ProfileModule/ViewModel/profile_view_model.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:artxprochatapp/Utils/TextField/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  
  ProfileView({Key? key}) : super(key: key);
  final profileVM = Get.find<ProfileViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 2),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 58),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      profileVM.getImageFormStorage();
                    },
                    child: Obx(
                      () => CircleAvatar(
                        radius: 100,
                        child: profileVM.image.value != ''
                            ? Image.file(File(profileVM.image.value))
                            : Icon(Icons.person),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  customFormField(
                      readOnly: true,
                      context: context,
                      keyboardType: TextInputType.text,
                      hintText: 'Name',
                      controller: profileVM.nameController),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  customFormField(
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
