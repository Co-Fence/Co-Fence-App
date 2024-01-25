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
            userSeq: null,
            name: '',
            email: '',
            role: Role.USER,
            nation: Nation.Korean,
            phoneNumber: '',
            profileImageUrl: '',
            workplaceId: null,
          ),
        );

  void updateUser({
    int? userSeq,
    String? name,
    String? email,
    Role? role,
    Nation? nation,
    String? phoneNumber,
    String? profileImageUrl,
    int? workplaceId,
  }) {
    state = state.copyWith(
      userSeq: userSeq,
      name: name,
      email: email,
      role: role,
      nation: nation,
      phoneNumber: phoneNumber,
      profileImageUrl: profileImageUrl,
      workplaceId: workplaceId,
    );
  }
}
