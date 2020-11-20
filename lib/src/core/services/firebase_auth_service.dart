import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  User loggedInUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> signInWithGoogle() async {

    final googleSignInAccount = await googleSignIn.signIn();
    final googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final authResult = await _auth.signInWithCredential(credential);
    final user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final currentUser = await _auth.currentUser;
    assert(user.uid == currentUser.uid);
    print('data333: '+user.uid);

    updateUserData(user);

    return 'signInWithGoogle succeeded: $user';

  }


  void updateUserData(User user) async {
    print('updateUserData');
    var ref = _db.collection('users').doc(user.uid);

    await ref.set({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoURL,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    },  SetOptions( merge: true));
  }

  Future<void> signOut() async{
    //await googleSignIn.signOut();
    await _auth.signOut();
    print('User Sign Out');
  }

  Future<User> currentUser() async {
      final user = await _auth.currentUser;
      return user;
  }
}