import 'package:co_fence/user/model/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notice_model.g.dart';

@JsonSerializable()
class NoticeModel {
  final int noticeId;
  // 제목
  final String noticeSubject;
  // 대상
  final Role targetRoleType;

  NoticeModel({
    required this.noticeId,
    required this.noticeSubject,
    required this.targetRoleType,
  });

  // copywith
  NoticeModel copyWith({
    int? noticeId,
    String? noticeSubject,
    Role? targetRoleType,
  }) {
    return NoticeModel(
      noticeId: noticeId ?? this.noticeId,
      noticeSubject: noticeSubject ?? this.noticeSubject,
      targetRoleType: targetRoleType ?? this.targetRoleType,
    );
  }

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      noticeId: json['noticeId'],
      noticeSubject: json['noticeSubject'],
      targetRoleType: json['targetRoleType'],
    );
  }
}
