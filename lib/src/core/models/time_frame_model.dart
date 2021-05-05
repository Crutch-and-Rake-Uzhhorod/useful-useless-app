import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_frame_model.g.dart';

@JsonSerializable(createToJson: false)
class TimeFrameModel {
  TimeFrameModel({
    required this.end,
    required this.start,
  });

  factory TimeFrameModel.fromJson(Map<String, dynamic> json) =>
      _$TimeFrameModelFromJson(json);

  @JsonKey(fromJson: _timestampToDate)
  final DateTime end;
  @JsonKey(fromJson: _timestampToDate)
  final DateTime start;

  static DateTime _timestampToDate(Timestamp timestamp) => timestamp.toDate();
}
