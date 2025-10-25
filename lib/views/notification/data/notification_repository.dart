import 'package:mothmerah_app/views/notification/data/notification_model.dart';

class NotificationRepository {
  // Simulate API delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<List<NotificationModel>> getNotifications() async {
    await _simulateDelay();

    final now = DateTime.now();

    // Dummy data
    return [
      // Today
      NotificationModel(
        id: '1',
        title: 'تمت إضافة البطاقة البنكية بنجاح',
        message: 'تمت إضافة البطاقة البنكية بنجاح',
        type: NotificationType.success,
        category: NotificationCategory.today,
        timestamp: now.subtract(const Duration(minutes: 5)),
        isRead: false,
      ),

      // Yesterday
      NotificationModel(
        id: '2',
        title: 'تم انتهاء مزاد ( اسم المزاد )',
        message: 'تم انتهاء مزاد ( اسم المزاد )',
        type: NotificationType.error,
        category: NotificationCategory.yesterday,
        timestamp: now.subtract(const Duration(days: 3)),
        isRead: true,
      ),
      NotificationModel(
        id: '3',
        title: 'تم بدء مزاد ( اسم المزاد )',
        message: 'تم بدء مزاد ( اسم المزاد )',
        type: NotificationType.success,
        category: NotificationCategory.yesterday,
        timestamp: now.subtract(const Duration(days: 7)),
        isRead: true,
      ),

      // This Week
      NotificationModel(
        id: '4',
        title: 'تم انتهاء مزاد ( اسم المزاد )',
        message: 'تم انتهاء مزاد ( اسم المزاد )',
        type: NotificationType.error,
        category: NotificationCategory.thisWeek,
        timestamp: now.subtract(const Duration(days: 10)),
        isRead: false,
      ),
      NotificationModel(
        id: '5',
        title: 'تم بدء مزاد ( اسم المزاد )',
        message: 'تم بدء مزاد ( اسم المزاد )',
        type: NotificationType.success,
        category: NotificationCategory.thisWeek,
        timestamp: now.subtract(const Duration(days: 12)),
        isRead: false,
      ),

      // This Month
      NotificationModel(
        id: '6',
        title: 'تم انتهاء مزاد ( اسم المزاد )',
        message: 'تم انتهاء مزاد ( اسم المزاد )',
        type: NotificationType.error,
        category: NotificationCategory.thisMonth,
        timestamp: now.subtract(const Duration(days: 20)),
        isRead: true,
      ),
      NotificationModel(
        id: '7',
        title: 'تم بدء مزاد ( اسم المزاد )',
        message: 'تم بدء مزاد ( اسم المزاد )',
        type: NotificationType.success,
        category: NotificationCategory.thisMonth,
        timestamp: now.subtract(const Duration(days: 25)),
        isRead: true,
      ),
      NotificationModel(
        id: '8',
        title: 'تم انتهاء مزاد ( اسم المزاد )',
        message: 'تم انتهاء مزاد ( اسم المزاد )',
        type: NotificationType.error,
        category: NotificationCategory.thisMonth,
        timestamp: now.subtract(const Duration(days: 30)),
        isRead: false,
      ),
      NotificationModel(
        id: '9',
        title: 'تم بدء مزاد ( اسم المزاد )',
        message: 'تم بدء مزاد ( اسم المزاد )',
        type: NotificationType.success,
        category: NotificationCategory.thisMonth,
        timestamp: now.subtract(const Duration(days: 35)),
        isRead: false,
      ),
    ];
  }

  Future<void> markAsRead(String notificationId) async {
    await _simulateDelay();

    // Simulate marking as read
    // In a real app, this would update the server
  }

  Future<void> markAllAsRead() async {
    await _simulateDelay();

    // Simulate marking all as read
    // In a real app, this would update the server
  }

  Future<void> deleteNotification(String notificationId) async {
    await _simulateDelay();

    // Simulate deletion
    // In a real app, this would delete from the server
  }
}
