import 'package:json_annotation/json_annotation.dart';

import 'location_model.dart';

part 'frame_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FrameModel {
  FrameModel({
    this.house_details,
    this.frames,
  });

  factory FrameModel.fromJson(Map<String, dynamic> json) =>
      _$FrameModelFromJson(json);
  Map<String, dynamic> toJson() => _$FrameModelToJson(this);

  final LocationModel house_details;
  final List<Map<String, dynamic>> frames;
}
