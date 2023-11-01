import 'dart:io';
import 'package:artxprochatapp/Utils/AppGradient/gradient.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/CustomButton/elevated_button.dart';
import '../../../../Utils/SizeConfig/size_config.dart';
import '../../../../Utils/TextField/text_form_field.dart';
import '../ViewModel/signup_view_model.dart';
import 'component/bottom_sheet.dart';
import 'component/image_picker_tile.dart';

class SignUpView extends StatelessWidget {
  SignUpView({
    Key? key,
  }) : super(key: key);
  final signupVM = Get.find<SignUpViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gradient(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 20),
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 10,
              ),
              Center(
                  child: Obx(
                () => imagePickerTile(
                    imageUrl: signupVM.imagePath.value,
                    voidCallback: () {
                      imagePickerBottomSheet(
                          context: context,
                          data: signupVM.bottomSheetList,
                          fromGallery: () {
                            signupVM.getImageFormStorage();
                          },
                          fromCamera: () {
                            signupVM.getImageFormCamera();
                          },
                          delete: () {
                            // signupVM.deleteImage();
                          });
                    }),
              )),
              SizedBox(
                // width: SizeConfig.widthMultiplier * 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customFormField(
                      onChange: (value) {
                        value;
                      },
                      context: context,
                      keyboardType: TextInputType.emailAddress,
                      controller: signupVM.nameController,
                      hintText: 'Name',
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    customFormField(
                      onChange: (value) {
                        value;
                      },
                      context: context,
                      keyboardType: TextInputType.emailAddress,
                      controller: signupVM.emailController,
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1,
                    ),
                    customFormField(
                      onChange: (value) {
                        value;
                      },
                      obsecureText: true,
                      textInputAction: TextInputAction.done,
                      context: context,
                      keyboardType: TextInputType.text,
                      controller: signupVM.passwordController,
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    CustomElevatedButton(
                      title: 'SignUp',
                      onPressed: () {
                        signupVM.signUp(
                            signupVM.emailController.text,
                            signupVM.passwordController.text,
                            signupVM.nameController.text,
                            signupVM.imagePath.value);
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Already have an Account?',
                            style: Theme.of(context).textTheme.bodySmall,
                            children: [
                          TextSpan(
                              text: 'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context).dividerColor,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoutes.loginView);
                                })
                        ]))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
