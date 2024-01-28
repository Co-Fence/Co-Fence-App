import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Role {
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
}

final roleProvider = StateProvider<Role>((ref) => Role.USER);
