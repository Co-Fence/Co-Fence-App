import 'package:co_fence/user/model/role.dart';
import 'package:co_fence/user/model/user_model.dart';
import 'package:co_fence/user/model/nation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel>(
  (ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier()
      : super(
          UserModel(
            name: '',
            email: '',
            role: Role.USER,
            nation: Nation.KR,
            phoneNumber: '',
            profileImageUrl: null,
          ),
        );

  void updateUser({
    String? name,
    String? email,
    Role? role,
    Nation? nation,
    String? phoneNumber,
    String? profileImageUrl,
  }) {
    state = state.copyWith(
      name: name,
      email: email,
      role: role,
      nation: nation,
      phoneNumber: phoneNumber,
      profileImageUrl: profileImageUrl,
    );
  }
}
