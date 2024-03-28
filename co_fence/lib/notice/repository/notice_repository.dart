import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/common/model/cursor_pagination_model.dart';
import 'package:co_fence/common/model/pagination_params.dart';
import 'package:co_fence/notice/model/notice_detail_model.dart';
import 'package:co_fence/notice/model/notice_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'notice_repository.g.dart';

final noticeRepositoryProvider = Provider<NoticeRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repository = NoticeRepository(dio, baseUrl: '$ip/notice');

    return repository;
  },
);

@RestApi()
abstract class NoticeRepository {
  // http://$ip/notice
  factory NoticeRepository(Dio dio, {String baseUrl}) = _NoticeRepository;

  @POST('/search')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<NoticeModel>> paginate({
    @Query('keyword') required String keyword,
    @Query('targetRoleType') required String targetRoleType,
    @Queries() PaginationParams paginationParams = const PaginationParams(
      page: 1,
      size: 20,
    ),
    required int page,
    required int size,
  });

  // http://$ip/notice/detail/$noticeId
  @GET('/detail/{noticeId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<NoticeDetailModel> getNoticeDetail({
    @Path('noticeId') required int noticeId,
  });
}
