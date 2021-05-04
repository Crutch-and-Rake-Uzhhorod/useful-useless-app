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

  final DateTime end;
  final DateTime start;
}
