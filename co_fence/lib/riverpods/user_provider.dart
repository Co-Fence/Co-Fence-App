import 'package:co_fence/common/model/gender.dart';
import 'package:co_fence/common/model/user_model.dart';
import 'package:co_fence/common/model/nation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel>(
  (ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier()
      : super(
          UserModel(
            name: '',
            email: '',
            nation: Nation.korean,
            gender: Gender.male,
            birth: '',
            phoneNumber: '',
            profileImage: null,
          ),
        );
  void updateUser({
    String? name,
    String? email,
    Nation? nation,
    Gender? gender,
    String? birth,
    String? phoneNumber,
    XFile? profileImage,
  }) {
    state = state.copyWith(
      name: name,
      email: email,
      nation: nation,
      gender: gender,
      birth: birth,
      phoneNumber: phoneNumber,
      profileImage: profileImage,
    );
  }
}
