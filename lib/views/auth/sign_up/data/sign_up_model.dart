class SignupModel {
  final String? phoneNumber;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? profilePictureUrl;
  final int? defaultUserRoleId;
  final int? userVerificationStatusId;
  final String? preferredLanguageCode;
  final String? password;
  final String? userTypeKey;
  final String? defaultRoleKey;
  final List? translations;

  // Main constructor with parameters
  const SignupModel({
    this.phoneNumber,
    this.email,
    this.firstName,
    this.lastName,
    this.profilePictureUrl,
    this.defaultUserRoleId,
    this.userVerificationStatusId,
    this.preferredLanguageCode,
    this.password,
    this.userTypeKey,
    this.defaultRoleKey,
    this.translations,
  });

  // Factory constructor
  factory SignupModel.fromSignupData({
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    int defaultUserRoleId = 1,
    int userVerificationStatusId = 1,
    String preferredLanguageCode = "ar",
    String userTypeKey = "COMMERCIAL_BUYER",
    String defaultRoleKey = "BASE_USER",
  }) {
    return SignupModel(
      phoneNumber: phoneNumber,
      email: email,
      firstName: firstName,
      lastName: lastName,
      profilePictureUrl: null,
      defaultUserRoleId: defaultUserRoleId,
      userVerificationStatusId: userVerificationStatusId,
      preferredLanguageCode: preferredLanguageCode,
      password: password,
      userTypeKey: userTypeKey,
      defaultRoleKey: defaultRoleKey,
      translations: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "phone_number": phoneNumber,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "profile_picture_url": profilePictureUrl,
      "default_user_role_id": defaultUserRoleId,
      "user_verification_status_id": userVerificationStatusId,
      "preferred_language_code": preferredLanguageCode,
      "password": password,
      "user_type_key": userTypeKey,
      "default_role_key": defaultRoleKey,
      "translations": translations ?? [],
    };
  }
}
