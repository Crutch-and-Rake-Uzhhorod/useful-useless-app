import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/firestore_user_data_model.dart';
import '../models/frame_model.dart';

class FirestoreService {
  static const String _dayCollectionPath = 'timetable';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DateTime>?> getDates() async {
    final mostRecent = await _firestore.collection(_dayCollectionPath).get();

    final dates = mostRecent.docs.map((e) {
      final data = e.data();
      final rawTimestamp = data['timestamp'] as Timestamp;
      return rawTimestamp.toDate().toLocal();
    }).toList();

    return dates;
  }

  Future<List<FrameModel>?> getLocationByDay({required int timestamp}) async {
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

  Future<void> addUserIfMissing(
    String userId,
    FirestoreUserDataModel userDataModel,
  ) async {
    final docRef = _firestore.collection('users').doc(userId);
    await _firestore.runTransaction((transaction) async {
      await transaction.get(docRef).then((docSnapshot) {
        if (!docSnapshot.exists) {
          transaction.set(docRef, userDataModel.toJson());
        }
      });
    });
  }

  Future<void> updateUserData(
    String userId,
    FirestoreUserDataModel userDataModel,
  ) async {
    final docRef = _firestore.collection('users').doc(userId);
    await _firestore.runTransaction((transaction) async {
      if (userDataModel.userHouses != null) {
        await transaction.get(docRef).then((docSnapshot) {
          final oldModel = FirestoreUserDataModel.fromJson(docSnapshot.data()!);
          final newModel = userDataModel.copyWith(
            userHouses: oldModel.userHouses!,
          );
          newModel.userHouses!.addAll(userDataModel.userHouses!);
          transaction.update(docRef, newModel.toJson());
        });
      } else {
        transaction.update(docRef, userDataModel.toJson());
      }
    });
  }
}
