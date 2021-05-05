// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_frame_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeFrameModel _$TimeFrameModelFromJson(Map<String, dynamic> json) {
  return TimeFrameModel(
    end: TimeFrameModel._timestampToDate(json['end'] as Timestamp),
    start: TimeFrameModel._timestampToDate(json['start'] as Timestamp),
  );
}
