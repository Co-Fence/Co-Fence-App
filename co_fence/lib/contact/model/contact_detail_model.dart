import 'package:co_fence/user/model/nation.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_detail_model.g.dart';

@JsonSerializable()
class ContactDetailModel {
  // 유저 email
  final int? email;
  // 유저 이름
  final String name;
  // 유저 전화번호
  final String phoneNumber;
  // 유저 프로필 이미지 url
  final String profileImageUrl;
  // 유저 국적
  final Nation nationality;
  // 유저 역할
  @JsonKey(
    fromJson: Role.fromCode,
  )
  final Role roleType;

  ContactDetailModel({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.nationality,
    required this.roleType,
  });

  // copyWith
  ContactDetailModel copyWith({
    int? email,
    String? name,
    String? phoneNumber,
    String? profileImageUrl,
    Nation? nationality,
    Role? roleType,
  }) {
    return ContactDetailModel(
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      nationality: nationality ?? this.nationality,
      roleType: roleType ?? this.roleType,
    );
  }

  factory ContactDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactDetailModelToJson(this);
}
