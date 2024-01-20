import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
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
      print(response.data);
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
}
