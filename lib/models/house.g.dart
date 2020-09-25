// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

House _$HouseFromJson(Map<String, dynamic> json) {
  return House(
    street: json['street'] as String,
    building_number: json['building_number'] as String,
    city: json['city'] as String,
    location: json['location'] as Map<String, dynamic>,
    users: json['users'] as List,
  );
}

Map<String, dynamic> _$HouseToJson(House instance) => <String, dynamic>{
      'street': instance.street,
      'building_number': instance.building_number,
      'city': instance.city,
      'location': instance.location,
      'users': instance.users,
    };
