// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseDetailsModel _$HouseDetailsModelFromJson(Map<String, dynamic> json) {
  return HouseDetailsModel(
    json['building_number'] as String?,
    json['city'] as String?,
    LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    json['region'] as String?,
    json['street'] as String?,
  );
}

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) {
  return LocationModel(
    (json['lat'] as num).toDouble(),
    (json['lng'] as num).toDouble(),
  );
}