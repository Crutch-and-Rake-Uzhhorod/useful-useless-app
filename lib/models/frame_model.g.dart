// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FrameModel _$FrameModelFromJson(Map<String, dynamic> json) {
  return FrameModel(
    haus_detaile: json['haus_detaile'] == null
        ? null
        : LocationModel.fromJson(json['haus_detaile'] as Map<String, dynamic>),
    frames: (json['frames'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
  );
}

Map<String, dynamic> _$FrameModelToJson(FrameModel instance) =>
    <String, dynamic>{
      'haus_detaile': instance.haus_detaile?.toJson(),
      'frames': instance.frames,
    };
