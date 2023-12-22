import 'package:co_fence/utils/social_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class MainViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;

  MainViewModel(this._socialLogin);

  Future login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await UserApi.instance.me();
      print('로그인 성공! 유저 정보는 = ${user!.kakaoAccount!.profile!.nickname}');
    }
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }
}
