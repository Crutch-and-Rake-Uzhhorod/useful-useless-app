import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/firestore_user_data_model.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_service.dart';

class AuthRepository {
  AuthRepository({
    required FirebaseAuthService firebaseAuthService,
    required FirestoreService firestoreService,
  })  : _firebaseAuthService = firebaseAuthService,
        _firestoreService = firestoreService;

  final FirebaseAuthService _firebaseAuthService;
  final FirestoreService _firestoreService;

  User? get currentUser => _firebaseAuthService.currentUser;

  Future<User?> signInWithGoogle() async {
    try {
      final user = await _firebaseAuthService.signInWithGoogle();

      if(user != null){
        final userDataModel = FirestoreUserDataModel(
          authType: 'Google',
          notificationEnabled: true,
          userHouses: [],
        );

        await _firestoreService.addUserIfMissing(user.uid, userDataModel);
      }

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
