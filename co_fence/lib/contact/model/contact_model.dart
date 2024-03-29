import 'package:co_fence/user/model/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel {
  // 유저 id
  final int userId;
  // 유저 이름
  final String userName;
  // 유저 프로필 이미지 url
  final String profileImageUrl;
  // 유저 역할
  @JsonKey(
    fromJson: Role.fromCode,
  )
  final Role roleType;

  ContactModel({
    required this.userId,
    required this.userName,
    required this.profileImageUrl,
    required this.roleType,
  });

  // copyWith
  ContactModel copyWith({
    int? userId,
    String? userName,
    String? profileImageUrl,
    Role? roleType,
  }) {
    return ContactModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      roleType: roleType ?? this.roleType,
    );
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
