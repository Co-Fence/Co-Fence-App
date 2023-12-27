import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

final userInstanceProvider = Provider((ref) => UserApi.instance);
