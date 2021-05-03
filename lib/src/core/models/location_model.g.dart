// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return LocationModel(
    type: json['type'] as int?,
    locationID: json['locationID'] as String?,
    street: json['street'] as String?,
    building_number: json['building_number'] as String?,
    city: json['city'] as String?,
    location: json['location'] as Map<String, dynamic>?,
    users: json['users'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'locationID': instance.locationID,
      'street': instance.street,
      'building_number': instance.building_number,
      'city': instance.city,
      'location': instance.location,
      'users': instance.users,
    };
