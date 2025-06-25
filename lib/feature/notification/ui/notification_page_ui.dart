// screens/welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/notification/controller/notification_controller.dart';
import 'package:prettyrini/feature/notification/model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Get.back(),
        ),
        title: headingText(
          text: "Notifications",
          color: Colors.black,
        ),
        centerTitle: true,
        // actions: [
        //   Obx(() => controller.unreadCount.value > 0
        //       ? Badge(
        //           label: Text('${controller.unreadCount.value}'),
        //           child: IconButton(
        //             icon: Icon(Icons.notifications,
        //                 color: Colors.black, size: 24.sp),
        //             onPressed: () => controller.markAllAsRead(),
        //           ),
        //         )
        //       : IconButton(
        //           icon: Icon(Icons.notifications,
        //               color: Colors.grey, size: 24.sp),
        //           onPressed: () {},
        //         )),
        // ],
      ),
      body: Column(
        children: [
          // Logo Section

          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.notifications.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: 64.sp,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16.h),
                      headingText(
                        text: "No Notifications",
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8.h),
                      normalText(
                        text: "You're all caught up!",
                        color: Colors.grey,
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async => controller.refreshNotifications(),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notifications[index];
                    return _buildNotificationItem(controller, notification);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    NotificationController controller,
    NotificationModel notification,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: notification.isRead ? Colors.grey[50] : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color:
              notification.isRead ? Colors.grey[200]! : AppColors.primaryColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => controller.onNotificationTap(notification),
        borderRadius: BorderRadius.circular(12.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Icon
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: notification.isRead
                    ? Colors.grey[300]
                    : AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.message,
                color: notification.isRead
                    ? Colors.grey[600]
                    : AppColors.whiteColor,
                size: 20.sp,
              ),
            ),

            SizedBox(width: 12.w),

            // Notification Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: headingText(
                          text: notification.title,
                          color: notification.isRead
                              ? Colors.grey[600]!
                              : Colors.black,
                          fontWeight: notification.isRead
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                      if (!notification.isRead)
                        Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  normalText(
                    text: notification.message,
                    color: Colors.grey[600]!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      smallText(
                        text: notification.timeAgo,
                        color: Colors.grey[500]!,
                      ),
                      if (notification.actionText != null)
                        InkWell(
                          onTap: () => controller.onActionTap(notification),
                          child: smallText(
                            text: notification.actionText!,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
