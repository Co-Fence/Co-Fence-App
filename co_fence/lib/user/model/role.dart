import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Role {
  USER,
  ADMIN,
}

final roleProvider = StateProvider<Role>((ref) => Role.USER);
