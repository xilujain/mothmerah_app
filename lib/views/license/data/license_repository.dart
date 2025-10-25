import 'package:mothmerah_app/views/license/data/license_model.dart';
import 'package:mothmerah_app/views/license/data/file_upload_model.dart';

class LicenseRepository {
  // Simulate API delay
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<List<LicenseModel>> getLicenses() async {
    await _simulateDelay();

    // Dummy data
    return [
      LicenseModel(
        id: '1',
        titleEn: 'Freelancing Practitioner Certificate',
        titleAr: 'وثيقة ممارس حر',
        ministryNameEn: 'The Ministry of Human Resource and Social Development',
        ministryNameAr: 'وزارة الموارد البشرية والتنمية الإجتماعية',
        recipientNameEn: 'Mr./ABDULMALIK MOHAMMED ALISSA',
        recipientNameAr: 'السيد/ عبد الملك محمد صالح العيسى',
        idHolderNumber: '1234567890',
        professionEn: 'Graphic Designing',
        professionAr: 'تصميم الجرافيك',
        issueDate: '2024-05-13',
        expiryDate: '2025-05-13',
        authorizedDocumentId: 'DOC12345',
        disclaimerEn:
            'This document confirms the registration of the freelancer in the Ministry of Human Resource and Social Development\'s system without responsibility or warranty in the level of the freelancer\'s skills.',
        disclaimerAr:
            'هذه الوثيقة تؤكد تسجيل الفرد المستقل في نظام وزارة الموارد البشرية والتنمية الاجتماعية دون مسؤولية أو ضمانات من الوزارة للمهارات في المهن المذكوره',
        licenseNumber: '000000000000000',
        licenseStatus: 'نشط',
        licenseExpiryDate: '2025-05-13',
        attachments: ['license_document.pdf', 'certificate.pdf'],
      ),
      LicenseModel(
        id: '2',
        titleEn: 'Business License',
        titleAr: 'رخصة تجارية',
        ministryNameEn: 'Ministry of Commerce',
        ministryNameAr: 'وزارة التجارة',
        recipientNameEn: 'Mr./AHMED ALI HASSAN',
        recipientNameAr: 'السيد/ أحمد علي حسن',
        idHolderNumber: '0987654321',
        professionEn: 'Retail Business',
        professionAr: 'تجارة التجزئة',
        issueDate: '2024-01-15',
        expiryDate: '2025-01-15',
        authorizedDocumentId: 'DOC67890',
        disclaimerEn:
            'This license permits the holder to conduct retail business activities as specified.',
        disclaimerAr:
            'هذه الرخصة تسمح لحاملها بممارسة أنشطة تجارة التجزئة كما هو محدد',
        licenseNumber: '111111111111111',
        licenseStatus: 'نشط',
        licenseExpiryDate: '2025-01-15',
        attachments: ['business_license.pdf'],
      ),
    ];
  }

  Future<LicenseModel> getLicenseById(String id) async {
    await _simulateDelay();

    final licenses = await getLicenses();
    return licenses.firstWhere((license) => license.id == id);
  }

  Future<void> uploadAttachment(String licenseId, String filePath) async {
    await _simulateDelay();

    // Simulate upload process
    // In a real app, this would upload the file to a server
  }

  Future<void> deleteAttachment(String licenseId, String attachmentId) async {
    await _simulateDelay();

    // Simulate deletion process
    // In a real app, this would delete the file from a server
  }

  Future<void> uploadFile(String licenseId, String filePath) async {
    await _simulateDelay();

    // Simulate file upload process
    // In a real app, this would upload the file to a server
  }

  Future<void> uploadFileWithBytes(String licenseId, List<int> fileBytes, String fileName) async {
    await _simulateDelay();

    // Simulate file upload process with bytes
    // In a real app, this would upload the file bytes to a server
    print('Uploading file $fileName with ${fileBytes.length} bytes for license $licenseId');
  }

  Future<List<FileUploadModel>> getLicenseFiles(String licenseId) async {
    await _simulateDelay();

    // Dummy data for uploaded files
    return [
      FileUploadModel(
        id: '1',
        fileName: 'license_document.pdf',
        filePath: '/uploads/license_document.pdf',
        fileSize: '2.5 MB',
        fileType: 'pdf',
        uploadDate: DateTime.now().subtract(const Duration(days: 1)),
        status: FileUploadStatus.success,
      ),
      FileUploadModel(
        id: '2',
        fileName: 'certificate.pdf',
        filePath: '/uploads/certificate.pdf',
        fileSize: '1.8 MB',
        fileType: 'pdf',
        uploadDate: DateTime.now().subtract(const Duration(hours: 2)),
        status: FileUploadStatus.success,
      ),
    ];
  }

  Future<void> deleteFile(String licenseId, String fileId) async {
    await _simulateDelay();

    // Simulate file deletion process
    // In a real app, this would delete the file from a server
  }
}
