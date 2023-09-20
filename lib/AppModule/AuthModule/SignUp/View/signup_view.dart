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

class SignUpView extends StatelessWidget {
  SignUpView({Key? key, }) : super(key: key);
  final signupVM = Get.find<SignUpViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 150,
              width: 150,
            ),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 60,
            child: Column(
              children: [
                customFormField(
                  context: context,
                  keyboardType: TextInputType.emailAddress,
                  controller: signupVM.emailController,
                  hintText: 'Email',
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                customFormField(
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
                  onPressed: () {},
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
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Color(0xff3079E2),
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
    );
  }
}
