enum NotificationType { success, error, warning, info }

enum NotificationCategory { today, yesterday, thisWeek, thisMonth }

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final NotificationCategory category;
  final DateTime timestamp;
  final bool isRead;
  final String? actionUrl;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.category,
    required this.timestamp,
    this.isRead = false,
    this.actionUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: NotificationType.values.firstWhere(
        (e) => e.toString() == 'NotificationType.${json['type']}',
        orElse: () => NotificationType.info,
      ),
      category: NotificationCategory.values.firstWhere(
        (e) => e.toString() == 'NotificationCategory.${json['category']}',
        orElse: () => NotificationCategory.today,
      ),
      timestamp: DateTime.parse(
        json['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
      isRead: json['is_read'] ?? false,
      actionUrl: json['action_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type.toString().split('.').last,
      'category': category.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'is_read': isRead,
      'action_url': actionUrl,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    NotificationCategory? category,
    DateTime? timestamp,
    bool? isRead,
    String? actionUrl,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      category: category ?? this.category,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      actionUrl: actionUrl ?? this.actionUrl,
    );
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} ${difference.inDays == 1 ? 'يوم' : 'أيام'}';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ${difference.inHours == 1 ? 'ساعة' : 'ساعات'}';
    } else if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} ${difference.inMinutes == 1 ? 'دقيقة' : 'دقائق'}';
    } else {
      return 'الآن';
    }
  }

  String get categoryTitle {
    switch (category) {
      case NotificationCategory.today:
        return 'اليوم';
      case NotificationCategory.yesterday:
        return 'أمس';
      case NotificationCategory.thisWeek:
        return 'هذا الاسبوع';
      case NotificationCategory.thisMonth:
        return 'هذا الشهر';
    }
  }
}
