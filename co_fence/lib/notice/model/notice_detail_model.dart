import 'package:co_fence/user/model/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notice_detail_model.g.dart';

@JsonSerializable()
class NoticeDetailModel {
  // 제목
  final String noticeSubject;
  // 작성자
  final String userName;
  // 대상
  final Role targetRoleType;
  // 작성일
  final String createdAt;
  // 내용
  final String noticeDetail;
  // 이미지 url
  final List<String> noticeImage;

  NoticeDetailModel({
    required this.noticeSubject,
    required this.userName,
    required this.targetRoleType,
    required this.createdAt,
    required this.noticeDetail,
    required this.noticeImage,
  });

  // copywith
  NoticeDetailModel copyWith({
    String? noticeSubject,
    String? userName,
    Role? targetRoleType,
    String? createdAt,
    String? noticeDetail,
    List<String>? noticeImage,
  }) {
    return NoticeDetailModel(
      noticeSubject: noticeSubject ?? this.noticeSubject,
      userName: userName ?? this.userName,
      targetRoleType: targetRoleType ?? this.targetRoleType,
      createdAt: createdAt ?? this.createdAt,
      noticeDetail: noticeDetail ?? this.noticeDetail,
      noticeImage: noticeImage ?? this.noticeImage,
    );
  }

  factory NoticeDetailModel.fromJson(Map<String, dynamic> json) {
    return NoticeDetailModel(
      noticeSubject: json['noticeSubject'],
      userName: json['userName'],
      targetRoleType: Role.fromCode(json['targetRoleType']),
      createdAt: json['createdAt'],
      noticeDetail: json['noticeDetail'],
      noticeImage: List<String>.from(json['noticeImage']),
    );
  }
}
