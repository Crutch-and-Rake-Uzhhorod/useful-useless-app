import 'dart:developer';

import '../models/firestore_user_data_model.dart';
import '../services/firestore_service.dart';

class UserDataRepository {
  UserDataRepository({
    required FirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  final FirestoreService _firestoreService;

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
