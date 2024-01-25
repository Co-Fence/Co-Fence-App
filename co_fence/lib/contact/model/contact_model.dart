import 'package:co_fence/user/model/nation.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel {
  // 유저 id
  final int? id;
  // 유저 이름
  final String name;
  // 유저 전화번호
  final String phoneNumber;
  // 유저 프로필 이미지 url
  final String imageUrl;
  // 유저 국적
  final Nation nation;
  // 유저 역할
  final Role role;

  ContactModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.nation,
    required this.role,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      _$ContactModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
