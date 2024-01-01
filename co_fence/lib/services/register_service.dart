import 'package:co_fence/user/model/nation.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class RegisterService {
  final Dio _dio = Dio();

  Future<bool> signUpUser({
    required String name,
    required String email,
    required Nation nation,
    required String birth,
    required String phoneNumber,
    required XFile? profileImage,
  }) async {
    try {
      final formData = FormData.fromMap(
        {
          'name': name,
          'email': email,
          'nation': nation.toString(),
          'birth': birth,
          'phoneNumber': phoneNumber,
          'profileImage': profileImage != null
              ? MultipartFile.fromFile(profileImage.path,
                  filename: 'profile_image.jpg')
              : null,
        },
      );

      final response = await _dio.post(
        'YOUR_SIGNUP_API_ENDPOINT', // 실제 회원가입 API 주소로 변경해야 합니다.
        data: formData,
      );

      if (response.statusCode == 200) {
        // 회원가입 성공
        return true;
      } else {
        // 회원가입 실패
        print('Failed to sign up with status code: ${response.statusCode}');
        print('Error response body: ${response.data}');
        return false;
      }
    } catch (error) {
      // 예외 발생 시 처리
      print('Error during sign up: $error');
      return false;
    }
  }
}
