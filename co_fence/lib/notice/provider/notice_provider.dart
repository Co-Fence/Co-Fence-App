import 'package:co_fence/common/model/cursor_pagination_model.dart';
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
            targetRoleType: Role.USER,
            existImage: false,
          ),
        );

  void updateReport({
    int? noticeId,
    String? noticeSubject,
    Role? targetRoleType,
    bool? existImage,
  }) {
    state = state.copyWith(
      noticeId: noticeId ?? state.noticeId,
      noticeSubject: noticeSubject ?? state.noticeSubject,
      targetRoleType: targetRoleType ?? state.targetRoleType,
      existImage: existImage ?? state.existImage,
    );
  }

  // 공지사항 검색
  // search
  Future<CursorPagination<NoticeModel>> searchNotice({
    required int page,
    required int size,
    required String noticeSubject,
    required Role targetRoleType,
  }) async {
    final result = await repository.paginate(
      page: page,
      size: size,
      keyword: noticeSubject,
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
