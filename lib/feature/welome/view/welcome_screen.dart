import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/welome/controller/welcome_screen_controller.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(
      init: WelcomeController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.bgColor, // AppColors.bgColor equivalent
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Center(
                    child: Image.asset(
                  ImagePath.smallLogo,
                  width: 71.w,
                  height: 48.h,
                  fit: BoxFit.fill,
                )),
                SizedBox(height: 20.h),

                // Title
                headingTextv2(
                  text: "Select Your Role",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),

                // Subtitle
                smallText(
                  text:
                      "Start your journey to mastering money with fun,\ninteractive lessons today!",
                  color: Colors.grey[600]!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),

                SizedBox(height: 20.h),

                // Role Selection Cards
                Expanded(
                  child: Column(
                    children: [
                      // Hospital and Doctor Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildRoleCard(
                              role: "Hospital",
                              icon: Icons.local_hospital,
                              isSelected: controller.selectedRole == "Hospital",
                              onTap: () => controller.selectRole("Hospital"),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: _buildRoleCard(
                              role: "Doctor",
                              icon: Icons.medical_services,
                              isSelected: controller.selectedRole == "Doctor",
                              onTap: () => controller.selectRole("Doctor"),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      // Pharmacy Card
                      Center(
                        child: SizedBox(
                          width: 150.w,
                          child: _buildRoleCard(
                            role: "Pharmacy",
                            icon: Icons.local_pharmacy,
                            isSelected: controller.selectedRole == "Pharmacy",
                            onTap: () => controller.selectRole("Pharmacy"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String role,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF00B4A6) : Colors.grey[300]!,
            width: 2.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF00B4A6).withOpacity(0.1)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: isSelected ? const Color(0xFF00B4A6) : Colors.grey[500],
                size: 24.sp,
              ),
            ),
            SizedBox(height: 12.h),
            normalText(
              text: role,
              fontWeight: FontWeight.w600,
              color: isSelected ? const Color(0xFF00B4A6) : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
