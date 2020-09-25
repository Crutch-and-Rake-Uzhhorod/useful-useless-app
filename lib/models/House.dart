import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';


part 'house.g.dart';

void main() {

  var  jsonString = '{ "street" : "Швабска", "building_number" : "51", "city" : "Uzhhorod", "location" : { 	"lang" : "0.0", 	"lat" : "0.0" 	}, "users" : [ "user_id_from_auth" ] }';

  Map houseMap = jsonDecode(jsonString);
  var house = House.fromJson(houseMap);
  print(house.street);
  print(house.building_number);
  print(house.city);
  print(house.location);
  print(house.users);
  print(house.toJson());
}

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