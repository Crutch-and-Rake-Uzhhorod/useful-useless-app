import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/firestore_user_data_model.dart';
import 'firestore_service.dart';

class FirebaseAuthService {
  FirebaseAuthService({
    required FirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  final FirestoreService _firestoreService;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _auth.currentUser;

  Future<User?> signInAnonymously() async {
    final credentials = await _auth.signInAnonymously();
    return credentials.user;
  }

  Future<User?> signInWithGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();

    User? user;
    if (googleSignInAccount != null) {
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await _auth.signInWithCredential(credential);
      user = authResult.user!;

      final userDataModel = FirestoreUserDataModel(
        authType: 'Google',
        notificationEnabled: true,
        userHouses: [],
      );
      await _firestoreService.addUserIfMissing(user.uid, userDataModel);

      log('signInWithGoogle succeeded: $user');
    }
    return user;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    print('User Sign Out');
  }
}
