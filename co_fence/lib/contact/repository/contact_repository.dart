import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/contact/model/contact_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'contact_repository.g.dart';

final contactRepositoryProvider = Provider<ContactRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repository = ContactRepository(dio, baseUrl: '$ip/communicate');

    return repository;
  },
);

@RestApi()
abstract class ContactRepository {
  // http://$ip/contact
  factory ContactRepository(Dio dio, {String baseUrl}) = _ContactRepository;

  // http://$ip/communicate/list
  @GET('/list')
  @Headers({
    'accessToken': 'true',
  })
  Future<List<ContactModel>> getContactList();
}
