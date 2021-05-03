// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    auth_type: json['auth_type'] as String?,
    notification_settings: json['notification_settings'] as bool?,
    user_houses: (json['user_houses'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    user_name: json['user_name'] as String?,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'auth_type': instance.auth_type,
      'notification_settings': instance.notification_settings,
      'user_houses': instance.user_houses,
      'user_name': instance.user_name,
    };
