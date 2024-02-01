import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Role {
  ALL('ROLE_ALL', 'All'),
  USER('ROLE_USER', 'User'),
  ADMIN('ROLE_ADMIN', 'Admin');

  final String code;
  final String displayName;

  const Role(
    this.code,
    this.displayName,
  );

  static Role fromCode(String code) {
    return Role.values.firstWhere((element) => element.code == code);
  }

  // Role.ADMIN을 'Admin'으로 변환
  static String toDisplayName(Role role) {
    return role.displayName;
  }
}

final roleProvider = StateProvider<Role>((ref) => Role.USER);
