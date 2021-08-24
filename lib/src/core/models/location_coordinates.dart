import 'package:json_annotation/json_annotation.dart';

part 'location_coordinates.g.dart';

@JsonSerializable(createToJson: false)
class LocationCoordinates {
  LocationCoordinates({
    required this.lat,
    required this.lng,
  });

  factory LocationCoordinates.fromJson(Map<String, dynamic> json) =>
      _$LocationCoordinatesFromJson(json);

  final double lat;
  final double lng;
}
