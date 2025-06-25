import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/dashboard/controller/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                _buildHeader(),
                SizedBox(height: 10.h),
                _buildStatsSection(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Profile Image
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: const DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        SizedBox(width: 12.w),

        // Welcome Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              smallText(
                text: "Welcome back,",
                color: Colors.grey[600]!,
              ),
              SizedBox(height: 2.h),
              headingText(
                text: "Darrell Steward",
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),

        // Notification Icon
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.notifications_outlined,
            color: Colors.grey[700],
            size: 20.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(DashboardController controller) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.receipt_long_outlined,
                title: "Total Order",
                value: "25+",
                percentage: "20%",
                isPositive: true,
                subtitle: "last week",
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildStatCard(
                icon: Icons.pending_outlined,
                title: "Pending Order",
                value: "05",
                percentage: "10%",
                isPositive: false,
                subtitle: "last week",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.receipt_long_outlined,
                title: "Total Hospital",
                value: "25+",
                percentage: "20%",
                isPositive: true,
                subtitle: "last week",
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildStatCard(
                icon: Icons.pending_outlined,
                title: "Pending Total Tips",
                value: "100",
                percentage: "10%",
                isPositive: false,
                subtitle: "last week",
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.receipt_long_outlined,
                title: "Total User",
                value: "1225",
                percentage: "20%",
                isPositive: true,
                subtitle: "last week",
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildStatCard(
                icon: Icons.pending_outlined,
                title: "Pending Total Tips",
                value: "03",
                percentage: "10%",
                isPositive: false,
                subtitle: "last week",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String percentage,
    required bool isPositive,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: Colors.grey[600],
              size: 20.sp,
            ),
          ),
          SizedBox(height: 16.h),
          smallText(
            text: title,
            color: Colors.grey[600]!,
          ),
          SizedBox(height: 4.h),
          headingText(
            text: value,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                isPositive ? Icons.trending_up : Icons.trending_down,
                color: isPositive ? Colors.green : Colors.red,
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              smallText(
                text: percentage,
                color: isPositive ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(width: 4.w),
              smallText(
                text: subtitle,
                color: Colors.grey[500]!,
              ),
            ],
          ),
        ],
      ),
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
