import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserModel({
    this.auth_type,
    this.notification_settings,
    this.user_houses,
    this.user_name,
  });

  String? auth_type;
  bool? notification_settings;
  List<String>? user_houses;
  String? user_name;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
