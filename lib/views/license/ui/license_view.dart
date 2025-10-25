import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/helpers/responsive_helper.dart';
import 'package:mothmerah_app/views/license/data/license_model.dart';
import 'package:mothmerah_app/views/license/data/license_repository.dart';
import 'package:mothmerah_app/views/license/ui/logic/cubit/license_cubit.dart';
import 'package:mothmerah_app/views/license/ui/logic/cubit/license_state.dart';
import 'package:mothmerah_app/views/license/ui/widgets/license_card.dart';
import 'package:mothmerah_app/views/license/data/file_upload_model.dart';

class LicenseView extends StatefulWidget {
  const LicenseView({super.key});

  @override
  State<LicenseView> createState() => _LicenseViewState();
}

class _LicenseViewState extends State<LicenseView>
    with TickerProviderStateMixin {
  late LicenseCubit _cubit;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _cubit = LicenseCubit(LicenseRepository());
    _cubit.loadLicenses();

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
            'التراخيص',
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
        ),
        body: BlocConsumer<LicenseCubit, LicenseState>(
          listener: (context, state) {
            if (state is LicenseError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LicenseLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorsManager.kPrimaryColor,
                  ),
                ),
              );
            }

            if (state is LicenseError) {
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
                      'خطأ في تحميل التراخيص',
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
                      onPressed: () => _cubit.loadLicenses(),
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

            if (state is LicenseLoaded) {
              if (state.licenses.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description_outlined,
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
                        'لا توجد تراخيص',
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
                        'لم يتم العثور على أي تراخيص',
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
                  child: Column(
                    children: [
                      // Upload Section
                      _buildUploadSection(),

                      // Licenses List
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(
                            ResponsiveHelper.getSpacing(
                              context,
                              mobile: 16,
                              tablet: 20,
                              desktop: 24,
                            ),
                          ),
                          itemCount: state.licenses.length,
                          itemBuilder: (context, index) {
                            final license = state.licenses[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: ResponsiveHelper.getSpacing(
                                  context,
                                  mobile: 16,
                                  tablet: 20,
                                  desktop: 24,
                                ),
                              ),
                              child: LicenseCard(
                                license: license,
                                onTap: () => _navigateToLicenseDetail(license),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildUploadSection() {
    return BlocConsumer<LicenseCubit, LicenseState>(
      listener: (context, state) {
        if (state is LicenseFileUploaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم رفع الملف ${state.file.fileName} بنجاح'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (state is LicenseFileUploadFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('فشل رفع الملف: ${state.error}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        } else if (state is LicenseError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('خطأ: ${state.error}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
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
          margin: EdgeInsets.all(
            ResponsiveHelper.getSpacing(
              context,
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
          ),
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
                onTap: () {
                  print('Upload button tapped');
                  _cubit.pickAndUploadFile('general');
                },
                child: Container(
                  width: double.infinity,
                  height: ResponsiveHelper.getResponsiveValue(
                    context,
                    mobile: 100.0,
                    tablet: 120.0,
                    desktop: 140.0,
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
                    mobile: 16,
                    tablet: 20,
                    desktop: 24,
                  ),
                ),

                // Files List
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
                    mobile: 8,
                    tablet: 10,
                    desktop: 12,
                  ),
                ),

                ...files.map((file) => _buildFileItem(file)),
              ],

              // Show uploading file if any
              if (uploadingFile != null && uploadProgress != null) ...[
                SizedBox(
                  height: ResponsiveHelper.getSpacing(
                    context,
                    mobile: 12,
                    tablet: 14,
                    desktop: 16,
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
              _cubit.deleteFile('general', file.id);
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void _navigateToLicenseDetail(LicenseModel license) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) =>
              LicenseCubit(LicenseRepository())..loadLicenseById(license.id),
          child: LicenseDetailView(license: license),
        ),
      ),
    );
  }
}

class LicenseDetailView extends StatefulWidget {
  final LicenseModel license;

  const LicenseDetailView({super.key, required this.license});

  @override
  State<LicenseDetailView> createState() => _LicenseDetailViewState();
}

class _LicenseDetailViewState extends State<LicenseDetailView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

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
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'تفاصيل الترخيص',
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 18,
              tablet: 20,
              desktop: 22,
            ),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<LicenseCubit, LicenseState>(
        builder: (context, state) {
          final license = state is LicenseDetailLoaded
              ? state.license
              : widget.license;

          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(
                  ResponsiveHelper.getSpacing(
                    context,
                    mobile: 16,
                    tablet: 20,
                    desktop: 24,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // License Certificate Card
                    _buildCertificateCard(license),

                    SizedBox(
                      height: ResponsiveHelper.getSpacing(
                        context,
                        mobile: 20,
                        tablet: 24,
                        desktop: 28,
                      ),
                    ),

                    // License Information Card
                    _buildLicenseInfoCard(license),

                    SizedBox(
                      height: ResponsiveHelper.getSpacing(
                        context,
                        mobile: 20,
                        tablet: 24,
                        desktop: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCertificateCard(LicenseModel license) {
    return Container(
      decoration: BoxDecoration(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.getBorderRadius(
            context,
            mobile: 16,
            tablet: 20,
            desktop: 24,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFE4B5), // Light orange
                Colors.white,
              ],
            ),
          ),
          padding: EdgeInsets.all(
            ResponsiveHelper.getSpacing(
              context,
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // VISION 2030 Logo (placeholder)
              Container(
                height: ResponsiveHelper.getResponsiveValue(
                  context,
                  mobile: 40.0,
                  tablet: 50.0,
                  desktop: 60.0,
                ),
                width: ResponsiveHelper.getResponsiveValue(
                  context,
                  mobile: 120.0,
                  tablet: 150.0,
                  desktop: 180.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'VISION 2030',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: ResponsiveHelper.getSpacing(
                  context,
                  mobile: 16,
                  tablet: 20,
                  desktop: 24,
                ),
              ),

              // English Title
              Text(
                license.titleEn,
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
                  mobile: 8,
                  tablet: 10,
                  desktop: 12,
                ),
              ),

              // Ministry Name
              Text(
                license.ministryNameEn,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 12,
                    tablet: 14,
                    desktop: 16,
                  ),
                  color: Colors.grey[700],
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

              // Recipient Name
              Text(
                license.recipientNameEn,
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
                  mobile: 8,
                  tablet: 10,
                  desktop: 12,
                ),
              ),

              // ID Holder Number
              Text(
                'ID Holder Number: ${license.idHolderNumber}',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 12,
                    tablet: 14,
                    desktop: 16,
                  ),
                  color: Colors.grey[700],
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

              // Profession
              Text(
                'As a proof of his registration in the Ministry of Human Resource and Social Development as a freelancer in:',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 12,
                    tablet: 14,
                    desktop: 16,
                  ),
                  color: Colors.grey[700],
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
                license.professionEn,
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
                  mobile: 16,
                  tablet: 20,
                  desktop: 24,
                ),
              ),

              // Dates Table
              Container(
                padding: EdgeInsets.all(
                  ResponsiveHelper.getSpacing(
                    context,
                    mobile: 12,
                    tablet: 14,
                    desktop: 16,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    _buildDateRow('Issue Date', license.issueDate),
                    _buildDateRow('Expiry Date', license.expiryDate),
                    _buildDateRow(
                      'Authorized Document ID',
                      license.authorizedDocumentId,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.getSpacing(
          context,
          mobile: 4,
          tablet: 6,
          desktop: 8,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context,
                mobile: 12,
                tablet: 14,
                desktop: 16,
              ),
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context,
                mobile: 12,
                tablet: 14,
                desktop: 16,
              ),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseInfoCard(LicenseModel license) {
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
          // License Number
          _buildInfoRow('معلومات الترخيص', license.licenseNumber),

          const Divider(),

          // License Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'حالة الترخيص',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 14,
                    tablet: 16,
                    desktop: 18,
                  ),
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.kPrimaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.getSpacing(
                    context,
                    mobile: 12,
                    tablet: 14,
                    desktop: 16,
                  ),
                  vertical: ResponsiveHelper.getSpacing(
                    context,
                    mobile: 6,
                    tablet: 8,
                    desktop: 10,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
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
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Divider(),

          // License Expiry Date
          _buildInfoRow('تاريخ إنتهاء الرخيص', license.licenseExpiryDate),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 14,
              tablet: 16,
              desktop: 18,
            ),
            fontWeight: FontWeight.bold,
            color: ColorsManager.kPrimaryColor,
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
          value,
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(
              context,
              mobile: 14,
              tablet: 16,
              desktop: 18,
            ),
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
