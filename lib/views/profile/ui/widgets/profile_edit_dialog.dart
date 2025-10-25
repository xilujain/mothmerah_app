import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/core/helpers/responsive_helper.dart';
import 'package:mothmerah_app/views/profile/data/profile_model.dart';
import 'package:mothmerah_app/views/profile/data/profile_repository.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_cubit.dart';
import 'package:mothmerah_app/views/profile/ui/widgets/simple_profile_edit_form.dart';

class ProfileEditDialog extends StatelessWidget {
  final ProfileModel profile;
  final ProfileCubit? cubit;

  const ProfileEditDialog({super.key, required this.profile, this.cubit});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.getBorderRadius(
            context,
            mobile: 16,
            tablet: 20,
            desktop: 24,
          ),
        ),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: ResponsiveHelper.getResponsiveValue(
            context,
            mobile: double.infinity,
            tablet: 600.0,
            desktop: 700.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(
                ResponsiveHelper.getSpacing(
                  context,
                  mobile: 20,
                  tablet: 24,
                  desktop: 28,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    ResponsiveHelper.getBorderRadius(
                      context,
                      mobile: 16,
                      tablet: 20,
                      desktop: 24,
                    ),
                  ),
                  topRight: Radius.circular(
                    ResponsiveHelper.getBorderRadius(
                      context,
                      mobile: 16,
                      tablet: 20,
                      desktop: 24,
                    ),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.blue[600],
                    size: ResponsiveHelper.getIconSize(
                      context,
                      mobile: 24,
                      tablet: 28,
                      desktop: 32,
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
                      'تعديل البيانات الشخصية',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(
                          context,
                          mobile: 18,
                          tablet: 20,
                          desktop: 22,
                        ),
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey[600],
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
            ),

            // Form Content
            Flexible(
              child: SingleChildScrollView(
                child: cubit != null
                    ? BlocProvider.value(
                        value: cubit!,
                        child: SimpleProfileEditForm(profile: profile),
                      )
                    : BlocProvider(
                        create: (context) {
                          final newCubit = ProfileCubit(
                            ProfileRepository(Dio()),
                          );
                          // Initialize the cubit with the current profile data
                          newCubit.setCurrentProfile(profile);
                          return newCubit;
                        },
                        child: SimpleProfileEditForm(profile: profile),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> show(BuildContext context, ProfileModel profile) {
    // Try to get the existing ProfileCubit from the context
    ProfileCubit? existingCubit;
    try {
      existingCubit = context.read<ProfileCubit>();
    } catch (e) {
      // ProfileCubit not found in context, will create a new one
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          ProfileEditDialog(profile: profile, cubit: existingCubit),
    );
  }
}
