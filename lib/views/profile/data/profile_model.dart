class ProfileModel {
  final String id;
  final String name;
  final String username;
  final String email;
  final String? profileImage;
  final String? phone;
  final String? address;
  final bool isVerified;
  final String? licenses;
  final String? verificationStatus;
  final String? goldenGuarantee;

  ProfileModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.profileImage,
    this.phone,
    this.address,
    this.isVerified = false,
    this.licenses,
    this.verificationStatus,
    this.goldenGuarantee,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    // Extract name from first_name and last_name
    String fullName = '';
    if (json['first_name'] != null && json['last_name'] != null) {
      fullName = '${json['first_name']} ${json['last_name']}';
    } else if (json['first_name'] != null) {
      fullName = json['first_name'];
    } else if (json['last_name'] != null) {
      fullName = json['last_name'];
    }

    // Extract verification status
    bool isVerified = false;
    if (json['user_verification_status_id'] != null) {
      isVerified = json['user_verification_status_id'] > 0;
    }

    // Extract verification status name
    String? verificationStatus;
    if (json['user_verification_status'] != null &&
        json['user_verification_status'] is Map<String, dynamic>) {
      final statusData =
          json['user_verification_status'] as Map<String, dynamic>;
      verificationStatus = statusData['status_name_key'];
    }

    final profile = ProfileModel(
      id: json['user_id']?.toString() ?? '',
      name: fullName.isNotEmpty ? fullName : 'المستخدم',
      username: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profile_picture_url'],
      phone: json['phone_number'],
      address: null, // Not available in this API response
      isVerified: isVerified,
      licenses: null, // Not available in this API response
      verificationStatus: verificationStatus,
      goldenGuarantee: null, // Not available in this API response
    );
    return profile;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'profile_image': profileImage,
      'phone': phone,
      'address': address,
      'is_verified': isVerified,
      'licenses': licenses,
      'verification_status': verificationStatus,
      'golden_guarantee': goldenGuarantee,
    };
  }

  ProfileModel copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    String? profileImage,
    String? phone,
    String? address,
    bool? isVerified,
    String? licenses,
    String? verificationStatus,
    String? goldenGuarantee,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      isVerified: isVerified ?? this.isVerified,
      licenses: licenses ?? this.licenses,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      goldenGuarantee: goldenGuarantee ?? this.goldenGuarantee,
    );
  }
}
