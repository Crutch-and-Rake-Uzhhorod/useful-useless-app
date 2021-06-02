import 'package:json_annotation/json_annotation.dart';

part 'firestore_user_data_model.g.dart';

@JsonSerializable(
  includeIfNull: false,
  fieldRename: FieldRename.snake,
)
class FirestoreUserDataModel {
  FirestoreUserDataModel({
    this.authType,
    this.notificationEnabled,
    this.userHouses,
  });

  factory FirestoreUserDataModel.fromJson(Map<String, dynamic> json) =>
      _$FirestoreUserDataModelFromJson(json);

  final String? authType;
  final bool? notificationEnabled;
  final List<String>? userHouses;

  Map<String, dynamic> toJson() => _$FirestoreUserDataModelToJson(this);

  FirestoreUserDataModel copyWith({
    String? authType,
    bool? notificationEnabled,
    List<String>? userHouses,
  }) {
    return FirestoreUserDataModel(
      authType: authType ?? this.authType,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      userHouses: userHouses ?? this.userHouses,
    );
  }
}
