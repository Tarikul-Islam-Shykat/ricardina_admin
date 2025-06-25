// controllers/notification_controller.dart
import 'package:get/get.dart';
import 'package:prettyrini/feature/notification/model/notification_model.dart';

class NotificationController extends GetxController {
  // Observable list of notifications
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  
  // Loading state
  final RxBool isLoading = false.obs;
  
  // Unread count
  RxInt get unreadCount => notifications.where((n) => !n.isRead).length.obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyNotifications();
  }

  // Load dummy notifications (simulate API call)
  void loadDummyNotifications() {
    isLoading.value = true;
    
    // Simulate API delay
    Future.delayed(const Duration(milliseconds: 500), () {
      notifications.assignAll([
        NotificationModel(
          id: '1',
          title: 'New Message',
          message: 'Scheduled maintenance will occur tonight in 2 AM. Please join the meeting.',
          timeAgo: '1 hours ago',
          isRead: false,
          actionText: 'See More',
        ),
        NotificationModel(
          id: '2',
          title: 'New Message',
          message: 'Scheduled maintenance will occur tonight in 2 AM. Please join the meeting.',
          timeAgo: '1 hours ago',
          isRead: false,
          actionText: 'See More',
        ),
        NotificationModel(
          id: '3',
          title: 'New Message',
          message: 'Scheduled maintenance will occur tonight in 2 AM. Please join the meeting.',
          timeAgo: '1 hours ago',
          isRead: true,
          actionText: 'See More',
        ),
        NotificationModel(
          id: '4',
          title: 'New Message',
          message: 'Scheduled maintenance will occur tonight in 2 AM. Please join the meeting.',
          timeAgo: '1 hours ago',
          isRead: false,
          actionText: 'See More',
        ),
        NotificationModel(
          id: '5',
          title: 'New Message',
          message: 'Scheduled maintenance will occur tonight in 2 AM. Please join the meeting.',
          timeAgo: '1 hours ago',
          isRead: false,
          actionText: 'See More',
        ),
      ]);
      
      isLoading.value = false;
    });
  }

  // Mark notification as read
  void markAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
    }
  }

  // Mark all notifications as read
  void markAllAsRead() {
    notifications.assignAll(
      notifications.map((n) => n.copyWith(isRead: true)).toList(),
    );
  }

  // Delete notification
  void deleteNotification(String notificationId) {
    notifications.removeWhere((n) => n.id == notificationId);
  }

  // Clear all notifications
  void clearAllNotifications() {
    notifications.clear();
  }

  // Refresh notifications
  void refreshNotifications() {
    loadDummyNotifications();
  }

  // Handle notification tap
  void onNotificationTap(NotificationModel notification) {
    markAsRead(notification.id);
    // Navigate to specific screen or perform action
    print('Tapped notification: ${notification.title}');
  }

  // Handle action button tap
  void onActionTap(NotificationModel notification) {
    markAsRead(notification.id);
    // Perform specific action based on notification type
    print('Action tapped for: ${notification.title}');
  }
}