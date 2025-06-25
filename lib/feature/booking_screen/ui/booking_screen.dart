import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/booking_screen/controller/booking_controller';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      init: BookingController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8F9FA),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20.sp,
            ),
            onPressed: () => Get.back(),
          ),
          title: headingText(
            text: "Booking",
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20.h),

            // Tab Section
            _buildTabSection(controller),

            SizedBox(height: 20.h),

            // Bookings List
            Expanded(
              child: _buildBookingsList(controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSection(BookingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              text: "Ongoing",
              isSelected: controller.selectedTab == BookingStatus.ongoing,
              onTap: () => controller.changeTab(BookingStatus.ongoing),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: _buildTabButton(
              text: "Completed",
              isSelected: controller.selectedTab == BookingStatus.completed,
              onTap: () => controller.changeTab(BookingStatus.completed),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF00B4A6) : Colors.grey[300]!,
            width: 2.w,
          ),
        ),
        child: Center(
          child: normalText(
            text: text,
            color: isSelected ? const Color(0xFF00B4A6) : Colors.grey[600]!,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildBookingsList(BookingController controller) {
    final bookings = controller.getFilteredBookings();

    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 60.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16.h),
            normalText(
              text: "No ${controller.selectedTab.name} bookings",
              color: Colors.grey[500]!,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
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
          child: GestureDetector(
            onTap: () => controller.onBookingTap(booking),
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
                      normalText(
                        text: booking.name,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 4.h),
                      smallText(
                        text: booking.time,
                        color: Colors.grey[500]!,
                      ),
                    ],
                  ),
                ),

                // Status indicator or more options
                // if (booking.status == BookingStatus.completed)
                //   Container(
                //     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                //     decoration: BoxDecoration(
                //       color: Colors.green[50],
                //       borderRadius: BorderRadius.circular(6.r),
                //     ),
                //     child: smallText(
                //       text: "Completed",
                //       color: Colors.green[600]!,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   )
                // else
                //   Container(
                //     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                //     decoration: BoxDecoration(
                //       color: Colors.orange[50],
                //       borderRadius: BorderRadius.circular(6.r),
                //     ),
                //     child: smallText(
                //       text: "Ongoing",
                //       color: Colors.orange[600]!,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Include your text widgets here
Widget headingText({
  required String text,
  FontWeight fontWeight = FontWeight.bold,
  Color color = Colors.black,
  TextAlign textAlign = TextAlign.start,
  int maxLines = 1,
  TextOverflow overflow = TextOverflow.ellipsis,
}) {
  return Builder(
    builder: (context) => MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          color: color,
          fontSize: 18.sp,
          fontWeight: fontWeight,
          fontFamily: 'Manrope',
        ),
      ),
    ),
  );
}

Widget normalText({
  required String text,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.black,
  TextAlign textAlign = TextAlign.start,
  int maxLines = 1,
  TextOverflow overflow = TextOverflow.ellipsis,
}) {
  return Builder(
    builder: (context) => MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          color: color,
          fontSize: 16.sp,
          fontWeight: fontWeight,
          fontFamily: 'Poppins',
        ),
      ),
    ),
  );
}

Widget smallText({
  required String text,
  FontWeight fontWeight = FontWeight.w400,
  Color color = Colors.black,
  TextAlign textAlign = TextAlign.start,
  int maxLines = 1,
  TextOverflow overflow = TextOverflow.ellipsis,
}) {
  return Builder(
    builder: (context) => MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          color: color,
          fontSize: 12.sp,
          fontWeight: fontWeight,
          fontFamily: 'Poppins',
        ),
      ),
    ),
  );
}
