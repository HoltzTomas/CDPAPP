import 'package:cdp_app/PDF/models/pdf_file.dart';
import 'package:cdp_app/PDF/repository/pdf_firebase_cloud_api.dart';
import 'package:cdp_app/PDF/ui/screens/PdfsListScreen/widgets/uploaded_file_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PdfCloudRepository {
  final PdfFirebaseCloudApi firebaseApi = PdfFirebaseCloudApi();

  void uploadPdfFile(PdfFile file) => firebaseApi.uploadPdfFile(file);

  List<UploadedFileItem> buildUploadedFileItems(
          {required List<DocumentSnapshot<Map<String, dynamic>>> list}) =>
      firebaseApi.buildUploadedFileItems(list: list);
}
