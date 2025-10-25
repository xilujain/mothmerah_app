import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/helpers/responsive_helper.dart';
import 'package:mothmerah_app/views/notification/data/notification_model.dart';
import 'package:mothmerah_app/views/notification/data/notification_repository.dart';
import 'package:mothmerah_app/views/notification/ui/logic/cubit/notification_cubit.dart';
import 'package:mothmerah_app/views/notification/ui/logic/cubit/notification_state.dart';
import 'package:mothmerah_app/views/notification/ui/widgets/notification_item.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with TickerProviderStateMixin {
  late NotificationCubit _cubit;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _cubit = NotificationCubit(NotificationRepository());
    _cubit.loadNotifications();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _cubit.close();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'الإشعارات',
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context,
                mobile: 20,
                tablet: 24,
                desktop: 28,
              ),
              fontWeight: FontWeight.bold,
              color: ColorsManager.kPrimaryColor,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _markAllAsRead,
              icon: Icon(
                Icons.done_all,
                color: ColorsManager.kPrimaryColor,
                size: ResponsiveHelper.getIconSize(
                  context,
                  mobile: 20,
                  tablet: 24,
                  desktop: 28,
                ),
              ),
            ),
          ],
        ),
        body: BlocConsumer<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is NotificationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is AllNotificationsMarkedAsRead) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تمييز جميع الإشعارات كمقروءة'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is NotificationLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorsManager.kPrimaryColor,
                  ),
                ),
              );
            }

            if (state is NotificationError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: ResponsiveHelper.getIconSize(
                        context,
                        mobile: 64,
                        tablet: 80,
                        desktop: 96,
                      ),
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: ResponsiveHelper.getSpacing(
                        context,
                        mobile: 16,
                        tablet: 20,
                        desktop: 24,
                      ),
                    ),
                    Text(
                      'خطأ في تحميل الإشعارات',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(
                          context,
                          mobile: 18,
                          tablet: 20,
                          desktop: 22,
                        ),
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveHelper.getSpacing(
                        context,
                        mobile: 8,
                        tablet: 10,
                        desktop: 12,
                      ),
                    ),
                    Text(
                      state.error,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(
                          context,
                          mobile: 14,
                          tablet: 16,
                          desktop: 18,
                        ),
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: ResponsiveHelper.getSpacing(
                        context,
                        mobile: 24,
                        tablet: 28,
                        desktop: 32,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _cubit.loadNotifications(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.kPrimaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 24,
                            tablet: 28,
                            desktop: 32,
                          ),
                          vertical: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 12,
                            tablet: 14,
                            desktop: 16,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ResponsiveHelper.getBorderRadius(
                              context,
                              mobile: 12,
                              tablet: 14,
                              desktop: 16,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'إعادة المحاولة',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(
                            context,
                            mobile: 14,
                            tablet: 16,
                            desktop: 18,
                          ),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is NotificationLoaded) {
              if (state.notifications.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: ResponsiveHelper.getIconSize(
                          context,
                          mobile: 80,
                          tablet: 100,
                          desktop: 120,
                        ),
                        color: Colors.grey[400],
                      ),
                      SizedBox(
                        height: ResponsiveHelper.getSpacing(
                          context,
                          mobile: 16,
                          tablet: 20,
                          desktop: 24,
                        ),
                      ),
                      Text(
                        'لا توجد إشعارات',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(
                            context,
                            mobile: 20,
                            tablet: 24,
                            desktop: 28,
                          ),
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: ResponsiveHelper.getSpacing(
                          context,
                          mobile: 8,
                          tablet: 10,
                          desktop: 12,
                        ),
                      ),
                      Text(
                        'لم يتم العثور على أي إشعارات',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(
                            context,
                            mobile: 14,
                            tablet: 16,
                            desktop: 18,
                          ),
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildNotificationsList(state.notifications),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildNotificationsList(List<NotificationModel> notifications) {
    // Group notifications by category
    final groupedNotifications =
        <NotificationCategory, List<NotificationModel>>{};

    for (final notification in notifications) {
      if (!groupedNotifications.containsKey(notification.category)) {
        groupedNotifications[notification.category] = [];
      }
      groupedNotifications[notification.category]!.add(notification);
    }

    return ListView.builder(
      padding: EdgeInsets.all(
        ResponsiveHelper.getSpacing(
          context,
          mobile: 16,
          tablet: 20,
          desktop: 24,
        ),
      ),
      itemCount: groupedNotifications.length,
      itemBuilder: (context, index) {
        final category = groupedNotifications.keys.elementAt(index);
        final categoryNotifications = groupedNotifications[category]!;

        return _buildCategorySection(category, categoryNotifications);
      },
    );
  }

  Widget _buildCategorySection(
    NotificationCategory category,
    List<NotificationModel> notifications,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveHelper.getSpacing(
              context,
              mobile: 8,
              tablet: 10,
              desktop: 12,
            ),
          ),
          child: Text(
            _getCategoryTitle(category),
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
              fontWeight: FontWeight.bold,
              color: ColorsManager.kPrimaryColor,
            ),
          ),
        ),

        // Notifications in this category
        ...notifications.map(
          (notification) => Padding(
            padding: EdgeInsets.only(
              bottom: ResponsiveHelper.getSpacing(
                context,
                mobile: 8,
                tablet: 10,
                desktop: 12,
              ),
            ),
            child: NotificationItem(
              notification: notification,
              onTap: () => _markAsRead(notification.id),
              onDelete: () => _deleteNotification(notification.id),
            ),
          ),
        ),

        // Divider
        if (category != NotificationCategory.thisMonth)
          Container(
            margin: EdgeInsets.symmetric(
              vertical: ResponsiveHelper.getSpacing(
                context,
                mobile: 16,
                tablet: 20,
                desktop: 24,
              ),
            ),
            height: 1,
            color: Colors.grey[300],
          ),
      ],
    );
  }

  String _getCategoryTitle(NotificationCategory category) {
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

  void _markAsRead(String notificationId) {
    _cubit.markAsRead(notificationId);
  }

  void _markAllAsRead() {
    _cubit.markAllAsRead();
  }

  void _deleteNotification(String notificationId) {
    _cubit.deleteNotification(notificationId);
  }
}
