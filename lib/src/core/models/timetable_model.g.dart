// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableModel _$TimetableModelFromJson(Map<String, dynamic> json) {
  return TimetableModel(
    json['timestamp'] as int,
    (json['locations'] as List<dynamic>)
        .map((e) => FrameModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
