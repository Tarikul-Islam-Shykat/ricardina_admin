import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../auth/screen/login_screen.dart';

class SplashScreenController extends GetxController {
  var userImage = "".obs;
  var firstname = ''.obs;
  var lastName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    moveToLoginScreen();
  }

  moveToLoginScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.to(LoginScreen());
  }
}
