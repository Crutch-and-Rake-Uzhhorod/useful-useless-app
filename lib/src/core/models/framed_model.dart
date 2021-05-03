import 'package:json_annotation/json_annotation.dart';

import 'house_details_model.dart';
import 'time_frame_model.dart';

part 'framed_model.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class FramedModel {
  FramedModel(this.frames, this.houseDetails);

  factory FramedModel.fromJson(Map<String, dynamic> json) =>
      _$FramedModelFromJson(json);

  final List<TimeFrameModel> frames;
  final HouseDetailsModel houseDetails;
}
