import 'package:get/get.dart';

class WelcomeController extends GetxController {
  String selectedRole = '';

  void selectRole(String role) {
    selectedRole = role;
    update(); // Updates the UI
    
    // Handle role selection - navigate to next screen or perform action
    print("Selected role: $role");
    
    // Example navigation (uncomment when you have routes set up):
    // Get.toNamed('/next-screen', arguments: role);
  }
}