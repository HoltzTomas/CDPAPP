import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final User? currentUser = FirebaseAuth.instance.currentUser;

final StateProvider<Stream<QuerySnapshot<Map<String, dynamic>>>>
    pdfsFirebaseCollectionProvider =
    StateProvider<Stream<QuerySnapshot<Map<String, dynamic>>>>((ref) =>
        FirebaseFirestore.instance
            .collection(currentUser!.uid)
            .doc('pdfs')
            .collection('pdfFiles')
            .snapshots());
