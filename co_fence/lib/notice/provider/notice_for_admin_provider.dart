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
          targetRoleType: Role.USER,
          createdAt: '',
          noticeDetail: '',
          noticeImage: [],
        ));

  void updateNotice({
    String? userName,
    String? noticeSubject,
    String? noticeDetail,
    Role? targetRoleType,
    String? createdAt,
    List<String>? noticeImage,
  }) {
    state = state.copyWith(
      userName: userName ?? state.userName,
      noticeSubject: noticeSubject ?? state.noticeSubject,
      noticeDetail: noticeDetail ?? state.noticeDetail,
      targetRoleType: targetRoleType ?? state.targetRoleType,
      createdAt: createdAt ?? state.createdAt,
      noticeImage: noticeImage ?? state.noticeImage,
    );
  }

  // 공지사항 등록
  // register
  Future<NoticeDetailModel> registerNotice({
    required String noticeSubject,
    required String noticeDetail,
    required Role targetRoleType,
    required List<String> noticeImageUrls,
    required int workplaceId,
  }) async {
    final result = await repository.register(
      noticeSubject: noticeSubject,
      noticeDetail: noticeDetail,
      targetRoleType: targetRoleType.code,
      noticeImageUrls: noticeImageUrls,
      workplaceId: workplaceId,
    );

    return result;
  }

  // 공지사항 수정
  // update
}
