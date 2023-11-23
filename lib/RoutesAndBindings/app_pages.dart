import 'package:artxprochatapp/App/AllUsers/View/all_users_view.dart';
import 'package:artxprochatapp/App/AudioVideoCall/AudioCall/View/audio_call_view.dart';
import 'package:artxprochatapp/App/SingleChat/View/single_chat_view.dart';
import 'package:get/get.dart';

import '../App/AllUsers/ViewModel/all_users_view_model.dart';
import '../App/AudioVideoCall/AudioCall/ViewModel/audio_call_view_model.dart';
import '../App/Auth/Login/View/login_view.dart';
import '../App/Auth/Login/ViewModel/login_view_model.dart';
import '../App/Auth/Signup/View/signup_view.dart';
import '../App/Auth/Signup/ViewModel/signup_view_model.dart';
import '../App/CreatGroup/View/add_group_detail_view.dart';
import '../App/CreatGroup/View/create_group_view.dart';
import '../App/CreatGroup/ViewModel/create_group_view_model.dart';
import '../App/GroupChat/View/group_chat_view.dart';
import '../App/Home/View/home_view.dart';
import '../App/Home/ViewModel/home_view_model.dart';
import '../App/SingleChat/ViewModel/single_chat_view_model.dart';
import '../App/Splash/View/splash_view.dart';
import '../App/Splash/ViewModel/splash_view_model.dart';
// import '../AppModule/GroupChatModule/View/group_chat_view.dart';
// import '../AppModule/GroupChatModule/ViewModel/group_chat_view_model.dart';
// import '../AppModule/ProfileModule/View/profile_view.dart';
import '../App/GroupChat/ViewModel/group_chat_view_model.dart';
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
            Get.lazyPut(() => GroupChatViewModel());
Get.lazyPut(() => SingleChatViewModel());
          // Get.lazyPut(() => LoginViewModel());
          
          // Get.lazyPut(() => GroupChatViewModel());
        })),
    GetPage(
        name: AppRoutes.audioCallView,
        transition: Transition.fade,
        page: () => AudioCallView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HomeViewModel());
            Get.lazyPut(() => AudioCallViewModel());
Get.lazyPut(() => SingleChatViewModel());
          // Get.lazyPut(() => LoginViewModel());
          
          // Get.lazyPut(() => GroupChatViewModel());
        })),
    // GetPage(
    //     name: AppRoutes.groupView,
    //     transition: Transition.fade,
    //     page: () => GroupChatView(),
    //     binding: BindingsBuilder(() {
    //       Get.lazyPut(() => HomeViewModel());
    //       Get.lazyPut(() => GroupChatViewModel());
    //     })),
    // GetPage(
    //     name: AppRoutes.profileView,
    //     transition: Transition.fade,
    //     page: () => ProfileView(),
    //     binding: BindingsBuilder(() {
    //       Get.lazyPut(() => ProfileViewModel());
    //     })),
    // GetPage(
    //     name: AppRoutes.voicChannelView,
    //     transition: Transition.fade,
    //     page: () => VoiceChannelView(),
    //     binding: BindingsBuilder(() {
    //       Get.lazyPut(() => VoiceChannelViewModel());
    //     })),
    // GetPage(
    //     name: AppRoutes.groupChatSettingView,
    //     transition: Transition.fade,
    //     page: () => GroupChatSettingView(),
    //     binding: BindingsBuilder(() {
    //       Get.lazyPut(() => GroupChatViewModel());
    //       Get.lazyPut(() => DirectoryViewModel());
    //     })),
    GetPage(
        name: AppRoutes.singleChatView,
        transition: Transition.fade,
        page: () => SingleChatView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SingleChatViewModel());
          // Get.lazyPut(() => GroupChatViewModel());
          // Get.lazyPut(() => DirectoryViewModel());
        })),
    // GetPage(
    //     name: AppRoutes.groupProfileView,
    //     transition: Transition.fade,
    //     page: () => GroupProfileView(),
    //     binding: BindingsBuilder(() {
    //       Get.lazyPut(() => ProfileViewModel());
    //     })),
    GetPage(
        name: AppRoutes.groupView,
        transition: Transition.fade,
        page: () => GroupChatView(),
        binding: BindingsBuilder(() {
          // Get.lazyPut(() => DirectoryViewModel());
          Get.lazyPut(() => GroupChatViewModel());
        })),
    GetPage(
        name: AppRoutes.allUsersView,
        transition: Transition.fade,
        page: () => AllUsersView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AllUsersViewModel());
        })),
    GetPage(
        name: AppRoutes.createGroupView,
        transition: Transition.fade,
        page: () => CreateGroupView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CreateGroupViewModel());
        })),
    GetPage(
        name: AppRoutes.addGroupDetailView,
        transition: Transition.fade,
        page: () => AddGroupDetailView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CreateGroupViewModel());
        })),
  ];
}
