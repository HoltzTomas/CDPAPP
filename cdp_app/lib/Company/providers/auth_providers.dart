import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<Stream<User?>> authChanges = StateProvider<Stream<User?>>((ref) => FirebaseAuth.instance.authStateChanges());
