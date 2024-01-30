import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'user_repository.g.dart';

final userRepositoryProvider = Provider<UserRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repository = UserRepository(dio, baseUrl: '$ip/auth');

    return repository;
  },
);

@RestApi()
abstract class UserRepository {
  // http://$ip/auth
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  // http://$ip/auth/logout
  @POST('/logout')
  @Headers({
    'accessToken': 'true',
  })
  Future<void> logout();
}
