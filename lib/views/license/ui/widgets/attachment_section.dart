import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/helpers/responsive_helper.dart';
import 'package:mothmerah_app/views/license/data/file_upload_model.dart';
import 'package:mothmerah_app/views/license/ui/logic/cubit/license_cubit.dart';
import 'package:mothmerah_app/views/license/ui/logic/cubit/license_state.dart';

class AttachmentSection extends StatefulWidget {
  final String licenseId;

  const AttachmentSection({super.key, required this.licenseId});

  @override
  State<AttachmentSection> createState() => _AttachmentSectionState();
}

class _AttachmentSectionState extends State<AttachmentSection> {
  @override
  void initState() {
    super.initState();
    // Load existing files when the widget initializes
    context.read<LicenseCubit>().loadLicenseFiles(widget.licenseId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LicenseCubit, LicenseState>(
      listener: (context, state) {
        if (state is LicenseFileUploaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم رفع الملف ${state.file.fileName} بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is LicenseFileUploadFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('فشل رفع الملف: ${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is LicenseFileDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('تم حذف الملف بنجاح'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      },
      builder: (context, state) {
        List<FileUploadModel> files = [];
        FileUploadModel? uploadingFile;
        double? uploadProgress;

        // Extract files and upload state from different states
        if (state is LicenseFilesLoaded) {
          files = state.files;
        } else if (state is LicenseFileUploading) {
          files = [state.file];
          uploadingFile = state.file;
          uploadProgress = state.progress;
        } else if (state is LicenseFileUploaded) {
          files = [state.file];
        }

        return Container(
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
                  Icon(
                    Icons.attach_file,
                    color: ColorsManager.kPrimaryColor,
                    size: ResponsiveHelper.getIconSize(
                      context,
                      mobile: 20,
                      tablet: 24,
                      desktop: 28,
                    ),
                  ),
                  SizedBox(
                    width: ResponsiveHelper.getSpacing(
                      context,
                      mobile: 8,
                      tablet: 10,
                      desktop: 12,
                    ),
                  ),
                  Text(
                    'إرفاق الملفات والتراخيص',
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

              // Upload Button
              GestureDetector(
                onTap: () => context.read<LicenseCubit>().pickAndUploadFile(
                  widget.licenseId,
                ),
                child: Container(
                  width: double.infinity,
                  height: ResponsiveHelper.getResponsiveValue(
                    context,
                    mobile: 120.0,
                    tablet: 140.0,
                    desktop: 160.0,
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.kPrimaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.getBorderRadius(
                        context,
                        mobile: 12,
                        tablet: 14,
                        desktop: 16,
                      ),
                    ),
                    border: Border.all(
                      color: ColorsManager.kPrimaryColor.withValues(alpha: 0.3),
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: ColorsManager.kPrimaryColor,
                        size: ResponsiveHelper.getIconSize(
                          context,
                          mobile: 32,
                          tablet: 40,
                          desktop: 48,
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
                        'إرفاق الملفات والتراخيص',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(
                            context,
                            mobile: 14,
                            tablet: 16,
                            desktop: 18,
                          ),
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (files.isNotEmpty) ...[
                SizedBox(
                  height: ResponsiveHelper.getSpacing(
                    context,
                    mobile: 20,
                    tablet: 24,
                    desktop: 28,
                  ),
                ),

                // Attachments List
                Text(
                  'الملفات المرفقة',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(
                      context,
                      mobile: 14,
                      tablet: 16,
                      desktop: 18,
                    ),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(
                  height: ResponsiveHelper.getSpacing(
                    context,
                    mobile: 12,
                    tablet: 14,
                    desktop: 16,
                  ),
                ),

                ...files.map((file) => _buildFileItem(file)),
              ],

              // Show uploading file if any
              if (uploadingFile != null && uploadProgress != null) ...[
                SizedBox(
                  height: ResponsiveHelper.getSpacing(
                    context,
                    mobile: 16,
                    tablet: 20,
                    desktop: 24,
                  ),
                ),
                _buildUploadingFile(uploadingFile, uploadProgress),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildFileItem(FileUploadModel file) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ResponsiveHelper.getSpacing(
          context,
          mobile: 8,
          tablet: 10,
          desktop: 12,
        ),
      ),
      padding: EdgeInsets.all(
        ResponsiveHelper.getSpacing(
          context,
          mobile: 12,
          tablet: 14,
          desktop: 16,
        ),
      ),
      decoration: BoxDecoration(
        color: _getFileStatusColor(file.status).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.getBorderRadius(
            context,
            mobile: 8,
            tablet: 10,
            desktop: 12,
          ),
        ),
        border: Border.all(
          color: _getFileStatusColor(file.status).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getFileIcon(file.fileType),
            color: _getFileStatusColor(file.status),
            size: ResponsiveHelper.getIconSize(
              context,
              mobile: 20,
              tablet: 24,
              desktop: 28,
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
                  file.fileName,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(
                      context,
                      mobile: 14,
                      tablet: 16,
                      desktop: 18,
                    ),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: ResponsiveHelper.getSpacing(
                    context,
                    mobile: 2,
                    tablet: 3,
                    desktop: 4,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      file.fileSize,
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
                    SizedBox(
                      width: ResponsiveHelper.getSpacing(
                        context,
                        mobile: 8,
                        tablet: 10,
                        desktop: 12,
                      ),
                    ),
                    Text(
                      file.status.displayName,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(
                          context,
                          mobile: 12,
                          tablet: 14,
                          desktop: 16,
                        ),
                        color: _getFileStatusColor(file.status),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (file.status == FileUploadStatus.success)
            IconButton(
              onPressed: () => _showDeleteFileDialog(file),
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: ResponsiveHelper.getIconSize(
                  context,
                  mobile: 18,
                  tablet: 20,
                  desktop: 22,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUploadingFile(FileUploadModel file, double progress) {
    return Container(
      padding: EdgeInsets.all(
        ResponsiveHelper.getSpacing(
          context,
          mobile: 12,
          tablet: 14,
          desktop: 16,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.getBorderRadius(
            context,
            mobile: 8,
            tablet: 10,
            desktop: 12,
          ),
        ),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.upload,
                color: Colors.blue,
                size: ResponsiveHelper.getIconSize(
                  context,
                  mobile: 20,
                  tablet: 24,
                  desktop: 28,
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
                child: Text(
                  file.fileName,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(
                      context,
                      mobile: 14,
                      tablet: 16,
                      desktop: 18,
                    ),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
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
          SizedBox(
            height: ResponsiveHelper.getSpacing(
              context,
              mobile: 8,
              tablet: 10,
              desktop: 12,
            ),
          ),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.blue.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }

  IconData _getFileIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'txt':
        return Icons.text_snippet;
      default:
        return Icons.attach_file;
    }
  }

  Color _getFileStatusColor(FileUploadStatus status) {
    switch (status) {
      case FileUploadStatus.success:
        return Colors.green;
      case FileUploadStatus.uploading:
        return Colors.blue;
      case FileUploadStatus.failed:
        return Colors.red;
      case FileUploadStatus.pending:
        return Colors.orange;
    }
  }

  void _showDeleteFileDialog(FileUploadModel file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'حذف الملف',
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
          'هل أنت متأكد من حذف الملف "${file.fileName}"؟',
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
              context.read<LicenseCubit>().deleteFile(
                widget.licenseId,
                file.id,
              );
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
