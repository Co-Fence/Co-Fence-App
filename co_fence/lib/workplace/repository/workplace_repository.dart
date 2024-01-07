import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'workplace_repository.g.dart';

@RestApi()
abstract class WorkplaceRepository {
  // http://$ip/workplace
  factory WorkplaceRepository(Dio dio, {String baseUrl}) = _WorkplaceRepository;

  // 작업현장 조회
  // http://$ip/workplace/
  // @GET('/')
  // paginate();

  // 작업현장 검색
  // http://$ip/workplace/?search=$searchText
}
