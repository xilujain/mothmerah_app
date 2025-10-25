import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mothmerah_app/core/theme/colors.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/views/profile/data/profile_model.dart';

class ProfilePictureSection extends StatelessWidget {
  final ProfileModel? profile;
  final VoidCallback onImageTap;

  const ProfilePictureSection({
    super.key,
    required this.profile,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles(context);

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: onImageTap,
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
                        errorBuilder: (context, error, stackTrace) {
                          return _buildDefaultAvatar();
                        },
                      )
                    : _buildDefaultAvatar(),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: onImageTap,
            child: Text('تغيير الصورة', style: textStyles.font14PrimaryBold),
          ),
        ],
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
}
