import 'package:co_fence/common/utils/social_login.dart';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin implements SocialLogin {
  @override
  Future<bool> login() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        print('name: ${googleUser.displayName}');
        print('email: ${googleUser.email}');
        print('photoUrl: ${googleUser.photoUrl}');
      }
      return true;
    } catch (error) {
      print('Failed to log in with Google $error');
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await GoogleLogin().logout();
      return true;
    } catch (error) {
      print('Failed to log out with Google $error');
      return false;
    }
  }
}
