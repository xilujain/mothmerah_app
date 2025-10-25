import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mothmerah_app/core/helpers/token_manager.dart';
import 'package:mothmerah_app/core/services/auth_service.dart';
import 'package:mothmerah_app/views/profile/data/profile_model.dart';
import 'package:mothmerah_app/views/profile/data/profile_repository.dart';
import 'package:mothmerah_app/views/profile/ui/logic/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;
  ProfileModel? _currentProfile;

  ProfileCubit(this._repository) : super(ProfileInitial());

  ProfileModel? get currentProfile => _currentProfile;

  /// Set current profile (for initialization)
  void setCurrentProfile(ProfileModel profile) {
    _currentProfile = profile;
  }

  /// Load user profile
  Future<void> loadProfile(BuildContext context) async {
    emit(ProfileLoading());

    try {
      final profile = await _repository.getProfile(context);
      _currentProfile = profile;

      await TokenManager.updateUserData(profile.toJson());

      emit(ProfileLoaded(profile));
    } catch (e) {
      // Check if it's a token expiration error
      if (e.toString().contains('انتهت صلاحية الجلسة')) {
        // Handle automatic logout
        await AuthService.handleTokenExpiration(context);
      }
      emit(ProfileError(e.toString()));
    }
  }

  /// Update user profile
  Future<void> updateProfile(ProfileModel profile) async {
    emit(ProfileUpdating());

    try {
      final updatedProfile = await _repository.updateProfile(profile);
      _currentProfile = updatedProfile;
      emit(ProfileUpdateSuccess(updatedProfile));
    } catch (e) {
      emit(ProfileUpdateError(e.toString()));
    }
  }

  /// Update specific profile fields
  Future<void> updateProfileFields({
    String? name,
    String? email,
    String? phone,
    String? profileImage,
  }) async {
    if (_currentProfile == null) {
      emit(ProfileUpdateError('لا توجد بيانات مستخدم للتحسين'));
      return;
    }

    emit(ProfileUpdating());

    try {
      final updatedProfile = _currentProfile!.copyWith(
        name: name,
        email: email,
        phone: phone,
        profileImage: profileImage,
      );

      final result = await _repository.updateProfile(updatedProfile);
      _currentProfile = result;
      emit(ProfileUpdateSuccess(result));
    } catch (e) {
      emit(ProfileUpdateError(e.toString()));
    }
  }

  /// Upload profile image
  Future<void> uploadProfileImage(String imagePath) async {
    try {
      final imageUrl = await _repository.uploadProfileImage(imagePath);

      if (_currentProfile != null) {
        final updatedProfile = _currentProfile!.copyWith(
          profileImage: imageUrl,
        );
        _currentProfile = updatedProfile;
        await TokenManager.updateUserData(updatedProfile.toJson());
        emit(ProfileImageUploaded(imageUrl));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /// Delete account
  Future<void> deleteAccount() async {
    try {
      await _repository.deleteAccount();
      _currentProfile = null;
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      await TokenManager.clearUserData();
      _currentProfile = null;
      emit(ProfileLogout());
    } catch (e) {
      // Emit error state for logout failure
      emit(ProfileError('خطأ في تسجيل الخروج: ${e.toString()}'));
    }
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    return await TokenManager.isLoggedIn();
  }

  /// Get cached profile if available
  Future<void> loadCachedProfile() async {
    try {
      final cachedData = await TokenManager.getUserData();
      if (cachedData != null) {
        _currentProfile = ProfileModel.fromJson(cachedData);
        emit(ProfileLoaded(_currentProfile!));
      } else {
        emit(ProfileError('لا توجد بيانات مستخدم محفوظة'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
