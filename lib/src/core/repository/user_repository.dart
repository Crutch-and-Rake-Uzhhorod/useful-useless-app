import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../services/firebase_auth_service.dart';

class UserRepository {
  UserRepository({
    required FirebaseAuthService firebaseAuthService,
  }) : _firebaseAuthService = firebaseAuthService;

  final FirebaseAuthService _firebaseAuthService;

  User? get currentUser => _firebaseAuthService.currentUser;

  Future<User?> signInWithGoogle() async {
    try {
      final user = await _firebaseAuthService.signInWithGoogle();
      return user;
    } catch (e) {
      log('Failed signing in with Google: $e');
    }
  }

  Future<User?> signInAnonymously() async {
    try {
      final user = await _firebaseAuthService.signInAnonymously();
      return user;
    } catch (e) {
      log('Failed signing in anonymously: $e');
    }
  }

  Future<void> signOut() => _firebaseAuthService.signOut();
}
