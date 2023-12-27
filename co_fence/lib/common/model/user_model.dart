import 'package:co_fence/common/model/gender.dart';
import 'package:co_fence/common/model/nation.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  // 이름
  final String name;
  // 국가
  final Nation nation;
  // 성별
  final Gender gender;
  // 생년월일
  final String birth;
  // 전화번호
  final String phoneNumber;
  // 이메일
  final String email;
  // 프로필 사진
  final Uint8List? profileImage;

  UserModel({
    required this.name,
    required this.nation,
    required this.gender,
    required this.birth,
    required this.phoneNumber,
    required this.email,
    required this.profileImage,
  });

  // copyWith 메서드는 입력값만 변경하는 메서드
  UserModel copyWith({
    String? name,
    Nation? nation,
    Gender? gender,
    String? birth,
    String? phoneNumber,
    String? email,
  }) {
    return UserModel(
      // 만약 name이 null이라면 this.name, 그렇지 않으면 name 사용
      name: name ?? this.name,
      nation: nation ?? this.nation,
      gender: gender ?? this.gender,
      birth: birth ?? this.birth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profileImage: profileImage ?? profileImage,
    );
  }

  // toJson 메서드는 json 형태로 변환하는 메서드
  
}
