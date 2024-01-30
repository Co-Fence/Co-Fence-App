import 'package:co_fence/notice/model/notice_detail_model.dart';
import 'package:co_fence/notice/repository/notice_for_admin_repository.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportForAdminProvider =
    StateNotifierProvider<NoticeForAdminStateNotifier, NoticeDetailModel>(
  (ref) {
    final repository = ref.watch(noticeForAdminRepositoryProvider);
    final notifier = NoticeForAdminStateNotifier(
      repository: repository,
    );

    return notifier;
  },
);

class NoticeForAdminStateNotifier extends StateNotifier<NoticeDetailModel> {
  final NoticeForAdminRepository repository;

  NoticeForAdminStateNotifier({
    required this.repository,
  }) : super(NoticeDetailModel(
          noticeId: 0,
          noticeSubject: '',
          userName: '',
          targetRole: Role.USER,
          createdAt: '',
          noticeDetail: '',
          noticeImageUrl: [],
        ));

  void updateNotice({
    String? userName,
    int? noticeId,
    String? noticeSubject,
    String? noticeDetail,
    Role? targetRole,
    String? createdAt,
    List<String>? noticeImageUrls,
  }) {
    state = state.copyWith(
      noticeId: noticeId ?? state.noticeId,
      noticeSubject: noticeSubject ?? state.noticeSubject,
      noticeDetail: noticeDetail ?? state.noticeDetail,
      targetRole: targetRole ?? state.targetRole,
      createdAt: createdAt ?? state.createdAt,
      noticeImageUrl: noticeImageUrls ?? state.noticeImageUrl,
    );
  }

  // 공지사항 등록
  // register
  Future<NoticeDetailModel> registerNotice({
    required String noticeSubject,
    required String noticeDetail,
    required Role targetRole,
    required List<String> noticeImageUrl,
  }) async {
    final result = await repository.register(
      noticeSubject: noticeSubject,
      noticeDetail: noticeDetail,
      targetRoleType: targetRole.code,
      noticeImageUrl: noticeImageUrl,
    );

    return result;
  }
}
