// ignore_for_file: constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ActionStatus {
  // 조치전
  Before_Action,
  // 조치중
  In_Action,
  // 중단된 작업
  Work_Suspended,
  // 조치 완료
  Action_Completed,
}

final actionStatusProvider =
    StateNotifierProvider<ActionStatusNotifier, ActionStatus>(
  (ref) => ActionStatusNotifier(),
);

class ActionStatusNotifier extends StateNotifier<ActionStatus> {
  ActionStatusNotifier() : super(ActionStatus.Before_Action);

  void setReportStatus(ActionStatus status) {
    state = status;
  }
}

// 문자열을 ReportStatus로 변환하는 함수
ActionStatus convertStringToActionStatus(String input) {
  for (ActionStatus status in ActionStatus.values) {
    if (status.displayName == input) {
      return status;
    }
  }
  // 일치하는 것을 찾지 못하면 기본값 반환 또는 예외 처리
  return ActionStatus.Before_Action;
}

extension ActionStatusExtension on ActionStatus {
  // Get the code of the enum
  String get code {
    return toString().split('.').last.replaceAll('_', ' ');
  }

  // Get the display name of the enum
  String get displayName {
    switch (this) {
      case ActionStatus.Before_Action:
        return '조치전';
      case ActionStatus.In_Action:
        return '조치중';
      case ActionStatus.Work_Suspended:
        return '중단된 작업';
      case ActionStatus.Action_Completed:
        return '조치완료';

      default:
        return '';
    }
  }
}
