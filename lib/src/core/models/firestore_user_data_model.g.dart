// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$FirestoreUserDataModelToJson(
    FirestoreUserDataModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('authType', instance.authType);
  writeNotNull('notificationEnabled', instance.notificationEnabled);
  writeNotNull('userHouses', instance.userHouses);
  return val;
}
