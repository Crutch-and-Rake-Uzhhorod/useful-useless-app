import 'package:json_annotation/json_annotation.dart';

import 'location_model.dart';

part 'frame_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FrameModel {
  factory FrameModel.fromJson(Map<String, dynamic> json) =>
      _$FrameModelFromJson(json);
  FrameModel({
    this.house_details,
    this.frames,
  });
  final LocationModel? house_details;
  final List<Map<String, dynamic>>? frames;

  Map<String, dynamic> toJson() => _$FrameModelToJson(this);
}
