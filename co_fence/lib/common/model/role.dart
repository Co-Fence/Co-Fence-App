import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Role {
  worker,
  manager,
}

final roleProvider = StateProvider<Role>((ref) => Role.worker);
