import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/global_widegts/app_snackbar.dart';
import 'package:prettyrini/core/network_caller/network_config.dart';
import 'package:prettyrini/core/services_class/local_data.dart';
import 'package:prettyrini/feature/admin_dashboard/ui/admin_dashboard_ui.dart';
import '../../../core/network_caller/endpoints.dart';

class LoginController extends GetxController {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  String? fcmToken;
  final NetworkConfig _networkConfig = NetworkConfig();

  @override
  void onInit() {
    super.onInit();
  }

  final isLoginLoading = false.obs;

  Future<bool> loginUser() async {
    if (emailTEController.text.isEmpty || passwordTEController.text.isEmpty) {
      AppSnackbar.show(message: 'Please fill all fields', isSuccess: false);
      return false;
    }
    try {
      isLoginLoading.value = true;
      String email = emailTEController.text;
      String password = passwordTEController.text;
      final Map<String, dynamic> requestBody = {
        "email": email,
        "password": password,
        "role": "SUPER_ADMIN"
      };

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.login,
        json.encode(requestBody),
        is_auth: false,
      );
      if (response != null && response['success'] == true) {
        var localService = LocalService();
        await localService.clearUserData();
        await localService.setToken(response["data"]["token"]);
        await localService.setRole(response["data"]["role"]);
        Get.to(AdminDashboard());
        AppSnackbar.show(message: "Login Successful", isSuccess: true);
        return true;
      } else {
        AppSnackbar.show(message: response['message'], isSuccess: false);
        return false;
      }
    } catch (e) {
      AppSnackbar.show(message: "Failed To Login $e", isSuccess: false);
      return false;
    } finally {
      isLoginLoading.value = false;
    }
  }

  void setUpValues() {
    emailTEController.text = "super.admin@gmail.com";
    passwordTEController.text = "12345678";
  }
}
