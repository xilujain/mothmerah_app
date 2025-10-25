class FileUploadModel {
  final String id;
  final String fileName;
  final String filePath;
  final String fileSize;
  final String fileType;
  final DateTime uploadDate;
  final FileUploadStatus status;
  final double? progress;

  FileUploadModel({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.fileSize,
    required this.fileType,
    required this.uploadDate,
    required this.status,
    this.progress,
  });

  factory FileUploadModel.fromJson(Map<String, dynamic> json) {
    return FileUploadModel(
      id: json['id'] ?? '',
      fileName: json['file_name'] ?? '',
      filePath: json['file_path'] ?? '',
      fileSize: json['file_size'] ?? '',
      fileType: json['file_type'] ?? '',
      uploadDate: DateTime.parse(
        json['upload_date'] ?? DateTime.now().toIso8601String(),
      ),
      status: FileUploadStatus.values.firstWhere(
        (e) => e.toString() == 'FileUploadStatus.${json['status']}',
        orElse: () => FileUploadStatus.pending,
      ),
      progress: json['progress']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'file_path': filePath,
      'file_size': fileSize,
      'file_type': fileType,
      'upload_date': uploadDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'progress': progress,
    };
  }

  FileUploadModel copyWith({
    String? id,
    String? fileName,
    String? filePath,
    String? fileSize,
    String? fileType,
    DateTime? uploadDate,
    FileUploadStatus? status,
    double? progress,
  }) {
    return FileUploadModel(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      fileSize: fileSize ?? this.fileSize,
      fileType: fileType ?? this.fileType,
      uploadDate: uploadDate ?? this.uploadDate,
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  }
}

enum FileUploadStatus { pending, uploading, success, failed }

extension FileUploadStatusExtension on FileUploadStatus {
  String get displayName {
    switch (this) {
      case FileUploadStatus.pending:
        return 'في الانتظار';
      case FileUploadStatus.uploading:
        return 'جاري الرفع';
      case FileUploadStatus.success:
        return 'تم الرفع بنجاح';
      case FileUploadStatus.failed:
        return 'فشل الرفع';
    }
  }

  String get icon {
    switch (this) {
      case FileUploadStatus.pending:
        return '⏳';
      case FileUploadStatus.uploading:
        return '📤';
      case FileUploadStatus.success:
        return '✅';
      case FileUploadStatus.failed:
        return '❌';
    }
  }
}
