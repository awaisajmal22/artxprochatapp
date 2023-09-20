import 'dart:async';

import 'package:get/get.dart';

import '../../../RoutesAndBindings/app_routes.dart';

class SplashViewModel extends GetxController {
  Timer? timer;

  @override
  void onInit() {
    timer = Timer(const Duration(seconds: 2), () {
      checkUser();
    });
  }

  checkUser() async {
    Get.offAllNamed(AppRoutes.loginView);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }
}
