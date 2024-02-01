import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
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

  // http://$ip/notice/search
  @POST('/search')
  @Headers({
    'accessToken': 'true',
  })
  Future<List<NoticeModel>> searchNotice({
    @Query('page') required int page,
    @Query('size') required int size,
    @Field('noticeSubject') required String noticeSubject,
    @Field('targetRoletype') required String targetRoleType,
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
