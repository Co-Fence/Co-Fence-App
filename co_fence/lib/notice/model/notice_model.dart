class NoticeModel {
  final int noticeId;
  final String noticeSubject;
  final String authorName;
  final String noticeType;
  final String createdAt;
  final String noticeDetail;

  NoticeModel({
    required this.noticeId,
    required this.noticeSubject,
    required this.authorName,
    required this.noticeType,
    required this.createdAt,
    required this.noticeDetail,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      noticeId: json['noticeId'],
      noticeSubject: json['noticeSubject'],
      authorName: json['authorName'],
      noticeType: json['noticeType'],
      createdAt: json['createdAt'],
      noticeDetail: json['noticeDetail'],
    );
  }
}
