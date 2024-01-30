import 'package:co_fence/common/secure_storage/secure_storage.dart';
import 'package:co_fence/user/model/role.dart';
import 'package:co_fence/user/model/user_model.dart';
import 'package:co_fence/user/model/nation.dart';
import 'package:co_fence/user/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel>(
  (ref) {
    final repository = ref.watch(userRepositoryProvider);
    final notifier = UserNotifier(
      repository: repository,
    );

    return notifier;
  },
);

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier({
    required this.repository,
  }) : super(
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

  final UserRepository repository;

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

  //logout
  Future<void> logout(
    WidgetRef ref,
  ) async {
    try {
      await repository.logout();
      final storage = ref.read(secureStorageProvider);
      await storage.deleteAll();
    } catch (e) {
      return;
    }
  }
}
