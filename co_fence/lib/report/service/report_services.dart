import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/report/model/action_status.dart';
import 'package:co_fence/report/model/report_model.dart';
import 'package:co_fence/report/model/report_status.dart';
import 'package:co_fence/report/provider/report_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportServices {
  // 신고하기
  Future<String> createReport({
    required WidgetRef ref,
    required String reportSubject,
    required String reportDetail,
    required String reportStatus,
    required List<String> reportImageUrls,
  }) async {
    String result = 'Some error occurred';
    // Storage에 이미지 업로드
    // 신고하기 로직
    Dio dio = ref.watch(dioProvider);
    print(reportImageUrls);
    try {
      Response response = await dio.post(
        '$ip/report/register',
        options: Options(
          headers: {
            'accessToken': 'true',
          },
        ),
        data: {
          "reportSubject": reportSubject,
          "reportDetail": reportDetail,
          "reportStatus": reportStatus,
          "reportImageUrls": reportImageUrls,
          "createdAt": DateTime.now().toIso8601String(),
        },
      );
      if (response.statusCode == 200) {
        // 신고하기 성공
        result = 'success';
      } else {
        // 신고하기 실패
      }
    } catch (e) {
      // 신고하기 실패
    }
    return result;
  }

  // 신고 상세보기
  // GET $ip/report/detail/{reportId}
  Future<ReportModel> fetchReportDetail({
    required WidgetRef ref,
    required String reportId,
  }) async {
    Dio dio = ref.watch(dioProvider);

    Response response = await dio.get(
      '$ip/report/detail/$reportId',
      options: Options(
        headers: {
          'accessToken': 'true',
        },
      ),
    );
    // 신고 상세보기 성공
    print(response.data);
    final reportStatus =
        convertStringToReportStatus(response.data['reportStatus']);
    final actionStatus =
        convertStringToActionStatus(response.data['actionStatus']);
    final List<String> reportImageUrls =
        response.data['reportImageUrl'].toString().split(',');
    ReportModel report = ReportModel(
      userName: response.data['userName'],
      reportSubject: response.data['reportSubject'],
      reportDetail: response.data['reportDetail'],
      reportStatus: reportStatus,
      reportImageUrls: reportImageUrls,
      createdAt: DateTime.parse(response.data['createAt']),
      actionStatus: actionStatus,
    );
    return report;
  }

  // 삭제하기
  //
}
