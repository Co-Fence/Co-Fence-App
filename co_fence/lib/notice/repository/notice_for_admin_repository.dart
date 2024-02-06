import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/notice/model/notice_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'notice_for_admin_repository.g.dart';

final noticeForAdminRepositoryProvider = Provider<NoticeForAdminRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repository =
        NoticeForAdminRepository(dio, baseUrl: '$ip/noticeForAdmin');

    return repository;
  },
);

@RestApi()
abstract class NoticeForAdminRepository {
  // http://$ip/notice
  factory NoticeForAdminRepository(Dio dio, {String baseUrl}) =
      _NoticeForAdminRepository;

  // http://$ip/noticeForAdmin/register
  @POST('/register')
  @Headers({
    'accessToken': 'true',
  })
  Future<NoticeDetailModel> register({
    @Field('noticeSubject') required String noticeSubject,
    @Field('noticeDetail') required String noticeDetail,
    @Field('noticeImageUrls') required List<String> noticeImageUrls,
    @Field('targetRoleType') required String targetRoleType,
    @Field('workplaceId') required int workplaceId,
  });
}
