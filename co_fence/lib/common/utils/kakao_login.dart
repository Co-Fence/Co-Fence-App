import 'package:co_fence/common/utils/social_login.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('Successful login through KakaoTalk');
        return true;
      } catch (error) {
        print('Failed to log in with KakaoTalk $error');

        if (error is PlatformException && error.code == 'CANCELED') {
          return false;
        }

        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('Successfully logged in with Kakao Account');
          return true;
        } catch (error) {
          print('Failed to log in with Kakao Account $error');
          return false;
        }
      }
    } // 카카오톡 실행 불가일 때
    else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('Successfully logged in with Kakao Account');
        return true;
      } catch (error) {
        print('Failed to log in with Kakao Account $error');
        return false;
      }
    }
  }

  @override
  Future<bool> logout() {
    try {
      UserApi.instance.logout();
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }
}
