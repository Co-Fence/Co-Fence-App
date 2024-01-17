import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'report_repository.g.dart';

final reportRepositoryProvider = Provider<ReportRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repository = ReportRepository(dio, baseUrl: '$ip/report');

    return repository;
  },
);

@RestApi()
abstract class ReportRepository {
  // http://$ip/report
  factory ReportRepository(Dio dio, {String baseUrl}) = _ReportRepository;

  // createReport
  // http://$ip/report/create
  @POST('/create')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> createReport({
    @Field('reportSubject') required String reportSubject,
    @Field('reportDetail') required String reportDetail,
    @Field('reportStatus') required String reportStatus,
  });
}
