// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseDetailsModel _$HouseDetailsModelFromJson(Map<String, dynamic> json) {
  return HouseDetailsModel(
    buildingNumber: json['building_number'] as String?,
    city: json['city'] as String?,
    location:
        LocationCoordinates.fromJson(json['location'] as Map<String, dynamic>),
    region: json['region'] as String?,
    street: json['street'] as String?,
    geoId: json['geo_id'] as String,
  );
}
