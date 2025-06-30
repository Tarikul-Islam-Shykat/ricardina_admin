import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/feature/admin_dashboard/controller/admin_dashboard_controller.dart';
import 'package:prettyrini/feature/dashboard/ui/dashboard.dart';
import 'package:prettyrini/feature/profile/ui/edit_profile_screen.dart';
import 'package:prettyrini/feature/profile/ui/profile_screen.dart';
import 'package:prettyrini/feature/tips/ui/tips_ui.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdminDashboardController controller =
        Get.put(AdminDashboardController());

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing
    final double iconSize = screenWidth * 0.06;
    final double fontSize = screenWidth * 0.035;
    final double gap = screenWidth * 0.02;
    final double borderRadius = screenWidth * 0.04;
    final double verticalPadding = screenHeight * 0.012;
    final double horizontalPadding = screenWidth * 0.03;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Obx(() => IndexedStack(
              index: controller.currentNavIndex.value,
              children: [
                DashboardScreen(),
                TipsUi(),
                ProfileScreen(),
              ],
            )),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
          bottom: screenHeight * 0.02,
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 15,
              offset: const Offset(0, 5),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: IntrinsicWidth(
            child: Obx(() => GNav(
                  rippleColor: const Color(0xFF8B5CF6).withOpacity(0.1),
                  hoverColor: const Color(0xFF8B5CF6).withOpacity(0.1),
                  gap: gap,
                  activeColor: Colors.white,
                  iconSize: iconSize,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding * 0.6,
                    vertical: verticalPadding * 0.8,
                  ),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: AppColors.primaryColor,
                  color: Colors.grey[600],
                  selectedIndex: controller.currentNavIndex.value,
                  onTabChange: controller.onBottomNavTapped,
                  textStyle: GoogleFonts.poppins(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  tabs: const [
                    GButton(icon: Icons.home, text: 'Home'),
                    GButton(icon: Icons.health_and_safety, text: 'Tips'),
                    GButton(icon: Icons.person, text: 'Profile'),
                  ],
                )),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
