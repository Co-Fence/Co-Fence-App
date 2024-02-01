import 'package:co_fence/notice/model/notice_detail_model.dart';
import 'package:co_fence/notice/model/notice_model.dart';
import 'package:co_fence/notice/repository/notice_repository.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noticeProvider = StateNotifierProvider<NoticeStateNotifier, NoticeModel>(
  (ref) {
    final repository = ref.watch(noticeRepositoryProvider);
    final notifier = NoticeStateNotifier(
      repository: repository,
    );

    return notifier;
  },
);

class NoticeStateNotifier extends StateNotifier<NoticeModel> {
  final NoticeRepository repository;

  NoticeStateNotifier({
    required this.repository,
  }) : super(
          NoticeModel(
            noticeId: 0,
            noticeSubject: '',
            targetRoletype: Role.USER,
          ),
        );

  void updateReport({
    int? noticeId,
    String? noticeSubject,
    Role? targetRoleType,
  }) {
    state = state.copyWith(
      noticeId: noticeId ?? state.noticeId,
      noticeSubject: noticeSubject ?? state.noticeSubject,
      targetRoleType: targetRoleType ?? state.targetRoletype,
    );
  }

  // 공지사항 검색
  // search
  Future<List<NoticeModel>> searchNotice({
    required int page,
    required int size,
    required String noticeSubject,
    required Role targetRoleType,
  }) async {
    final result = await repository.searchNotice(
      page: page,
      size: size,
      noticeSubject: noticeSubject,
      targetRoleType: targetRoleType.code,
    );

    return result;
  }

  // 공지사항 상세
  // detail
  Future<NoticeDetailModel> getNoticeDetail({
    required int noticeId,
  }) async {
    final result = await repository.getNoticeDetail(
      noticeId: noticeId,
    );
    return result;
  }
}
