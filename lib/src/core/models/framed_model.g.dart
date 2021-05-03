// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'framed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FramedModel _$FramedModelFromJson(Map<String, dynamic> json) {
  return FramedModel(
    (json['frames'] as List<dynamic>)
        .map((e) => TimeFrameModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    HouseDetailsModel.fromJson(json['house_details'] as Map<String, dynamic>),
  );
}
