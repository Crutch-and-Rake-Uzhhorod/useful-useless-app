import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_auth_service.dart';

class UserRepository {
  final _firebaseAuthService = FirebaseAuthService();

  Future<User> currentUser() => _firebaseAuthService.currentUser();
  Future<void> signOut() => _firebaseAuthService.signOut();
}
