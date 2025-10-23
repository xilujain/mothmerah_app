import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/helpers/token_manager.dart';
import 'package:mothmerah_app/core/routing/app_router.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/core/widgets/scrollable_wrapper.dart';
import 'package:mothmerah_app/views/profile/data/profile_model.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_cubit.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_state.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    // Load profile when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is ProfileLogout) {
              // Navigate to login screen
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginView,
                (route) => false,
              );
            } else if (state is ProfileDeleted) {
              // Navigate to login screen after account deletion
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginView,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<ProfileCubit>();

            // Get profile from state or cubit
            ProfileModel? profile;
            if (state is ProfileLoaded) {
              profile = state.profile;
            } else if (state is ProfileUpdated) {
              profile = state.profile;
            } else {
              profile = cubit.currentProfile;
            }

            // Show loading indicator if loading
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Show error message if error
            if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      'خطأ في تحميل البيانات',
                      style: TextStyles(context).font18PrimaryBold,
                    ),
                    SizedBox(height: 8),
                    Text(
                      state.error,
                      style: TextStyles(context).font14GrayRegular,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => cubit.loadProfile(),
                      child: Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            return ScrollableWrapper(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: ColorsManager.kPrimaryColor,
                            size: 24.sp,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'تعديل الملف الشخصي',
                            textAlign: TextAlign.center,
                            style: textStyles.font20PrimaryBold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Handle share/export profile
                          },
                          icon: Icon(
                            Icons.share_outlined,
                            color: ColorsManager.kPrimaryColor,
                            size: 24.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Profile Picture Section
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Handle profile image change
                            _showImagePicker(context, cubit);
                          },
                          child: Container(
                            width: 120.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorsManager.kLightPurple,
                                width: 3.w,
                              ),
                            ),
                            child: ClipOval(
                              child: profile?.profileImage != null
                                  ? Image.network(
                                      profile!.profileImage!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return _buildDefaultAvatar();
                                          },
                                    )
                                  : _buildDefaultAvatar(),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        GestureDetector(
                          onTap: () {
                            _showImagePicker(context, cubit);
                          },
                          child: Text(
                            'تغيير الصورة',
                            style: textStyles.font14PrimaryBold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // User Information Block
                  _buildInfoBlock(context, textStyles, 'معلومات المستخدم', [
                    _buildInfoRow(
                      context,
                      textStyles,
                      'الاسم',
                      profile?.name ?? 'لم يتم تحديد الاسم',
                      () {
                        _showEditDialog(context, 'الاسم', profile?.name ?? '', (
                          value,
                        ) {
                          if (profile != null) {
                            cubit.updateProfile(profile.copyWith(name: value));
                          }
                        });
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'اسم المستخدم',
                      profile?.username ?? 'لم يتم تحديد اسم المستخدم',
                      () {
                        _showEditDialog(
                          context,
                          'اسم المستخدم',
                          profile?.username ?? '',
                          (value) {
                            if (profile != null) {
                              cubit.updateProfile(
                                profile.copyWith(username: value),
                              );
                            }
                          },
                        );
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'رقم الجوال',
                      profile?.phone ?? 'لم يتم تحديد رقم الجوال',
                      () {
                        _showEditDialog(
                          context,
                          'رقم الجوال',
                          profile?.phone ?? '',
                          (value) {
                            if (profile != null) {
                              cubit.updateProfile(
                                profile.copyWith(phone: value),
                              );
                            }
                          },
                        );
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'البريد الإلكتروني',
                      profile?.email ?? 'لم يتم تحديد البريد الإلكتروني',
                      () {
                        _showEditDialog(
                          context,
                          'البريد الإلكتروني',
                          profile?.email ?? '',
                          (value) {
                            if (profile != null) {
                              cubit.updateProfile(
                                profile.copyWith(email: value),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ]),

                  SizedBox(height: 16.h),

                  // Additional User Info Block
                  _buildInfoBlock(context, textStyles, 'معلومات إضافية', [
                    _buildInfoRow(
                      context,
                      textStyles,
                      'معرف المستخدم',
                      profile?.id ?? 'غير محدد',
                      () {
                        // Handle user ID
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'تاريخ الإنشاء',
                      'اليوم', // يمكن استخراجها من created_at
                      () {
                        // Handle creation date
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'آخر تحديث',
                      'اليوم', // يمكن استخراجها من updated_at
                      () {
                        // Handle last update
                      },
                    ),
                    if (profile?.address != null)
                      _buildInfoRow(
                        context,
                        textStyles,
                        'العنوان',
                        profile!.address!,
                        () {
                          _showEditDialog(
                            context,
                            'العنوان',
                            profile!.address ?? '',
                            (value) {
                              cubit.updateProfile(
                                profile!.copyWith(address: value),
                              );
                            },
                          );
                        },
                      ),
                    if (profile?.licenses != null)
                      _buildInfoRow(
                        context,
                        textStyles,
                        'التراخيص',
                        profile!.licenses!,
                        () {
                          // Handle licenses
                        },
                      ),
                  ]),

                  SizedBox(height: 16.h),

                  // Account Settings Block
                  _buildInfoBlock(context, textStyles, 'إعدادات الحساب', [
                    _buildInfoRow(
                      context,
                      textStyles,
                      'حالة الحساب',
                      'نشط', // يمكن استخراجها من account_status
                      () {
                        // Handle account status
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'نوع المستخدم',
                      'عادي', // يمكن استخراجها من user_type
                      () {
                        // Handle user type
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'الدور الافتراضي',
                      'مستخدم', // يمكن استخراجها من default_role
                      () {
                        // Handle default role
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'حالة التحقق',
                      profile?.isVerified == true ? '✅ محقق' : '❌ غير محقق',
                      () {
                        // Handle verification status
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'اللغة المفضلة',
                      'العربية', // يمكن استخراجها من preferred_language
                      () {
                        // Handle preferred language
                      },
                    ),
                  ]),

                  SizedBox(height: 16.h),

                  // General Settings & Support Block
                  _buildInfoBlock(context, textStyles, 'الإعدادات والدعم', [
                    _buildInfoRow(
                      context,
                      textStyles,
                      'المدفوعات',
                      'إدارة المدفوعات',
                      () {
                        // Handle payments
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'العنوان',
                      'إدارة العناوين',
                      () {
                        // Handle address
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'الضمان الذهبي',
                      'عرض الضمان',
                      () {
                        // Handle golden guarantee
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'الأسئلة الشائعة',
                      'عرض الأسئلة',
                      () {
                        // Handle FAQ
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'تواصل معنا',
                      'مركز التواصل',
                      () {
                        // Handle contact us
                      },
                    ),
                    _buildInfoRow(
                      context,
                      textStyles,
                      'مركز المساعدة',
                      'المساعدة والدعم',
                      () {
                        // Handle help center
                      },
                    ),
                  ]),

                  SizedBox(height: 16.h),

                  // Action Buttons Block
                  _buildInfoBlock(context, textStyles, 'الإجراءات', [
                    _buildActionRow(
                      context,
                      textStyles,
                      'تغيير كلمة المرور',
                      ColorsManager.kPrimaryColor,
                      () {
                        Navigator.pushNamed(context, Routes.newPasswordView);
                      },
                    ),
                    _buildActionRow(
                      context,
                      textStyles,
                      'مسح البيانات المحفوظة',
                      Colors.orange,
                      () {
                        _showClearDataDialog(context, cubit);
                      },
                    ),
                    _buildActionRow(
                      context,
                      textStyles,
                      'حذف الحساب',
                      Colors.red,
                      () {
                        _showDeleteAccountDialog(context, cubit);
                      },
                    ),
                  ]),

                  SizedBox(height: 20.h),

                  // Logout Button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          _showLogoutDialog(context, cubit);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.kLightGray,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'تسجيل الخروج',
                          style: textStyles.font16PrimaryBold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: ColorsManager.kLightPurple,
      child: Icon(
        Icons.person,
        size: 60.sp,
        color: ColorsManager.kPrimaryColor,
      ),
    );
  }

  Widget _buildInfoBlock(
    BuildContext context,
    TextStyles textStyles,
    String title,
    List<Widget> children,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.kLightGray,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textStyles.font16PrimaryBold),
          SizedBox(height: 12.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    TextStyles textStyles,
    String label,
    String value,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(label, style: textStyles.font14PrimaryBold),
            const Spacer(),
            Text(value, style: textStyles.font14GrayRegular),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorsManager.kPrimaryColor,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionRow(
    BuildContext context,
    TextStyles textStyles,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              label,
              style: textStyles.font14PrimaryBold.copyWith(color: color),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: color, size: 16.sp),
          ],
        ),
      ),
    );
  }

  void _showImagePicker(BuildContext context, ProfileCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.camera_alt,
                color: ColorsManager.kPrimaryColor,
              ),
              title: Text(
                'التقاط صورة',
                style: TextStyles(context).font16PrimaryRegular,
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle camera
              },
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library,
                color: ColorsManager.kPrimaryColor,
              ),
              title: Text(
                'اختيار من المعرض',
                style: TextStyles(context).font16PrimaryRegular,
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle gallery
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    String title,
    String currentValue,
    Function(String) onSave,
  ) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyles(context).font18PrimaryBold),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'أدخل $title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyles(context).font14PrimaryRegular,
            ),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: Text('حفظ', style: TextStyles(context).font14PrimaryBold),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ProfileCubit cubit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تسجيل الخروج',
          style: TextStyles(context).font18PrimaryBold,
        ),
        content: Text(
          'هل أنت متأكد من تسجيل الخروج؟',
          style: TextStyles(context).font14PrimaryRegular,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyles(context).font14PrimaryRegular,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.logout();
            },
            child: Text(
              'تسجيل الخروج',
              style: TextStyles(context).font14PrimaryBold,
            ),
          ),
        ],
      ),
    );
  }

  void _showClearDataDialog(BuildContext context, ProfileCubit cubit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'مسح البيانات المحفوظة',
          style: TextStyles(context).font18PrimaryBold,
        ),
        content: Text(
          'هل تريد مسح جميع البيانات المحفوظة؟ ستحتاج لتسجيل الدخول مرة أخرى.',
          style: TextStyles(context).font14PrimaryRegular,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyles(context).font14PrimaryRegular,
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await TokenManager.forceClearAllData();
              cubit.loadProfile();
            },
            child: Text(
              'مسح',
              style: TextStyles(
                context,
              ).font14PrimaryBold.copyWith(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, ProfileCubit cubit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('حذف الحساب', style: TextStyles(context).font18PrimaryBold),
        content: Text(
          'هل أنت متأكد من حذف الحساب؟ هذا الإجراء لا يمكن التراجع عنه.',
          style: TextStyles(context).font14PrimaryRegular,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyles(context).font14PrimaryRegular,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.deleteAccount();
            },
            child: Text(
              'حذف',
              style: TextStyles(
                context,
              ).font14PrimaryBold.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
