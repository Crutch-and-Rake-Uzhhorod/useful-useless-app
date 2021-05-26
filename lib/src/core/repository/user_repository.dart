import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_auth_service.dart';

class UserRepository {
  UserRepository({
    required FirebaseAuthService firebaseAuthService,
  }) : _firebaseAuthService = firebaseAuthService;

  final FirebaseAuthService _firebaseAuthService;

  Future<User?> signInWithGoogle() async {
    try {
      final user = await _firebaseAuthService.signInWithGoogle();
      return user;
    } catch (e) {
      print('Failed signing in with Google: $e');
      rethrow;
    }
  }

  User? currentUser() => _firebaseAuthService.currentUser();

  Future<void> signOut() => _firebaseAuthService.signOut();
}
