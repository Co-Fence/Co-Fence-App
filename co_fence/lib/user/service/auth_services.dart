import 'dart:typed_data';

import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/common/secure_storage/secure_storage.dart';
import 'package:co_fence/user/model/nation.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:co_fence/user/provider/user_provider.dart';
import 'package:co_fence/user/service/storage_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthServices {
  // 회원가입
  Future<String> signUp({
    required WidgetRef ref,
    required String name,
    required String email,
    required String phoneNumber,
    required Role roleState,
    required Nation nationState,
    required Uint8List file,
  }) async {
    String result = 'Some error occurred';
    // 회원가입 로직
    Dio dio = ref.watch(dioProvider);
    try {
      // profileImageUrl은 파이어베이스 스토리지 업로드 후 반환된 이미지 주소
      String profileImageUrl = await StorageServices().uploadImageToStorage(
        'profileImage',
        email,
        file,
      );
      Response response = await dio.post(
        '$ip/auth/signUp',
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
        final storage = ref.read(secureStorageProvider);
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
        // userProvider 업데이트
        ref.read(userProvider.notifier).updateUser(
              name: name,
              email: email,
              role: roleState,
              nation: nationState,
              phoneNumber: phoneNumber,
              profileImageUrl: profileImageUrl,
              workplaceId: 0,
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
