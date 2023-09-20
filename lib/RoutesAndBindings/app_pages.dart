import 'package:artxprochatapp/AppModule/AuthModule/Login/View/login_view.dart';
import 'package:artxprochatapp/AppModule/HomeModule/View/component/chat_list_view.dart';
import 'package:artxprochatapp/AppModule/ProfileModule/ViewModel/profile_view_model.dart';
import 'package:get/get.dart';

import '../AppModule/AuthModule/Login/ViewModel/login_view_model.dart';
import '../AppModule/AuthModule/SignUp/View/signup_view.dart';
import '../AppModule/AuthModule/SignUp/ViewModel/signup_view_model.dart';
import '../AppModule/GroupChatModule/View/group_chat_view.dart';
import '../AppModule/HomeModule/View/home_view.dart';
import '../AppModule/HomeModule/ViewModel/home_view_model.dart';
import '../AppModule/ProfileModule/View/profile_view.dart';
import '../AppModule/SplashModule/View/splash_view.dart';
import '../AppModule/SplashModule/ViewModel/splash_view_model.dart';
import '../AppModule/VoiceChannelModule/View/voice_channel_view.dart';
import '../AppModule/VoiceChannelModule/ViewModel/voice_channel_view_model.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
        name: AppRoutes.splashView,
        transition: Transition.fade,
        page: () => SplashView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SplashViewModel>(() => SplashViewModel());
        })),
    GetPage(
        name: AppRoutes.loginView,
        transition: Transition.fade,
        page: () => LoginView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LoginViewModel());
        })),
    GetPage(
        name: AppRoutes.signupView,
        transition: Transition.fade,
        page: () => SignUpView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SignUpViewModel());
        })),
    GetPage(
        name: AppRoutes.homeView,
        transition: Transition.fade,
        page: () => HomeView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HomeViewModel());
           
        })),
    GetPage(
        name: AppRoutes.groupView,
        transition: Transition.fade,
        page: () => GroupChatView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HomeViewModel());
         
        })),
         GetPage(
        name: AppRoutes.profileView,
        transition: Transition.fade,
        page: () => ProfileView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProfileViewModel());
        })),
          GetPage(
        name: AppRoutes.voicChannelView,
        transition: Transition.fade,
        page: () => VoiceChannelView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => VoiceChannelViewModel());
        })),
        
  ];
}
