import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Nation {
  // 내국인
  KR,
  // 외국인
  Foreigner,
}

final nationProvider = StateProvider<Nation>((ref) => Nation.KR);
