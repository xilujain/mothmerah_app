import 'package:bloc/bloc.dart';
import 'package:mothmerah_app/views/notification/data/notification_repository.dart';
import 'package:mothmerah_app/views/notification/ui/logic/cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _repository;

  NotificationCubit(this._repository) : super(NotificationInitial());

  Future<void> loadNotifications() async {
    emit(NotificationLoading());

    try {
      final notifications = await _repository.getNotifications();
      emit(NotificationLoaded(notifications: notifications));
    } catch (e) {
      emit(NotificationError(error: e.toString()));
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _repository.markAsRead(notificationId);
      // Reload notifications to get updated read status
      await loadNotifications();
    } catch (e) {
      emit(NotificationError(error: e.toString()));
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _repository.markAllAsRead();
      // Reload notifications to get updated read status
      await loadNotifications();
    } catch (e) {
      emit(NotificationError(error: e.toString()));
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await _repository.deleteNotification(notificationId);
      // Reload notifications to get updated list
      await loadNotifications();
    } catch (e) {
      emit(NotificationError(error: e.toString()));
    }
  }

  void clearError() {
    if (state is NotificationError) {
      emit(NotificationInitial());
    }
  }
}
