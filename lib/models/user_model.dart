import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String auth_type;
  bool notification_settings;
  List<String> user_houses;
  String user_name;

  // ignore: sort_constructors_first
  UserModel(
      {this.auth_type,
      this.notification_settings,
      this.user_houses,
      this.user_name});

  // ignore: sort_constructors_first
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
