import 'package:co_fence/user/model/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notice_model.g.dart';

@JsonSerializable()
class NoticeModel {
  final int noticeId;
  // 제목
  final String noticeSubject;
  // 대상
  @JsonKey(
    fromJson: Role.fromCode,
  )
  final Role targetRoleType;
  // 사진 여부
  final bool existImage;

  NoticeModel({
    required this.existImage,
    required this.noticeId,
    required this.noticeSubject,
    required this.targetRoleType,
  });

  // copywith
  NoticeModel copyWith({
    int? noticeId,
    String? noticeSubject,
    Role? targetRoleType,
    bool? existImage,
  }) {
    return NoticeModel(
      noticeId: noticeId ?? this.noticeId,
      noticeSubject: noticeSubject ?? this.noticeSubject,
      targetRoleType: targetRoleType ?? this.targetRoleType,
      existImage: existImage ?? this.existImage,
    );
  }

  factory NoticeModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeModelFromJson(json);
}
