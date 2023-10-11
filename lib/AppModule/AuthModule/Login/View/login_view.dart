import 'package:artxprochatapp/RoutesAndBindings/app_routes.dart';
import 'package:artxprochatapp/Utils/SizeConfig/size_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../../Utils/CustomButton/elevated_button.dart';
import '../../../../Utils/TextField/text_form_field.dart';
import '../ViewModel/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({
    Key? key,
  }) : super(key: key);
  final loginVM = Get.find<LoginViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/artx.png',
              height: 150,
              width: 150,
            ),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 60,
            child: Column(
              children: [
                customFormField(
                  onChange: (value) {},
                  context: context,
                  keyboardType: TextInputType.emailAddress,
                  controller: loginVM.emailController,
                  hintText: 'Email',
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1,
                ),
                customFormField(
                  onChange: (value) {},
                  obsecureText: true,
                  textInputAction: TextInputAction.done,
                  context: context,
                  keyboardType: TextInputType.text,
                  controller: loginVM.passwordController,
                  hintText: 'Password',
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                CustomElevatedButton(
                  title: 'Login',
                  onPressed: () {
                    loginVM.loginAccount(
                        email: loginVM.emailController.text,
                        password: loginVM.passwordController.text);
                  },
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                RichText(
                    text: TextSpan(
                        text: "Don't have an Account?",
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                      TextSpan(
                          text: 'SignUp',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Color(0xff3079E2),
                                  ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(AppRoutes.signupView);
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
