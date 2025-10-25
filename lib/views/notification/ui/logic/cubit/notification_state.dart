import 'package:mothmerah_app/views/notification/data/notification_model.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationLoaded({required this.notifications});
}

class NotificationError extends NotificationState {
  final String error;

  NotificationError({required this.error});
}

class NotificationMarkedAsRead extends NotificationState {
  final String notificationId;

  NotificationMarkedAsRead({required this.notificationId});
}

class AllNotificationsMarkedAsRead extends NotificationState {}

class NotificationDeleted extends NotificationState {
  final String notificationId;

  NotificationDeleted({required this.notificationId});
}
