import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mothmerah_app/views/license/data/license_repository.dart';
import 'package:mothmerah_app/views/license/data/file_upload_model.dart';
import 'package:mothmerah_app/views/license/ui/logic/cubit/license_state.dart';

class LicenseCubit extends Cubit<LicenseState> {
  final LicenseRepository _repository;

  LicenseCubit(this._repository) : super(LicenseInitial());

  Future<void> loadLicenses() async {
    emit(LicenseLoading());

    try {
      final licenses = await _repository.getLicenses();
      emit(LicenseLoaded(licenses: licenses));
    } catch (e) {
      emit(LicenseError(error: e.toString()));
    }
  }

  Future<void> loadLicenseById(String id) async {
    emit(LicenseLoading());

    try {
      final license = await _repository.getLicenseById(id);
      emit(LicenseDetailLoaded(license: license));
    } catch (e) {
      emit(LicenseError(error: e.toString()));
    }
  }

  Future<void> uploadAttachment(String licenseId, String filePath) async {
    try {
      await _repository.uploadAttachment(licenseId, filePath);
      // Reload the license to get updated attachments
      await loadLicenseById(licenseId);
    } catch (e) {
      emit(LicenseError(error: e.toString()));
    }
  }

  Future<void> deleteAttachment(String licenseId, String attachmentId) async {
    try {
      await _repository.deleteAttachment(licenseId, attachmentId);
      // Reload the license to get updated attachments
      await loadLicenseById(licenseId);
    } catch (e) {
      emit(LicenseError(error: e.toString()));
    }
  }

  Future<void> pickAndUploadFile(String licenseId) async {
    try {
      print('Starting file picker for license: $licenseId');

      // Pick file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'txt'],
        allowMultiple: false,
        withData: true, // This ensures we get file data even on web
        withReadStream: true, // This helps with file reading
      );

      print(
        'File picker result: ${result != null ? 'File selected' : 'No file selected'}',
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        print('Selected file: ${file.name}');
        print('File path: ${file.path}');
        print('File size: ${file.size}');
        print('File extension: ${file.extension}');
        print('Has bytes: ${file.bytes != null}');

        // Check if file path is available or if we have file data
        if (file.path == null && file.bytes == null) {
          throw Exception(
            'File path and data are not available. Please try again.',
          );
        }

        // Create file upload model
        final fileUpload = FileUploadModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          fileName: file.name,
          filePath:
              file.path ??
              'memory://${file.name}', // Use memory path if file.path is null
          fileSize: _formatFileSize(file.size),
          fileType: file.extension ?? '',
          uploadDate: DateTime.now(),
          status: FileUploadStatus.uploading,
          progress: 0.0,
        );

        // Emit uploading state
        emit(
          LicenseFileUploading(
            licenseId: licenseId,
            file: fileUpload,
            progress: 0.0,
          ),
        );

        // Simulate upload progress
        await _simulateUploadProgress(licenseId, fileUpload);

        // Upload file to repository - pass file data or path
        if (file.path != null) {
          await _repository.uploadFile(licenseId, file.path!);
        } else if (file.bytes != null) {
          // For web or when file.path is null, we can simulate upload with bytes
          await _repository.uploadFileWithBytes(
            licenseId,
            file.bytes!,
            file.name,
          );
        } else {
          throw Exception('No file data available for upload');
        }

        // Emit success state
        emit(
          LicenseFileUploaded(
            licenseId: licenseId,
            file: fileUpload.copyWith(
              status: FileUploadStatus.success,
              progress: 1.0,
            ),
          ),
        );

        // Reload files
        await loadLicenseFiles(licenseId);
      }
    } catch (e) {
      print('Error in pickAndUploadFile: $e');
      print('Error type: ${e.runtimeType}');
      print('Stack trace: ${StackTrace.current}');

      emit(
        LicenseFileUploadFailed(
          licenseId: licenseId,
          file: FileUploadModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            fileName: 'Unknown',
            filePath: '',
            fileSize: '0 B',
            fileType: '',
            uploadDate: DateTime.now(),
            status: FileUploadStatus.failed,
          ),
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> loadLicenseFiles(String licenseId) async {
    try {
      final files = await _repository.getLicenseFiles(licenseId);
      emit(LicenseFilesLoaded(licenseId: licenseId, files: files));
    } catch (e) {
      emit(LicenseError(error: e.toString()));
    }
  }

  Future<void> deleteFile(String licenseId, String fileId) async {
    try {
      await _repository.deleteFile(licenseId, fileId);
      emit(LicenseFileDeleted(licenseId: licenseId, fileId: fileId));
      await loadLicenseFiles(licenseId);
    } catch (e) {
      emit(LicenseError(error: e.toString()));
    }
  }

  Future<void> _simulateUploadProgress(
    String licenseId,
    FileUploadModel file,
  ) async {
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 100));
      emit(
        LicenseFileUploading(
          licenseId: licenseId,
          file: file.copyWith(progress: i / 100),
          progress: i / 100,
        ),
      );
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  void clearError() {
    if (state is LicenseError) {
      emit(LicenseInitial());
    }
  }
}
