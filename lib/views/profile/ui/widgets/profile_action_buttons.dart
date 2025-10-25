import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/core/helpers/token_manager.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_cubit.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_state.dart';
import 'package:mothmerah_app/views/profile/ui/widgets/profile_info_block.dart';

class ProfileActionButtons extends StatelessWidget {
  const ProfileActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        return Column(
          children: [
            // Action Buttons Block
            ProfileInfoBlock(
              title: 'الإجراءات',
              children: [
                ProfileActionRow(
                  label: '🔐 تغيير كلمة المرور',
                  color: ColorsManager.kPrimaryColor,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.newPasswordView);
                  },
                ),
                ProfileActionRow(
                  label: '🗑️ مسح البيانات المحفوظة',
                  color: Colors.orange,
                  onTap: () {
                    _showClearDataDialog(context, cubit);
                  },
                ),
                ProfileActionRow(
                  label: '❌ حذف الحساب',
                  color: Colors.red,
                  onTap: () {
                    _showDeleteAccountDialog(context, cubit);
                  },
                ),
              ],
            ),

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
                    '🚪 تسجيل الخروج',
                    style: textStyles.font16PrimaryBold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        );
      },
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
              print('🗑️ بدء مسح البيانات المحفوظة...');
              await TokenManager.forceClearAllData();
              print('✅ تم مسح جميع البيانات بنجاح');
              print('🔄 إعادة تحميل الصفحة...');
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
