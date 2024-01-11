import 'package:co_fence/workplace/model/workplace_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userWorkplaceProvider =
    StateNotifierProvider<UserWorkplaceStateNotifier, WorkplaceModel>(
  (ref) => UserWorkplaceStateNotifier(),
);

class UserWorkplaceStateNotifier extends StateNotifier<WorkplaceModel> {
  UserWorkplaceStateNotifier()
      : super(
          WorkplaceModel(
            workPlaceId: 0,
            workPlaceName: '',
            workPlaceAddress: '',
          ),
        );

  // 유저의 현장정보 업데이트
  void updateWorkplace(WorkplaceModel workplace) {
    state = state.copyWith(
      workPlaceId: workplace.workPlaceId,
      workPlaceName: workplace.workPlaceName,
      workPlaceAddress: workplace.workPlaceAddress,
    );
  }
}
