import 'package:mothmerah_app/views/license/data/license_model.dart';
import 'package:mothmerah_app/views/license/data/file_upload_model.dart';

abstract class LicenseState {}

class LicenseInitial extends LicenseState {}

class LicenseLoading extends LicenseState {}

class LicenseLoaded extends LicenseState {
  final List<LicenseModel> licenses;

  LicenseLoaded({required this.licenses});
}

class LicenseDetailLoaded extends LicenseState {
  final LicenseModel license;

  LicenseDetailLoaded({required this.license});
}

class LicenseError extends LicenseState {
  final String error;

  LicenseError({required this.error});
}

class LicenseAttachmentUploading extends LicenseState {
  final String licenseId;
  final double progress;

  LicenseAttachmentUploading({required this.licenseId, required this.progress});
}

class LicenseAttachmentUploaded extends LicenseState {
  final String licenseId;
  final String attachmentId;

  LicenseAttachmentUploaded({
    required this.licenseId,
    required this.attachmentId,
  });
}

class LicenseAttachmentUploadFailed extends LicenseState {
  final String licenseId;
  final String error;

  LicenseAttachmentUploadFailed({required this.licenseId, required this.error});
}

class LicenseFilesLoaded extends LicenseState {
  final String licenseId;
  final List<FileUploadModel> files;

  LicenseFilesLoaded({required this.licenseId, required this.files});
}

class LicenseFileUploading extends LicenseState {
  final String licenseId;
  final FileUploadModel file;
  final double progress;

  LicenseFileUploading({
    required this.licenseId,
    required this.file,
    required this.progress,
  });
}

class LicenseFileUploaded extends LicenseState {
  final String licenseId;
  final FileUploadModel file;

  LicenseFileUploaded({required this.licenseId, required this.file});
}

class LicenseFileUploadFailed extends LicenseState {
  final String licenseId;
  final FileUploadModel file;
  final String error;

  LicenseFileUploadFailed({
    required this.licenseId,
    required this.file,
    required this.error,
  });
}

class LicenseFileDeleted extends LicenseState {
  final String licenseId;
  final String fileId;

  LicenseFileDeleted({required this.licenseId, required this.fileId});
}
