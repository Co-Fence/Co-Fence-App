import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'report_repository.g.dart';

final reportRepositoryProvider = Provider<ReportRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repository = ReportRepository(dio, baseUrl: '$ip/reportForAdmin');

    return repository;
  },
);

@RestApi()
abstract class ReportRepository {
  // http://$ip/report
  factory ReportRepository(Dio dio, {String baseUrl}) = _ReportRepository;

  // http://$ip/report/update/$reportId
  @PUT('/update/{reportId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> updateReport({
    @Path('reportId') required int reportId,
    @Field('reportSubject') required String reportSubject,
    @Field('actionStatus') required String actionStatus,
    @Field('reportStatus') required String reportStatus,
  });

  // http://$ip/report/delete/$reportId
  @DELETE('/delete/{reportId}')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> deleteReport({
    @Path('reportId') required int reportId,
  });
}
