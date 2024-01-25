import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Nation {
  // 내국인
  Korean('kr', 'Korean'),
  // 외국인
  Foreigner('fr', 'Foreigner');

  final String code;
  final String displayName;

  const Nation(
    this.code,
    this.displayName,
  );

  static Nation? fromCode(String code) {
    return Nation.values.firstWhere((element) => element.code == code);
  }
}

final nationProvider = StateProvider<Nation>((ref) => Nation.Korean);
