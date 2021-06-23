import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CdpFirebaseApi {
  final FirebaseFirestore cloudInstance = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  
}
