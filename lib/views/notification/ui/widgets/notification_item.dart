import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/helpers/responsive_helper.dart';
import 'package:mothmerah_app/views/notification/data/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          ResponsiveHelper.getSpacing(
            context,
            mobile: 12,
            tablet: 14,
            desktop: 16,
          ),
        ),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.grey[50] : Colors.white,
          borderRadius: BorderRadius.circular(
            ResponsiveHelper.getBorderRadius(
              context,
              mobile: 12,
              tablet: 14,
              desktop: 16,
            ),
          ),
          border: Border.all(
            color: notification.isRead
                ? Colors.grey[300]!
                : ColorsManager.kPrimaryColor.withValues(alpha: 0.3),
            width: notification.isRead ? 1 : 2,
          ),
          boxShadow: notification.isRead
              ? null
              : [
                  BoxShadow(
                    color: ColorsManager.kPrimaryColor.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Status Icon
            Container(
              width: ResponsiveHelper.getResponsiveValue(
                context,
                mobile: 12.0,
                tablet: 14.0,
                desktop: 16.0,
              ),
              height: ResponsiveHelper.getResponsiveValue(
                context,
                mobile: 12.0,
                tablet: 14.0,
                desktop: 16.0,
              ),
              decoration: BoxDecoration(
                color: _getStatusColor(),
                shape: BoxShape.circle,
              ),
            ),

            SizedBox(
              width: ResponsiveHelper.getSpacing(
                context,
                mobile: 12,
                tablet: 14,
                desktop: 16,
              ),
            ),

            // Notification Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.message,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getFontSize(
                        context,
                        mobile: 14,
                        tablet: 16,
                        desktop: 18,
                      ),
                      fontWeight: notification.isRead
                          ? FontWeight.normal
                          : FontWeight.w600,
                      color: notification.isRead
                          ? Colors.grey[600]
                          : Colors.black87,
                    ),
                  ),

                  if (notification.category == NotificationCategory.today) ...[
                    SizedBox(
                      height: ResponsiveHelper.getSpacing(
                        context,
                        mobile: 4,
                        tablet: 6,
                        desktop: 8,
                      ),
                    ),
                    Text(
                      notification.timeAgo,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(
                          context,
                          mobile: 12,
                          tablet: 14,
                          desktop: 16,
                        ),
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Action Buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!notification.isRead)
                  IconButton(
                    onPressed: onTap,
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: ResponsiveHelper.getIconSize(
                        context,
                        mobile: 20,
                        tablet: 24,
                        desktop: 28,
                      ),
                    ),
                    tooltip: 'تمييز كمقروء',
                  ),
                IconButton(
                  onPressed: () => _showDeleteDialog(context),
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: ResponsiveHelper.getIconSize(
                      context,
                      mobile: 20,
                      tablet: 24,
                      desktop: 28,
                    ),
                  ),
                  tooltip: 'حذف الإشعار',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (notification.type) {
      case NotificationType.success:
        return Colors.green;
      case NotificationType.error:
        return Colors.red;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.info:
        return Colors.blue;
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'حذف الإشعار',
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 18,
              tablet: 20,
              desktop: 22,
            ),
          ),
        ),
        content: Text(
          'هل أنت متأكد من حذف هذا الإشعار؟',
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 14,
              tablet: 16,
              desktop: 18,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
