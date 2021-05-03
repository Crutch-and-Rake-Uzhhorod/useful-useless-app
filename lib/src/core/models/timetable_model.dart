import 'package:json_annotation/json_annotation.dart';

import 'framed_model.dart';

part 'timetable_model.g.dart';

@JsonSerializable(createToJson: false)
class TimetableModel {
  TimetableModel(this.timestamp, this.locations);

  factory TimetableModel.fromJson(Map<String, dynamic> json) =>
      _$TimetableModelFromJson(json);

  final int timestamp;
  final List<FramedModel> locations;
}
