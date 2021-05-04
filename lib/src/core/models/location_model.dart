import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable(createToJson: false)
class LocationModel {
  LocationModel({
    required this.lat,
    required this.lng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  final double lat;
  final double lng;
}
