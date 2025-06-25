import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/doctors_list/controller/doctors_controller.dart';

class DoctorsListUi extends StatelessWidget {
  const DoctorsListUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorsController>(
      init: DoctorsController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    headingTextv2(
                      text: "Doctors",
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox()
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: _buildBookingsList(controller),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingsList(DoctorsController controller) {
    return ListView.builder(
      itemCount: controller.pendingBookings.length,
      itemBuilder: (context, index) {
        final booking = controller.pendingBookings[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Profile Image
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: NetworkImage(booking.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Name and Time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        normalText(
                          text: booking.name,
                          fontWeight: FontWeight.w600,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                ),
                                smallText(
                                    text: booking.rating.toString(),
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 4.h),
                    smallText(
                        text: booking.description,
                        color: Colors.grey[500]!,
                        maxLines: 2),
                  ],
                ),
              ),

              // More options
              // Icon(
              //   Icons.more_horiz,
              //   color: Colors.grey[400],
              //   size: 20.sp,
              // ),
            ],
          ),
        );
      },
    );
  }
}
