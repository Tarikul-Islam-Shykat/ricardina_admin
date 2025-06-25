// screens/booking_summary_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/booking_summary/controller/booking_summary_contoller.dart';
import 'package:prettyrini/feature/booking_summary/model/summary_model.dart';

class AppointmentHistoryPage extends StatelessWidget {
  const AppointmentHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingSummaryController controller =
        Get.put(BookingSummaryController());

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => controller.goBack(),
        ),
        title: headingText(
          text: "Appointment History",
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.booking.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64.sp, color: Colors.grey),
                SizedBox(height: 16.h),
                headingText(text: "No booking data found", color: Colors.grey),
              ],
            ),
          );
        }

        final booking = controller.booking.value!;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            _buildDateTimeSection(controller, booking),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Patient Section
                    _buildPatientSection(
                        controller, booking.patient, booking.receipt),

                    SizedBox(height: 24.h),

                    // Receipt Section

                    SizedBox(height: 100.h), // Space for button
                  ],
                ),
              ),
            ),

            // Mark as Complete Button
            _buildCompleteButton(controller),
          ],
        );
      }),
    );
  }

  Widget _buildDateTimeSection(
      BookingSummaryController controller, BookingModel booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        normalText(
            text: controller.formattedDateTime,
            color: Colors.black,
            fontWeight: FontWeight.w500),
        SizedBox(height: 4.h),
        Row(
          children: [
            smallText(
              text: booking.status,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: smallText(
                text: booking.statusMessage,
                color: Colors.grey[600]!,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDoctorCard(DoctorModel doctor) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Doctor Avatar
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Icon(
                Icons.person,
                color: Colors.grey[400],
                size: 30.sp,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Doctor Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headingText(
                  text: doctor.name,
                  color: Colors.white,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    normalText(
                      text: ' ${doctor.hourlyRate.toInt()}',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(width: 4.w),
                    smallText(
                      text: '/ ${doctor.duration}',
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientSection(BookingSummaryController controller,
      PatientModel patient, ReceiptModel receipt) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Patient Avatar
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Icon(
                    Icons.person,
                    color: Colors.orange[400],
                    size: 24.sp,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              headingText(
                text: patient.name,
                color: Colors.black,
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Favorite Message
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                SizedBox(width: 8.w),
                Expanded(
                  child: smallText(
                    text: patient.favoriteMessage,
                    color: Colors.grey[600]!,
                    maxLines: 2,
                  ),
                ),
                Icon(Icons.warning_rounded)
              ],
            ),
          ),

          headingText(
            text: "Receipt",
            color: Colors.black,
          ),
          SizedBox(height: 12.h),
          Column(
            children: [
              // Subtotal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallText(
                    text: "Subtotal ( include VAT )",
                    color: Colors.grey[600]!,
                  ),
                  smallText(
                    text: "${receipt.currency}${receipt.subtotal.toInt()}",
                    color: Colors.black,
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              // VAT
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  smallText(
                    text: "VAT",
                    color: Colors.grey[600]!,
                  ),
                  smallText(
                    text: "${receipt.currency}${receipt.vat.toInt()}",
                    color: Colors.black,
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              Divider(color: Colors.grey[300]),

              SizedBox(height: 16.h),

              // Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingText(
                    text: "Total Bill",
                    color: Colors.black,
                  ),
                  headingText(
                    text: "${receipt.currency}${receipt.totalBill.toInt()}",
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteButton(BookingSummaryController controller) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50.h,
          child: Obx(() => ElevatedButton(
                onPressed: controller.isCompleting.value
                    ? null
                    : () => controller.markAsComplete(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: controller.isCompleting.value
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : headingText(
                        text: "Call Dianne Russell",
                        color: Colors.white,
                      ),
              )),
        ),
      ),
    );
  }
}

// Add this to your existing AppColors class
