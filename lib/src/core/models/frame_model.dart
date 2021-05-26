import 'package:json_annotation/json_annotation.dart';

import 'house_details_model.dart';
import 'time_frame_model.dart';

part 'frame_model.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class FrameModel {
  FrameModel({
    required this.frames,
    required this.houseDetails,
  });

  factory FrameModel.fromJson(Map<String, dynamic> json) =>
      _$FrameModelFromJson(json);

  final List<TimeFrameModel> frames;
  final HouseDetailsModel houseDetails;
}
