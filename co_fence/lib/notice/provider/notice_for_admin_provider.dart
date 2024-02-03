import 'package:co_fence/notice/model/notice_detail_model.dart';
import 'package:co_fence/notice/repository/notice_for_admin_repository.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noticeForAdminProvider =
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
          noticeSubject: '',
          userName: '',
          targetRole: Role.USER,
          createdAt: '',
          noticeDetail: '',
          noticeImageUrl: [],
        ));

  void updateNotice({
    String? userName,
    String? noticeSubject,
    String? noticeDetail,
    Role? targetRole,
    String? createdAt,
    List<String>? noticeImageUrl,
  }) {
    state = state.copyWith(
      userName: userName ?? state.userName,
      noticeSubject: noticeSubject ?? state.noticeSubject,
      noticeDetail: noticeDetail ?? state.noticeDetail,
      targetRole: targetRole ?? state.targetRole,
      createdAt: createdAt ?? state.createdAt,
      noticeImageUrl: noticeImageUrl ?? state.noticeImageUrl,
    );
  }

  // 공지사항 등록
  // register
  Future<NoticeDetailModel> registerNotice({
    required String noticeSubject,
    required String noticeDetail,
    required Role targetRole,
    required List<String> noticeImageUrls,
  }) async {
    final result = await repository.register(
      noticeSubject: noticeSubject,
      noticeDetail: noticeDetail,
      targetRoleType: targetRole.code,
      noticeImageUrls: noticeImageUrls,
    );

    return result;
  }

  // 공지사항 수정
  // update
}
