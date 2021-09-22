import 'package:json_annotation/json_annotation.dart';

import 'city_model.dart';

part 'list_of_cities_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
)
class ListOfCitiesModel {
  ListOfCitiesModel({
    this.cityModel,
  });

  factory ListOfCitiesModel.fromJson(Map<String, dynamic> json) =>
      _$ListOfCitiesModelFromJson(json);

  final CityModel? cityModel;
}
