import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FutureProvider<int> howManyPdfFilesTheUserHaveUploaded =
    FutureProvider<int>((ref) async {
  return FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc('pdfs')
      .get()
      .then((value) => value['pdfFilesUploaded'] as int);
});
