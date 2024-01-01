import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Role {
  User,
  Admin,
}

final roleProvider = StateProvider<Role>((ref) => Role.User);
