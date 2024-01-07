import 'package:flutter_riverpod/flutter_riverpod.dart';

// 작업현장 ID를 관리하는 Provider
final workplaceIdProvider = StateProvider<String>((ref) {
  return '1';
});
