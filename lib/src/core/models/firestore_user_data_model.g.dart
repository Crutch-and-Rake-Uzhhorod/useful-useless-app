// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreUserDataModel _$FirestoreUserDataModelFromJson(
    Map<String, dynamic> json) {
  return FirestoreUserDataModel(
    authType: json['auth_type'] as String?,
    notificationEnabled: json['notification_enabled'] as bool?,
    userHouses: (json['user_houses'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$FirestoreUserDataModelToJson(
    FirestoreUserDataModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('auth_type', instance.authType);
  writeNotNull('notification_enabled', instance.notificationEnabled);
  writeNotNull('user_houses', instance.userHouses);
  return val;
}
