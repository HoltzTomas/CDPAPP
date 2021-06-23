import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/repository/pdf_firebase_cloud_api.dart';

class PdfCloudRepository {
  final PdfFirebaseCloudApi firebaseApi = PdfFirebaseCloudApi();

  void uploadPdfFile(PdfFile file) => firebaseApi.uploadPdfFile(file);
}