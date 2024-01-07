import 'dart:typed_data';

import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/user/model/nation.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:co_fence/user/service/storage_services.dart';
import 'package:dio/dio.dart';

class AuthServices {
  // 회원가입
  Future<String> signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required Role roleState,
    required Nation nationState,
    required Uint8List file,
  }) async {
    String result = 'Some error occurred';
    // 회원가입 로직
    Dio dio = Dio();
    try {
      // profileImageUrl은 파이어베이스 스토리지 업로드 후 반환된 이미지 주소
      String profileImageUrl = await StorageServices().uploadImageToStorage(
        'profileImage',
        email,
        file,
      );
      Response response = await dio.post(
        '$ip/v1/auth/signUp',
        data: {
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
          'roleType': roleState.toString().split('.').last,
          'nationality': nationState.toString().split('.').last,
          'profileImageUrl': profileImageUrl,
        },
      );
      if (response.statusCode == 200) {
        // 회원가입 성공
        final refreshToken = response.data['refreshToken'];
        final accessToken = response.data['accessToken'];
        // 토큰 저장
        await storage.write(
          key: REFRESH_TOKEN_KEY,
          value: refreshToken,
        );
        await storage.write(
          key: ACCESS_TOKEN_KEY,
          value: accessToken,
        );
        result = 'success';
      } else {
        // 회원가입 실패
      }
    } catch (e) {
      // 회원가입 실패
    }
    return result;
  }
}
