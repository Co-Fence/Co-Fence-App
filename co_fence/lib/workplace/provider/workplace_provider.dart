import 'package:co_fence/common/model/cursor_pagination_model.dart';
import 'package:co_fence/common/model/pagination_params.dart';
import 'package:co_fence/workplace/model/workplace_model.dart';
import 'package:co_fence/workplace/repository/workplace_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workplaceProvider =
    StateNotifierProvider<WorkplaceStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(workplaceRepositoryProvider);
    final notifier = WorkplaceStateNotifier(
      repository: repository,
    );

    return notifier;
  },
);

class WorkplaceStateNotifier extends StateNotifier<CursorPaginationBase> {
  final WorkplaceRepository repository;

  WorkplaceStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  void paginate({
    // queryParameter의 count
    int fetchSize = 20,
    // 추가로 데이터 가져오기
    // true면 데이터를 추가로 가져옴
    // false면 데이터를 새로고침(현재 상태를 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩
    // true면 CursorPaginationLoading()
    // false면 현재 상태를 유지
    bool forceRefetch = false,
  }) async {
    try {
// 5가지 가능성
      // State의 상태
      // [상태가]
      // 1. CursorPagination - 정상적으로 데이터를 가져온 상태
      // 2. CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
      // 3. CursorPaginationError - 에러가 있는 상태
      // 4. CursorPaginationRefetching - 첫 번째 페이지부터 다시 데이터를 가져올 때
      // 5. CursorPaginationFetchingMore - 추가로 데이터를 가져올 때

      // 바로 반환하는 상황
      // 1. hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 들고있다면)
      // 2. 로딩중 - fetchMore : true
      // fetchMore가 아닐 때 로딩중이라면, 새로고침을 하고 있는 상황이므로
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }
      // 처음 로딩일 때
      final isLoading = state is CursorPaginationLoading;
      // 새로고침
      final isRefetching = state is CursorPaginationRefetching;
      // 추가로 데이터를 가져오는 중
      final isFetchingMore = state is CursorPaginationFetchingMore;
      // 2번 반환 상황
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(
        page: 1,
        size: fetchSize,
      );

      // fetchMore가 true면
      // 데이터를 추가로 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          page: pState.meta.count ~/ fetchSize + 1,
        );
        print(paginationParams.page);
      } else {
        // 데이터를 처음부터 가져오는 상황
        // 만약 데이터가 있는 상황이라면
        // 기존 데이터를 보존한채로 API를 호출
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;
          state = CursorPaginationRefetching(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }
      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );
      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;
        // 가져온 데이터를 기존 데이터에 추가
        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e) {
      state = CursorPaginationError(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }
}
