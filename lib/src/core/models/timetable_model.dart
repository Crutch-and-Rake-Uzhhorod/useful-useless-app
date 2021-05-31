import 'package:json_annotation/json_annotation.dart';

import 'frame_model.dart';

part 'timetable_model.g.dart';

@JsonSerializable(createToJson: false)
class TimetableModel {
  TimetableModel({
    required this.timestamp,
    this.locations,
  });

  factory TimetableModel.fromJson(Map<String, dynamic> json) =>
      _$TimetableModelFromJson(json);

  final DateTime timestamp;
  final List<FrameModel>? locations;

  TimetableModel copyWith({List<FrameModel>? locations}) {
    return TimetableModel(
      timestamp: timestamp,
      locations: locations ?? this.locations,
    );
  }
}
