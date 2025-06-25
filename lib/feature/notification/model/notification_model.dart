// models/notification_model.dart
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String timeAgo;
  final bool isRead;
  final String? actionText;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    this.isRead = false,
    this.actionText,
  });

  // Factory constructor for creating from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      isRead: json['isRead'] ?? false,
      actionText: json['actionText'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timeAgo': timeAgo,
      'isRead': isRead,
      'actionText': actionText,
    };
  }

  // Create a copy with updated values
  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? timeAgo,
    bool? isRead,
    String? actionText,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timeAgo: timeAgo ?? this.timeAgo,
      isRead: isRead ?? this.isRead,
      actionText: actionText ?? this.actionText,
    );
  }
}