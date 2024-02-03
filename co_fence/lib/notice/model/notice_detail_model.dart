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
  final Role targetRole;
  // 작성일
  final String createdAt;
  // 내용
  final String noticeDetail;
  // 이미지 url
  final List<String> noticeImageUrl;

  NoticeDetailModel({
    required this.noticeSubject,
    required this.userName,
    required this.targetRole,
    required this.createdAt,
    required this.noticeDetail,
    required this.noticeImageUrl,
  });

  // copywith
  NoticeDetailModel copyWith({
    String? noticeSubject,
    String? userName,
    Role? targetRole,
    String? createdAt,
    String? noticeDetail,
    List<String>? noticeImageUrl,
  }) {
    return NoticeDetailModel(
      noticeSubject: noticeSubject ?? this.noticeSubject,
      userName: userName ?? this.userName,
      targetRole: targetRole ?? this.targetRole,
      createdAt: createdAt ?? this.createdAt,
      noticeDetail: noticeDetail ?? this.noticeDetail,
      noticeImageUrl: noticeImageUrl ?? this.noticeImageUrl,
    );
  }

  factory NoticeDetailModel.fromJson(Map<String, dynamic> json) {
    return NoticeDetailModel(
      noticeSubject: json['noticeSubject'],
      userName: json['userName'],
      targetRole: Role.fromCode(json['targetRole']),
      createdAt: json['createdAt'],
      noticeDetail: json['noticeDetail'],
      noticeImageUrl: List<String>.from(json['noticeImageUrl']),
    );
  }
}
