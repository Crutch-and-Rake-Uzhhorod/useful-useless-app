import 'dart:developer';

import '../models/firestore_user_data_model.dart';
import '../models/frame_model.dart';
import '../services/firestore_service.dart';

class DataRepository {
  DataRepository({
    required FirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  final FirestoreService _firestoreService;

  Future<List<DateTime>?> getDates() async {
    try {
      final dates = await _firestoreService.getDates();
      return dates;
    } catch (e) {
      log('Error while getting dates: $e');
      return null;
    }
  }

  Future<List<FrameModel>?> getLocationByDay({required int timestamp}) async {
    try {
      final list =
          await _firestoreService.getLocationByDay(timestamp: timestamp);
      return list;
    } catch (e) {
      log('Error while getting locations for $timestamp: $e');
      return null;
    }
  }

  Future<void> updateNotificationPreference(String userId, bool state) async {
    try {
      await _firestoreService.updateUserData(
        userId,
        FirestoreUserDataModel(notificationEnabled: state),
      );
    } catch (e) {
      log('Error updating user notification preference: $userId, state: $state.\nError: $e');
    }
  }

  Future<void> subscribeToLocation(String userId, String locationId) async {
    try {
      await _firestoreService.updateUserData(
        userId,
        FirestoreUserDataModel(userHouses: [locationId]),
      );
    } catch (e) {
      log('Error subscribing to house $locationId, userId: $userId.\nError: $e');
    }
  }
}
