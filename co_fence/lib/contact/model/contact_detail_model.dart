import 'package:co_fence/user/model/nation.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_detail_model.g.dart';

@JsonSerializable()
class ContactDetailModel {
  // 유저 id
  final int? userId;
  // 유저 이름
  final String userName;
  // 유저 전화번호
  final String phoneNumber;
  // 유저 프로필 이미지 url
  final String profileImageUrl;
  // 유저 국적
  final Nation nation;
  // 유저 역할
  final Role roleType;

  ContactDetailModel({
    this.userId,
    required this.userName,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.nation,
    required this.roleType,
  });

  // copyWith
  ContactDetailModel copyWith({
    int? userId,
    String? userName,
    String? phoneNumber,
    String? profileImageUrl,
    Nation? nation,
    Role? roleType,
  }) {
    return ContactDetailModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      nation: nation ?? this.nation,
      roleType: roleType ?? this.roleType,
    );
  }

  factory ContactDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactDetailModelToJson(this);
}
