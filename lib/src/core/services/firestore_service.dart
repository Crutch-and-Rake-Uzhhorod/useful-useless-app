import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/frame_model.dart';
import '../models/timetable_model.dart';

class FirestoreService {
  static const String _dayCollectioPath = 'timetable';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DateTime>> getDates() async {
    /// getting all available documents
    final mostRecent = await _firestore.collection(_dayCollectioPath).get();

    /// extracting timestamp to generate dates
    final dates = mostRecent.docs.map((e) {
      final timetableModel = TimetableModel.fromJson(e.data());
      return timetableModel.timestamp;
    }).toList();

    return dates;
  }

  Future<List<FrameModel>> getLocationByDay({required int timestamp}) async {
    final housesSnap =
        await _firestore.collection(_dayCollectioPath).doc('$timestamp').get();

    final timetableModel = TimetableModel.fromJson(housesSnap.data()!);

    return timetableModel.locations;
  }

  Future<void> addUser() async {}

  Future<void> updateUser() async {}

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
