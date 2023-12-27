import 'package:co_fence/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider((ref) {
  final dio = Dio();
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1. 요청을 보낼 때
  // 만약에 요청의 Header에 accessToken: true라는 값이 있다면
  // 실제 토큰을 인터셉트해서(secure storag) authorization : bearer $token으로
  // 헤더를 변경한다.
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');
    if (options.headers['accessToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      // 헤더 삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);
      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 2. 응답을 받을 때

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] [${response.requestOptions}] ${response.requestOptions.uri}');
    return super.onResponse(response, handler);
  }

  // 3. 에러가 났을 때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('[ERR], [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken이 아예 없으면
    // 에러를 던진다
    if (refreshToken == null) {
      // 에러를 던질 때는 handler.reject를 사용한다
      return handler.reject(err);
    }

    // 에러 상태 코드가 401인지 확인
    final isStatus401 = err.response?.statusCode == 401;
    // 에러가 난 이 요청은 토큰을 refresh하려다가 생긴 에러
    // true가 되면 refreshToken이 문제가 생긴 상황임.
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    // 토큰을 refresh하려는 게 아닌데 401에러가 났다면
    if (isStatus401 && !isPathRefresh) {
      // 새로 토큰을 발급받을 것임
      final dio = Dio();
      try {
        final response = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = response.data['accessToken'];
        final options = err.requestOptions;
        // 토큰 변경하기
        options.headers.addAll({
          'authoriation': 'Bearer $accessToken',
        });
        // secure storage에도 업데이트
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        // options에는 에러를 발생시킨 모든 요청과 옵션들을 다 받아서
        // 토큰을 받은 다음에 다시 요청을 보내는 것
        final resp = await dio.fetch(options);
        // resp는 새로 보낸 요청에 대한 성공적인 응답을 받아서 반환하는 것
        return handler.resolve(resp);
      } on DioException catch (e) {
        // refreshToken의 상태가 잘못된 상황
        return handler.reject(e);
      }
    }

    // 401 에러가 아니면
    return handler.reject(err);
  }
}
