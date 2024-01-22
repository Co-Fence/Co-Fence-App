import 'package:co_fence/user/model/nation.dart';
import 'package:co_fence/user/model/role.dart';

class UserModel {
  // id
  final int? userSeq;
  // 이름
  final String name;
  // 역할
  final Role role;
  // 국가
  final Nation nation;
  // 전화번호
  final String phoneNumber;
  // 이메일
  final String email;
  // 프로필 사진
  final String profileImageUrl;
  // 작업 현장 id
  final int? workplaceId;

  UserModel({
    this.userSeq,
    required this.name,
    required this.role,
    required this.nation,
    required this.phoneNumber,
    required this.email,
    required this.profileImageUrl,
    required this.workplaceId,
  });

  // copyWith 메서드는 입력값만 변경하는 메서드
  UserModel copyWith({
    int? userSeq,
    String? name,
    Role? role,
    Nation? nation,
    String? phoneNumber,
    String? email,
    String? profileImageUrl,
    int? workplaceId,
  }) {
    return UserModel(
      userSeq: userSeq ?? this.userSeq,
      // 만약 name이 null이라면 this.name, 그렇지 않으면 name 사용
      name: name ?? this.name,
      nation: nation ?? this.nation,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      workplaceId: workplaceId ?? this.workplaceId,
    );
  }

  // fromJson 메서드는 json을 입력받아 UserModel을 반환하는 메서드
  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      userSeq: json['userSeq'],
      name: json['name'],
      role: Role.values[json['role']],
      nation: Nation.values[json['nation']],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      workplaceId: json['workplaceId'],
    );
  }

  // toJson 메서드는 UserModel을 json으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'userSeq': userSeq,
      'name': name,
      'role': role.index,
      'nation': nation.index,
      'phoneNumber': phoneNumber,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'workplaceId': workplaceId,
    };
  }
}
