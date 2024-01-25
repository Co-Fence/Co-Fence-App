import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'contact_repository.g.dart';

final reportRepositoryProvider = Provider<ContactRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repository = ContactRepository(dio, baseUrl: '$ip/contact');

    return repository;
  },
);

@RestApi()
abstract class ContactRepository {
  // http://$ip/contact
  factory ContactRepository(Dio dio, {String baseUrl}) = _ContactRepository;
}
