import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class CityModel {
  CityModel({
    this.city,
    this.region,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  final String? region;
  final String? city;
}
