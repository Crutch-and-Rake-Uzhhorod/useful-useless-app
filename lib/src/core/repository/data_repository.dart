import 'dart:developer';

import '../models/firestore_user_data_model.dart';
import '../models/frame_model.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_service.dart';

class DataRepository {
  DataRepository({
    required FirestoreService firestoreService,
    required FirebaseAuthService firebaseAuthService,
  })  : _firestoreService = firestoreService,
        _firebaseAuthService = firebaseAuthService;

  final FirestoreService _firestoreService;
  final FirebaseAuthService _firebaseAuthService;

  Future<List<DateTime>> getDates() async {
    try {
      final dates = await _firestoreService.getDates();

      if (dates != null) {
        return dates;
      }
    } catch (e) {
      log('Error while getting dates: $e');
    }
    return [];
  }

  Future<List<FrameModel>> getLocationByDay({required int timestamp}) async {
    try {
      final list =
          await _firestoreService.getLocationByDay(timestamp: timestamp);

      if (list != null) {
        return list;
      }
    } catch (e) {
      log('Error while getting locations for $timestamp: $e');
    }
    return [];
  }

  Future<bool> updateNotificationPreference(bool state) async {
    try {
      final user = _firebaseAuthService.currentUser;
      if (user != null && !user.isAnonymous) {
        return _firestoreService.updateUserData(
          user.uid,
          FirestoreUserDataModel(notificationEnabled: state),
        );
      }
    } catch (e) {
      log('Error updating user notification preference. State: $state.\nError: $e');
    }
    return false;
  }

  Future<bool> subscribeToLocation(String locationId) async {
    try {
      final user = _firebaseAuthService.currentUser;
      if (user != null && !user.isAnonymous) {
        return _firestoreService.updateUserData(
          user.uid,
          FirestoreUserDataModel(userHouses: [locationId]),
        );
      }
    } catch (e) {
      log('Error subscribing to house $locationId.\nError: $e');
    }
    return false;
  }

  Future<List<String>> getFollowedHouses() async {
    try {
      final user = _firebaseAuthService.currentUser;
      if (user != null && !user.isAnonymous) {
        final houses = await _firestoreService.getFollowedHouses(user.uid);

        if (houses != null) {
          return houses;
        }
      }
    } catch (e) {
      log('Error getting followed houses. \nError: $e');
    }
    return [];
  }
}
