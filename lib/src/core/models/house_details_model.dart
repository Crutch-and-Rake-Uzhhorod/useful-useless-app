import 'package:json_annotation/json_annotation.dart';

import 'location_model.dart';

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
    this.geoId,
  );

  factory HouseDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$HouseDetailsModelFromJson(json);

  final String? buildingNumber;
  final String? city;
  final String geoId;
  final LocationModel location;
  final String? region;
  final String? street;
}
