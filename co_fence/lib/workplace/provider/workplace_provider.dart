import 'package:co_fence/workplace/model/workplace_model.dart';
import 'package:co_fence/workplace/repository/workplace_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workplaceProvider =
    StateNotifierProvider<WorkplaceStateNotifier, List<WorkplaceModel>>(
  (ref) {
    final repository = ref.watch(workplaceRepositoryProvider);
    final notifier = WorkplaceStateNotifier(
      repository: repository,
    );

    return notifier;
  },
);

class WorkplaceStateNotifier extends StateNotifier<List<WorkplaceModel>> {
  final WorkplaceRepository repository;

  WorkplaceStateNotifier({
    required this.repository,
  }) : super([]) {
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate(page: 1, size: 10);

    state = resp.data;
  }
}
