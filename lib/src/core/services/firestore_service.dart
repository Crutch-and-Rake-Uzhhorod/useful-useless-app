import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/firestore_user_data_model.dart';
import '../models/frame_model.dart';

class FirestoreService {
  static const String _dayCollectionPath = 'timetable';
  static const String _usersCollectionPath = 'users';
  static const String _lviv = 'львів';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DateTime>> getDates() async {
    final mostRecent = await _firestore.collection(_dayCollectionPath).get();

    final dates = mostRecent.docs.map((e) {
      final data = e.data();
      final rawTimestamp = data['timestamp'] as Timestamp;
      return rawTimestamp.toDate().toLocal();
    }).toList();

    return dates;
  }

  Future<List<FrameModel>> getLocationByDay({required int timestamp}) async {
    final housesSnap = await _firestore
        .collection('${_dayCollectionPath}_$timestamp')
        .where('house_details.city', isEqualTo: _lviv)
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
    final docRef = _firestore.collection(_usersCollectionPath).doc(userId);
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
    final docRef = _firestore.collection(_usersCollectionPath).doc(userId);
    await _firestore.runTransaction((transaction) async {
      if (userDataModel.userHouses != null) {
        await transaction.get(docRef).then((docSnapshot) {
          final oldModel = FirestoreUserDataModel.fromJson(docSnapshot.data()!);

          if (oldModel.userHouses != null) {
            if (oldModel.userHouses!
                .contains(userDataModel.userHouses!.first)) {
              oldModel.userHouses?.remove(userDataModel.userHouses!.first);
            } else {
              oldModel.userHouses!.addAll(userDataModel.userHouses!);
            }
            transaction.update(docRef, oldModel.toJson());
          } else {
            final newModel = oldModel.copyWith(
              userHouses: userDataModel.userHouses,
            );
            transaction.update(docRef, newModel.toJson());
          }
        });
      } else {
        transaction.update(docRef, userDataModel.toJson());
      }
    });
  }

  Future<List<String>?> getFollowedHouses(String userId) async {
    final rawUserData =
        await _firestore.collection(_usersCollectionPath).doc(userId).get();

    final houses = (rawUserData.data()?['user_houses'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList();

    return houses;
  }
}
