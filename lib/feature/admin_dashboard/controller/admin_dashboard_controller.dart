// controllers/home_controller.dart

import 'package:get/get.dart';

class AdminDashboardController extends GetxController {
  var currentNavIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onBottomNavTapped(int index) {
    currentNavIndex.value = index;
  }
}
