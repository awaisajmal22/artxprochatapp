import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallViewModel extends GetxController{
   ZegoUIKitPrebuiltCallController callController = ZegoUIKitPrebuiltCallController();

   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    callController = ZegoUIKitPrebuiltCallController();
  }
}