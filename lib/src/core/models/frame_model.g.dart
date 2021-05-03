 // GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FrameModel _$FrameModelFromJson(Map<String, dynamic> json) {
  return FrameModel(
    house_details: json['house_details'] == null
        ? null
        : LocationModel.fromJson(json['house_details'] as Map<String, dynamic>),
    frames: (json['frames'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
  );
}

Map<String, dynamic> _$FrameModelToJson(FrameModel instance) =>
    <String, dynamic>{
      'house_details': instance.house_details?.toJson(),
      'frames': instance.frames,
    };
