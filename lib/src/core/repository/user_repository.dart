
import 'package:firebase_auth/firebase_auth.dart';
import 'package:useful_useless_app/src/core/services/firebase_auth_service.dart';

class UserRepository {

  final _firebaseAuthService = FirebaseAuthService();

  //Future<User> currentUser() => _firebaseAuthService.currentUser();

}