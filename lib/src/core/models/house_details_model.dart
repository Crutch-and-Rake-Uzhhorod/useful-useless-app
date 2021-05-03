import 'package:json_annotation/json_annotation.dart';

part 'house_details_model.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class HouseDetailsModel {
  HouseDetailsModel(
    this.buildingNumber,
    this.city,
    this.location,
    this.region,
    this.street,
  );

  factory HouseDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$HouseDetailsModelFromJson(json);

  final String? buildingNumber;
  final String? city;
  final LocationModel location;
  final String? region;
  final String? street;
}

@JsonSerializable(createToJson: false)
class LocationModel {
  LocationModel(this.lat, this.lng);

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  final double lat;
  final double lng;
}
