import 'package:co_fence/common/const/data.dart';
import 'package:co_fence/common/dio/dio.dart';
import 'package:co_fence/common/model/cursor_pagination_model.dart';
import 'package:co_fence/common/model/pagination_params.dart';
import 'package:co_fence/workplace/model/workplace_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'workplace_repository.g.dart';

final workplaceRepositoryProvider = Provider<WorkplaceRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    final repository = WorkplaceRepository(dio, baseUrl: '$ip/wp');

    return repository;
  },
);

@RestApi()
abstract class WorkplaceRepository {
  // http://$ip/workplace
  factory WorkplaceRepository(Dio dio, {String baseUrl}) = _WorkplaceRepository;

  //작업현장 조회
  //http://$ip/workplace/getInfo?page=1&size=10
  @GET('/getInfo')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<WorkplaceModel>> paginate({
    @Queries() PaginationParams paginationParams = const PaginationParams(
      page: 1,
      size: 10,
    ),
  });

  // 작업현장 검색
  // http://$ip/workplace/?search=$searchText
}
