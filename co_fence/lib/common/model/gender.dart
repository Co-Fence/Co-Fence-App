import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Gender {
  male,
  female,
}

final genderProvider = StateProvider<Gender>((ref) => Gender.male);
