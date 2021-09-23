import 'package:json_annotation/json_annotation.dart';

part 'region_model.g.dart';

@JsonSerializable(createToJson: false)
class RegionsDataModel {
  RegionsDataModel(this.data);

  factory RegionsDataModel.fromJson(Map<String, dynamic> json) =>
      _$RegionsDataModelFromJson(json);

  final List<RegionModel>? data;
}

@JsonSerializable(createToJson: false)
class RegionModel {
  RegionModel({
    required this.region,
    required this.cities,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) =>
      _$RegionModelFromJson(json);

  final String? region;

  final Set<String>? cities;
}
