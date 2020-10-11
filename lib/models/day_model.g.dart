// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayModel _$DayModelFromJson(Map<String, dynamic> json) {
  return DayModel(
    haus_detaile: json['haus_detaile'] == null
        ? null
        : LocationModel.fromJson(json['haus_detaile'] as Map<String, dynamic>),
    frames: (json['frames'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
  );
}

Map<String, dynamic> _$DayModelToJson(DayModel instance) => <String, dynamic>{
      'haus_detaile': instance.haus_detaile?.toJson(),
      'frames': instance.frames,
    };
