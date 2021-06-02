import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/frame_model.dart';

class FirestoreService {
  static const String _dayCollectionPath = 'timetable';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DateTime>?> getDates() async {
    try {
      final mostRecent = await _firestore.collection(_dayCollectionPath).get();

      final dates = mostRecent.docs.map((e) {
        final data = e.data();
        final rawTimestamp = data['timestamp'] as Timestamp;
        return rawTimestamp.toDate().toLocal();
      }).toList();

      return dates;
    } catch (e) {
      log('Error while retrieving dates: $e');
      return null;
    }
  }

  Future<List<FrameModel>> getLocationByDay({required int timestamp}) async {
    final housesSnap = await _firestore
        .collection('${_dayCollectionPath}_$timestamp')
        .where('house_details.city', isEqualTo: 'Львів')
        .get();

    final list = housesSnap.docs
        .map((e) => FrameModel.fromJson(
              e.data(),
            ))
        .toList();

    return list;
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
