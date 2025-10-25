class LicenseModel {
  final String id;
  final String titleEn;
  final String titleAr;
  final String ministryNameEn;
  final String ministryNameAr;
  final String recipientNameEn;
  final String recipientNameAr;
  final String idHolderNumber;
  final String professionEn;
  final String professionAr;
  final String issueDate;
  final String expiryDate;
  final String authorizedDocumentId;
  final String disclaimerEn;
  final String disclaimerAr;
  final String licenseNumber;
  final String licenseStatus;
  final String licenseExpiryDate;
  final List<String> attachments;

  LicenseModel({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.ministryNameEn,
    required this.ministryNameAr,
    required this.recipientNameEn,
    required this.recipientNameAr,
    required this.idHolderNumber,
    required this.professionEn,
    required this.professionAr,
    required this.issueDate,
    required this.expiryDate,
    required this.authorizedDocumentId,
    required this.disclaimerEn,
    required this.disclaimerAr,
    required this.licenseNumber,
    required this.licenseStatus,
    required this.licenseExpiryDate,
    this.attachments = const [],
  });

  factory LicenseModel.fromJson(Map<String, dynamic> json) {
    return LicenseModel(
      id: json['id'] ?? '',
      titleEn: json['title_en'] ?? '',
      titleAr: json['title_ar'] ?? '',
      ministryNameEn: json['ministry_name_en'] ?? '',
      ministryNameAr: json['ministry_name_ar'] ?? '',
      recipientNameEn: json['recipient_name_en'] ?? '',
      recipientNameAr: json['recipient_name_ar'] ?? '',
      idHolderNumber: json['id_holder_number'] ?? '',
      professionEn: json['profession_en'] ?? '',
      professionAr: json['profession_ar'] ?? '',
      issueDate: json['issue_date'] ?? '',
      expiryDate: json['expiry_date'] ?? '',
      authorizedDocumentId: json['authorized_document_id'] ?? '',
      disclaimerEn: json['disclaimer_en'] ?? '',
      disclaimerAr: json['disclaimer_ar'] ?? '',
      licenseNumber: json['license_number'] ?? '',
      licenseStatus: json['license_status'] ?? '',
      licenseExpiryDate: json['license_expiry_date'] ?? '',
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_en': titleEn,
      'title_ar': titleAr,
      'ministry_name_en': ministryNameEn,
      'ministry_name_ar': ministryNameAr,
      'recipient_name_en': recipientNameEn,
      'recipient_name_ar': recipientNameAr,
      'id_holder_number': idHolderNumber,
      'profession_en': professionEn,
      'profession_ar': professionAr,
      'issue_date': issueDate,
      'expiry_date': expiryDate,
      'authorized_document_id': authorizedDocumentId,
      'disclaimer_en': disclaimerEn,
      'disclaimer_ar': disclaimerAr,
      'license_number': licenseNumber,
      'license_status': licenseStatus,
      'license_expiry_date': licenseExpiryDate,
      'attachments': attachments,
    };
  }

  LicenseModel copyWith({
    String? id,
    String? titleEn,
    String? titleAr,
    String? ministryNameEn,
    String? ministryNameAr,
    String? recipientNameEn,
    String? recipientNameAr,
    String? idHolderNumber,
    String? professionEn,
    String? professionAr,
    String? issueDate,
    String? expiryDate,
    String? authorizedDocumentId,
    String? disclaimerEn,
    String? disclaimerAr,
    String? licenseNumber,
    String? licenseStatus,
    String? licenseExpiryDate,
    List<String>? attachments,
  }) {
    return LicenseModel(
      id: id ?? this.id,
      titleEn: titleEn ?? this.titleEn,
      titleAr: titleAr ?? this.titleAr,
      ministryNameEn: ministryNameEn ?? this.ministryNameEn,
      ministryNameAr: ministryNameAr ?? this.ministryNameAr,
      recipientNameEn: recipientNameEn ?? this.recipientNameEn,
      recipientNameAr: recipientNameAr ?? this.recipientNameAr,
      idHolderNumber: idHolderNumber ?? this.idHolderNumber,
      professionEn: professionEn ?? this.professionEn,
      professionAr: professionAr ?? this.professionAr,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      authorizedDocumentId: authorizedDocumentId ?? this.authorizedDocumentId,
      disclaimerEn: disclaimerEn ?? this.disclaimerEn,
      disclaimerAr: disclaimerAr ?? this.disclaimerAr,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      licenseStatus: licenseStatus ?? this.licenseStatus,
      licenseExpiryDate: licenseExpiryDate ?? this.licenseExpiryDate,
      attachments: attachments ?? this.attachments,
    );
  }
}
