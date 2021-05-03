// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frame_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FrameModel _$FrameModelFromJson(Map<String, dynamic> json) {
  return FrameModel(
    (json['frames'] as List<dynamic>)
        .map((e) => TimeFrameModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    HouseDetailsModel.fromJson(json['house_details'] as Map<String, dynamic>),
  );
}
