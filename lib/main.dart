import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/controller/theme_controller.dart';
import 'package:prettyrini/feature/appointment_history/ui/appointment_history_page.dart';
import 'package:prettyrini/feature/auth/screen/forget_pasword_screen.dart';
import 'package:prettyrini/feature/auth/screen/login_screen.dart';
import 'package:prettyrini/feature/auth/screen/new_password.dart';
import 'package:prettyrini/feature/auth/screen/otp_very_screen.dart';
import 'package:prettyrini/feature/auth/screen/reset_password.dart';
import 'package:prettyrini/feature/auth/screen/sign_up_screen.dart';
import 'package:prettyrini/feature/booking_screen/ui/booking_screen.dart';
import 'package:prettyrini/feature/booking_summary/ui/booking_summary_screen.dart';
import 'package:prettyrini/feature/dashboard/ui/dashboard.dart';
import 'package:prettyrini/feature/doctors_list/ui/doctors_list_ui.dart';
import 'package:prettyrini/feature/hospital_bookins/ui/hospital_booking_list_ui.dart';
import 'package:prettyrini/feature/hospitals/ui/hospitals_list_ui.dart';
import 'package:prettyrini/feature/notification/ui/notification_page_ui.dart';
import 'package:prettyrini/feature/order_summary/ui/order_summary_ui.dart';
import 'package:prettyrini/feature/profile/ui/change_passoword.dart';
import 'package:prettyrini/feature/profile/ui/edit_profile_screen.dart';
import 'package:prettyrini/feature/profile/ui/profile_screen.dart';
import 'package:prettyrini/feature/splash_screen/screen/splash_screen.dart';
import 'package:prettyrini/feature/subscription_page/view/subscription_screen.dart';
import 'package:prettyrini/feature/welome/view/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/const/app_colors.dart';
import 'route/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configEasyLoading();
  await SharedPreferences.getInstance();
  Get.put(ThemeController());
  runApp(const MyApp());
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = AppColors.grayColor
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.green
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Foot Fitness',
          // getPages: AppRoute.routes,
          // initialRoute: AppRoute.splashScreen,
          // builder: EasyLoading.init(),

          //  home: SplashScreen(),
          // home: LoginScreen(),
          // home: ResetPasswordScreen(),
          // home: ForgetPasswordScreen(),
          // home: WelcomeScreen(),
          // home: DashboardScreen(),
          //   home: NotificationScreen(),
          // home: BookingScreen(),
          //home: BookingSummaryScreen(),
          // home: ProfileScreen(),
          //   home: EditProfile(),
          //  home : ChangePassoword()
          //  home: AppointmentHistoryPage(),
          // home: OrderSummaryUi(),
          // home: HospitalsListUi(),
          //   home: DoctorsListUi(),
          home: HospitalBookingListUi()),
    );
  }
}
