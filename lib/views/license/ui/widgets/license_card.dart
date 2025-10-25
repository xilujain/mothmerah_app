import 'package:flutter/material.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/helpers/responsive_helper.dart';
import 'package:mothmerah_app/views/license/data/license_model.dart';

class LicenseCard extends StatelessWidget {
  final LicenseModel license;
  final VoidCallback onTap;

  const LicenseCard({super.key, required this.license, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          ResponsiveHelper.getSpacing(
            context,
            mobile: 16,
            tablet: 20,
            desktop: 24,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            ResponsiveHelper.getBorderRadius(
              context,
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(
                    ResponsiveHelper.getSpacing(
                      context,
                      mobile: 8,
                      tablet: 10,
                      desktop: 12,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.kPrimaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.description,
                    color: ColorsManager.kPrimaryColor,
                    size: ResponsiveHelper.getIconSize(
                      context,
                      mobile: 20,
                      tablet: 24,
                      desktop: 28,
                    ),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        license.titleAr,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(
                            context,
                            mobile: 16,
                            tablet: 18,
                            desktop: 20,
                          ),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        height: ResponsiveHelper.getSpacing(
                          context,
                          mobile: 4,
                          tablet: 6,
                          desktop: 8,
                        ),
                      ),
                      Text(
                        license.ministryNameAr,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(
                            context,
                            mobile: 12,
                            tablet: 14,
                            desktop: 16,
                          ),
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: ResponsiveHelper.getIconSize(
                    context,
                    mobile: 16,
                    tablet: 18,
                    desktop: 20,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: ResponsiveHelper.getSpacing(
                context,
                mobile: 16,
                tablet: 20,
                desktop: 24,
              ),
            ),

            // License Details
            _buildDetailRow(context, 'اسم المستلم', license.recipientNameAr),
            _buildDetailRow(context, 'رقم الهوية', license.idHolderNumber),
            _buildDetailRow(context, 'المهنة', license.professionAr),
            _buildDetailRow(
              context,
              'تاريخ الإصدار',
              _formatDate(license.issueDate),
            ),
            _buildDetailRow(
              context,
              'تاريخ الانتهاء',
              _formatDate(license.expiryDate),
            ),

            SizedBox(
              height: ResponsiveHelper.getSpacing(
                context,
                mobile: 12,
                tablet: 14,
                desktop: 16,
              ),
            ),

            // Status
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.getSpacing(
                      context,
                      mobile: 8,
                      tablet: 10,
                      desktop: 12,
                    ),
                    vertical: ResponsiveHelper.getSpacing(
                      context,
                      mobile: 4,
                      tablet: 6,
                      desktop: 8,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      license.licenseStatus,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getStatusColor(license.licenseStatus),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _getStatusColor(license.licenseStatus),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: ResponsiveHelper.getSpacing(
                          context,
                          mobile: 6,
                          tablet: 8,
                          desktop: 10,
                        ),
                      ),
                      Text(
                        license.licenseStatus,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(
                            context,
                            mobile: 12,
                            tablet: 14,
                            desktop: 16,
                          ),
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(license.licenseStatus),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (license.attachments.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.getSpacing(
                        context,
                        mobile: 8,
                        tablet: 10,
                        desktop: 12,
                      ),
                      vertical: ResponsiveHelper.getSpacing(
                        context,
                        mobile: 4,
                        tablet: 6,
                        desktop: 8,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.attach_file,
                          color: Colors.blue,
                          size: ResponsiveHelper.getIconSize(
                            context,
                            mobile: 14,
                            tablet: 16,
                            desktop: 18,
                          ),
                        ),
                        SizedBox(
                          width: ResponsiveHelper.getSpacing(
                            context,
                            mobile: 4,
                            tablet: 6,
                            desktop: 8,
                          ),
                        ),
                        Text(
                          '${license.attachments.length} مرفق',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getFontSize(
                              context,
                              mobile: 12,
                              tablet: 14,
                              desktop: 16,
                            ),
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.getSpacing(
          context,
          mobile: 2,
          tablet: 3,
          desktop: 4,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: ResponsiveHelper.getResponsiveValue(
              context,
              mobile: 100.0,
              tablet: 120.0,
              desktop: 140.0,
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(
                  context,
                  mobile: 12,
                  tablet: 14,
                  desktop: 16,
                ),
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(
                  context,
                  mobile: 12,
                  tablet: 14,
                  desktop: 16,
                ),
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'نشط':
      case 'active':
        return Colors.green;
      case 'منتهي':
      case 'expired':
        return Colors.red;
      case 'معلق':
      case 'suspended':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
