import 'package:mothmerah_app/views/profile/data/profile_model.dart';

class ProfileUpdateRequestModel {
  final String? phoneNumber;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profilePictureUrl;
  final int? userTypeId;
  final int? defaultUserRoleId;
  final int? userVerificationStatusId;
  final String? preferredLanguageCode;
  final bool? isDeleted;
  final Map<String, dynamic>? additionalData;

  ProfileUpdateRequestModel({
    this.phoneNumber,
    this.email,
    this.firstName,
    this.lastName,
    this.profilePictureUrl,
    this.userTypeId,
    this.defaultUserRoleId,
    this.userVerificationStatusId,
    this.preferredLanguageCode,
    this.isDeleted,
    this.additionalData,
  });

  factory ProfileUpdateRequestModel.fromProfileModel(ProfileModel profile) {
    // Split name into first and last name
    final nameParts = profile.name.split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return ProfileUpdateRequestModel(
      phoneNumber: profile.phone,
      email: profile.email,
      firstName: firstName,
      lastName: lastName,
      profilePictureUrl: profile.profileImage,
      // These fields would need to be provided from the original API response
      // or set to default values
      userTypeId: null,
      defaultUserRoleId: null,
      userVerificationStatusId: profile.isVerified ? 1 : 0,
      preferredLanguageCode: 'ar', // Default to Arabic
      isDeleted: false,
      additionalData: null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (phoneNumber != null) data['phone_number'] = phoneNumber;
    if (email != null) data['email'] = email;
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (profilePictureUrl != null)
      data['profile_picture_url'] = profilePictureUrl;
    if (userTypeId != null) data['user_type_id'] = userTypeId;
    if (defaultUserRoleId != null)
      data['default_user_role_id'] = defaultUserRoleId;
    if (userVerificationStatusId != null)
      data['user_verification_status_id'] = userVerificationStatusId;
    if (preferredLanguageCode != null)
      data['preferred_language_code'] = preferredLanguageCode;
    if (isDeleted != null) data['is_deleted'] = isDeleted;
    if (additionalData != null) data['additional_data'] = additionalData;

    return data;
  }

  ProfileUpdateRequestModel copyWith({
    String? phoneNumber,
    String? email,
    String? firstName,
    String? lastName,
    String? profilePictureUrl,
    int? userTypeId,
    int? defaultUserRoleId,
    int? userVerificationStatusId,
    String? preferredLanguageCode,
    bool? isDeleted,
    Map<String, dynamic>? additionalData,
  }) {
    return ProfileUpdateRequestModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      userTypeId: userTypeId ?? this.userTypeId,
      defaultUserRoleId: defaultUserRoleId ?? this.defaultUserRoleId,
      userVerificationStatusId:
          userVerificationStatusId ?? this.userVerificationStatusId,
      preferredLanguageCode:
          preferredLanguageCode ?? this.preferredLanguageCode,
      isDeleted: isDeleted ?? this.isDeleted,
      additionalData: additionalData ?? this.additionalData,
    );
  }
}
