import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()

class UserModel{
  String auth_type;
  bool notifycation_settings;
  List<String> user_houses;

  UserModel({this.auth_type, this.notifycation_settings, this.user_houses});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
