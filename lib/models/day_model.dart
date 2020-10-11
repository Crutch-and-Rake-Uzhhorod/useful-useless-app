import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:useful_useless_app/models/location_model.dart';

part 'day_model.g.dart';

void main() {

  var  jsonString = '{"frames": [{ 	"start" : "November 1, 2020 at 12:00:00 PM UTC+3", 	"end" : "November 1, 2020 at 1:00:00 PM UTC+3" 	},'
      '{ 	"start" : "November 5, 2020 at 12:00:00 PM UTC+3", 	"end" : "November 5, 2020 at 4:00:00 PM UTC+3" 	}'
      ' ], '
      '"haus_detaile": { "type": 0, "locationID" : "some location ID", '
      '"street" : "Швабска", "building_number" : "51", '
      '"city" : "Uzhhorod", '
      '"location" : { 	"lang" : "0.0", 	"lat" : "0.0" 	}, '
      '"users" : [ "user_id_from_auth" ] }}';

  Map dayMap = jsonDecode(jsonString);
  var day = DayModel.fromJson(dayMap);
  print(day.frames[0]['start']);
  print(day.haus_detaile.street);
  print(day.toJson());
}


@JsonSerializable(explicitToJson: true )
class DayModel {
  DayModel({
    this.haus_detaile,
    this.frames,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) => _$DayModelFromJson(json);
  final LocationModel haus_detaile;
  final List<Map<String, dynamic>> frames;

  Map<String, dynamic> toJson() => _$DayModelToJson(this);
}