// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    auth_type: json['auth_type'] as String,
    notifycation_settings: json['notifycation_settings'] as bool,
    user_houses:
        (json['user_houses'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'auth_type': instance.auth_type,
      'notifycation_settings': instance.notifycation_settings,
      'user_houses': instance.user_houses,
    };
