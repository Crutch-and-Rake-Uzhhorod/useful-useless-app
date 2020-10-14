import 'package:json_annotation/json_annotation.dart';
import 'package:useful_useless_app/models/location_model.dart';

part 'frame_model.g.dart';

@JsonSerializable(explicitToJson: true )
class FrameModel {
  FrameModel({
    this.haus_detaile,
    this.frames,
  });

  factory FrameModel.fromJson(Map<String, dynamic> json) => _$FrameModelFromJson(json);
  final LocationModel haus_detaile;
  final List<Map<String, dynamic>> frames;

  Map<String, dynamic> toJson() => _$FrameModelToJson(this);
}