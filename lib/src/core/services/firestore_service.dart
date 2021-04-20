import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static const String _collectionPath = '/sample_data_structure/version_1.0';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // moved from auth service. consider to delete it
  void updateUserData(User user) async {
    print('updateUserData');
    var ref = _firestore.collection('users').doc(user.uid);

    await ref.set(
      {
        'uid': user.uid,
        'email': user.email,
        'photoURL': user.photoURL,
        'displayName': user.displayName,
        'lastSeen': DateTime.now()
      },
      SetOptions(merge: true),
    );
  }
}
