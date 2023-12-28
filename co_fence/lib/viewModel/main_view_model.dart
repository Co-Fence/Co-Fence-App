import 'package:co_fence/utils/social_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class MainViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;

  MainViewModel(this._socialLogin);

  Future<bool> login() async {
    bool isLogined = await _socialLogin.login();
    if (isLogined) {
      user = await UserApi.instance.me();
      print('로그인 성공');
      return true;
    }
    return false;
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }
}
