import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/views/profile/data/profile_model.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_cubit.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_state.dart';
import 'package:mothmerah_app/views/profile/ui/widgets/profile_info_block.dart';
import 'package:mothmerah_app/views/profile/ui/widgets/profile_picture_section.dart';
import 'package:mothmerah_app/views/profile/ui/widgets/profile_action_buttons.dart';
import 'package:mothmerah_app/views/profile/ui/widgets/profile_image_picker.dart';
import 'package:mothmerah_app/views/profile/ui/widgets/profile_edit_dialog.dart';

class ProfileContent extends StatelessWidget {
  final ProfileModel? profile;

  const ProfileContent({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        return Column(
          children: [
            // Profile Picture Section
            ProfilePictureSection(
              profile: profile,
              onImageTap: () => ProfileImagePicker.show(context),
            ),

            SizedBox(height: 40.h),

            // User Information Block
            ProfileInfoBlock(
              title: 'معلومات المستخدم',
              children: [
                ProfileInfoRow(
                  label: 'الاسم',
                  value: profile?.name ?? 'لم يتم تحديد الاسم',
                  onTap: () {
                    ProfileEditDialog.show(
                      context,
                      'الاسم',
                      profile?.name ?? '',
                      (value) {
                        if (profile != null) {
                          cubit.updateProfile(profile!.copyWith(name: value));
                        }
                      },
                    );
                  },
                ),
                ProfileInfoRow(
                  label: 'اسم المستخدم',
                  value: profile?.username ?? 'لم يتم تحديد اسم المستخدم',
                  onTap: () {
                    ProfileEditDialog.show(
                      context,
                      'اسم المستخدم',
                      profile?.username ?? '',
                      (value) {
                        if (profile != null) {
                          cubit.updateProfile(
                            profile!.copyWith(username: value),
                          );
                        }
                      },
                    );
                  },
                ),
                ProfileInfoRow(
                  label: 'رقم الجوال',
                  value: profile?.phone ?? 'لم يتم تحديد رقم الجوال',
                  onTap: () {
                    ProfileEditDialog.show(
                      context,
                      'رقم الجوال',
                      profile?.phone ?? '',
                      (value) {
                        if (profile != null) {
                          cubit.updateProfile(profile!.copyWith(phone: value));
                        }
                      },
                    );
                  },
                ),
                ProfileInfoRow(
                  label: 'البريد الإلكتروني',
                  value: profile?.email ?? 'لم يتم تحديد البريد الإلكتروني',
                  onTap: () {
                    ProfileEditDialog.show(
                      context,
                      'البريد الإلكتروني',
                      profile?.email ?? '',
                      (value) {
                        if (profile != null) {
                          cubit.updateProfile(profile!.copyWith(email: value));
                        }
                      },
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Additional User Info Block
            ProfileInfoBlock(
              title: 'معلومات إضافية',
              children: [
                ProfileInfoRow(
                  label: 'معرف المستخدم',
                  value: profile?.id ?? 'غير محدد',
                  onTap: () {
                    // Handle user ID
                  },
                ),
                ProfileInfoRow(
                  label: 'تاريخ الإنشاء',
                  value: profile?.createdAt != null
                      ? DateTime.parse(
                          profile!.createdAt!,
                        ).toLocal().toIso8601String().split('T')[0]
                      : 'غير محدد',
                  onTap: () {
                    // Handle creation date
                  },
                ),
                ProfileInfoRow(
                  label: 'آخر تحديث',
                  value: profile?.updatedAt != null
                      ? DateTime.parse(
                          profile!.updatedAt!,
                        ).toLocal().toIso8601String().split('T')[0]
                      : 'غير محدد',
                  onTap: () {
                    // Handle last update
                  },
                ),
                if (profile?.address != null)
                  ProfileInfoRow(
                    label: 'العنوان',
                    value: profile!.address!,
                    onTap: () {
                      ProfileEditDialog.show(
                        context,
                        'العنوان',
                        profile!.address ?? '',
                        (value) {
                          if (profile != null) {
                            cubit.updateProfile(
                              profile!.copyWith(address: value),
                            );
                          }
                        },
                      );
                    },
                  ),
                if (profile?.licenses != null)
                  ProfileInfoRow(
                    label: 'التراخيص',
                    value: profile!.licenses!,
                    onTap: () {
                      // Handle licenses
                    },
                  ),
              ],
            ),

            SizedBox(height: 16.h),

            // Account Settings Block
            ProfileInfoBlock(
              title: 'إعدادات الحساب',
              children: [
                ProfileInfoRow(
                  label: 'حالة الحساب',
                  value: '✅ نشط',
                  onTap: () {
                    // Handle account status
                  },
                ),
                ProfileInfoRow(
                  label: 'نوع المستخدم',
                  value: 'مستخدم عادي',
                  onTap: () {
                    // Handle user type
                  },
                ),
                ProfileInfoRow(
                  label: 'الدور الافتراضي',
                  value: 'مستخدم',
                  onTap: () {
                    // Handle default role
                  },
                ),
                ProfileInfoRow(
                  label: 'حالة التحقق',
                  value: profile?.isVerified == true ? '✅ محقق' : '❌ غير محقق',
                  onTap: () {
                    // Handle verification status
                  },
                ),
                ProfileInfoRow(
                  label: 'اللغة المفضلة',
                  value: 'العربية',
                  onTap: () {
                    // Handle preferred language
                  },
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // General Settings & Support Block
            ProfileInfoBlock(
              title: 'الإعدادات والدعم',
              children: [
                ProfileInfoRow(
                  label: 'المدفوعات',
                  value: '💳 إدارة المدفوعات',
                  onTap: () {
                    // Handle payments
                  },
                ),
                ProfileInfoRow(
                  label: 'العناوين',
                  value: '📍 إدارة العناوين',
                  onTap: () {
                    // Handle address
                  },
                ),
                ProfileInfoRow(
                  label: 'الضمان الذهبي',
                  value: '🏆 ضمان ذهبي نشط',
                  onTap: () {
                    // Handle golden guarantee
                  },
                ),
                ProfileInfoRow(
                  label: 'الأسئلة الشائعة',
                  value: '❓ عرض الأسئلة',
                  onTap: () {
                    // Handle FAQ
                  },
                ),
                ProfileInfoRow(
                  label: 'تواصل معنا',
                  value: '📞 مركز التواصل',
                  onTap: () {
                    // Handle contact us
                  },
                ),
                ProfileInfoRow(
                  label: 'مركز المساعدة',
                  value: '🆘 المساعدة والدعم',
                  onTap: () {
                    // Handle help center
                  },
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Action Buttons
            ProfileActionButtons(),
          ],
        );
      },
    );
  }
}
