import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  LocationModel({
    this.type,
    this.locationID,
    this.street,
    this.building_number,
    this.city,
    this.location,
    this.users,
  });

  final int? type;
  final String? locationID;
  final String? street;
  final String? building_number;
  final String? city;
  final Map<String, dynamic>? location;
  final List<dynamic>? users;

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
