import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Nation {
  // 내국인
  korean,
  // 외국인
  foreigner,
}

final nationProvider = StateProvider<Nation>((ref) => Nation.korean);
