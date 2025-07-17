import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/appointment_history/ui/appointment_history_page.dart';
import 'package:prettyrini/feature/booking_summary/ui/booking_summary_screen.dart';
import 'package:prettyrini/feature/doctors_list/ui/doctors_list_ui.dart';
import 'package:prettyrini/feature/hospital_bookins/ui/hospital_booking_list_ui.dart';
import 'package:prettyrini/feature/hospitals/ui/hospitals_list_ui.dart';
import 'package:prettyrini/feature/order_summary/ui/order_summary_ui.dart';
import 'package:prettyrini/feature/profile/ui/change_passoword.dart';
import 'package:prettyrini/feature/profile/ui/edit_profile_screen.dart';
import 'package:prettyrini/feature/profile/widget/profile_image_text.dart';
import 'package:prettyrini/feature/profile/widget/profile_list_tile.dart';
import 'package:prettyrini/route/route.dart';

import '../../../core/const/app_colors.dart';
import '../controller/edit_profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Profile",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  color: AppColors.blackColor),
            )),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () {
                Get.to(EditProfile());
              },
              child: Obx(() => Container(
                    width: Get.width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //profile pic
                        Container(
                          height: 55.h,
                          width: 64.w,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: Colors.purple.shade50.withValues(alpha: .5),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: controller.profileImageUrl.value.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          controller.profileImageUrl.value,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        color: Colors.grey.shade200,
                                        child: Icon(
                                          Icons.person,
                                          size: 30.sp,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        ImagePath.profile,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      ImagePath.profile,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //name
                            SizedBox(
                              width: 240.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.nameController.text.isNotEmpty
                                        ? controller.nameController.text
                                        : "Darrell Steward",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.blackColor),
                                  ),
                                  // InkWell(
                                  //     onTap: () =>
                                  //         Get.toNamed(AppRoute.editProfileScreen),
                                  //     child: Image.asset(ImagePath.editIcon)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            profileEmailText(
                              Icons.email,
                              controller.emailController.text.isNotEmpty
                                  ? controller.emailController.text
                                  : 'darrellsteward@example.com',
                            ),
                            profileEmailText(
                              Icons.phone,
                              controller.phoneController.text.isNotEmpty
                                  ? controller.phoneController.text
                                  : '+1 761 234 5678',
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            //
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileListTile(
                    Icons.local_hospital,
                    'Hospital',
                    () {
                      Get.to(HospitalsListUi());
                    },
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.people,
                    'Doctors',
                    () {
                      Get.to(DoctorsListUi());
                    },
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.medical_information,
                    'Hospital Bookings',
                    () {
                      Get.to(HospitalBookingListUi());
                    },
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.book,
                    'Booking Summary',
                    () {
                      Get.to(BookingSummaryScreen());
                    },
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.book,
                    'Appointment History',
                    () {
                      Get.to(AppointmentHistoryPage());
                    },
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.book,
                    'Order Summary',
                    () {
                      Get.to(OrderSummaryUi());
                    },
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.local_pharmacy,
                    'Pharmacy',
                    () {},
                  ),
                  Divider(color: Colors.grey.shade300),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Support & Help",
              style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileListTile(
                    Icons.book,
                    'About Us',
                    () {},
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(Icons.password_outlined, 'Change Password',
                      () {
                    Get.to(ChangePassoword());
                  }),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.terminal,
                    'Terms & Conditions',
                    () {},
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.privacy_tip,
                    'Privacy Policy',
                    () {},
                  ),
                  Divider(color: Colors.grey.shade300),
                  profileListTile(
                    Icons.login,
                    'Log Out',
                    () async {
                      Get.toNamed(AppRoute.loginScreen);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.h,
            )
          ],
        ),
      ),
    );
  }
}
