// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'region_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionsDataModel _$RegionsDataModelFromJson(Map<String, dynamic> json) {
  return RegionsDataModel(
    (json['data'] as List<dynamic>?)
        ?.map((e) => RegionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

RegionModel _$RegionModelFromJson(Map<String, dynamic> json) {
  return RegionModel(
    region: json['region'] as String?,
    cities:
        (json['cities'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}
