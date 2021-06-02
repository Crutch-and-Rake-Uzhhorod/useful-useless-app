import 'package:json_annotation/json_annotation.dart';

part 'firestore_user_data_model.g.dart';

@JsonSerializable(
  includeIfNull: false,
  createFactory: false,
  fieldRename: FieldRename.snake,
)
class FirestoreUserDataModel {
  FirestoreUserDataModel({
    this.authType,
    this.notificationEnabled,
    this.userHouses,
  });

  final String? authType;
  final bool? notificationEnabled;
  final List<String>? userHouses;

  Map<String, dynamic> toJson() => _$FirestoreUserDataModelToJson(this);
}
