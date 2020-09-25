import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';


part 'house.g.dart';

@JsonSerializable()
class House {
  House({
    this.street,
    this.building_number,
    this.city,
    this.location,
    this.users,
  });

  factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);

  final String street;
  final String building_number;
  final String city;
  final Map<String, dynamic> location;
  final List<dynamic> users;

  Map<String, dynamic> toJson() => _$HouseToJson(this);
}