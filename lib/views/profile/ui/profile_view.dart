import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/core/routing/routes.dart';
import 'package:mothmerah_app/core/theme/text_styles.dart';
import 'package:mothmerah_app/core/widgets/scrollable_wrapper.dart';
import 'package:mothmerah_app/views/profile/data/profile_model.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_cubit.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_state.dart';
import 'package:mothmerah_app/views/profile/ui/widgets/profile_header.dart';
import 'package:mothmerah_app/views/profile/ui/widgets/profile_content.dart';
import 'package:mothmerah_app/views/home/ui/widgets/bottom_navigation.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _selectedIndex = 0; // Profile is index 0

  @override
  void initState() {
    super.initState();
    // Load profile when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().loadProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(height: 16),
                    Text(
                      state.error,
                      style: TextStyles(context).font18PrimaryBold,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.error,
                      style: TextStyles(context).font14GrayRegular,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => cubit.loadProfile(context),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            return ScrollableWrapper(
              child: Column(
                children: [
                  // Header
                  const ProfileHeader(),

                  // Profile Content
                  ProfileContent(profile: profile),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Navigate to appropriate view based on selected index
          switch (index) {
            case 0: // الملف الشخصي
              // Already on profile view, do nothing
              break;
            case 1: // السلة
              Navigator.pushNamed(context, Routes.cartView);
              break;
            case 2: // المفضلة
              // TODO: Implement favorites view
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('صفحة المفضلة قيد التطوير'),
                  backgroundColor: Colors.orange,
                ),
              );
              break;
            case 3: // الرئيسية
              Navigator.pushNamed(context, Routes.homeView);
              break;
          }
        },
      ),
    );
  }
}
