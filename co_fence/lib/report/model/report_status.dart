// ignore_for_file: constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportStatusProvider =
    StateNotifierProvider<ReportStatusNotifier, ReportStatus>(
  (ref) => ReportStatusNotifier(),
);

class ReportStatusNotifier extends StateNotifier<ReportStatus> {
  ReportStatusNotifier() : super(ReportStatus.Fire_Hazard);

  void setReportStatus(ReportStatus status) {
    state = status;
  }
}

enum ReportStatus {
  // 화재 위험
  Fire_Hazard,
  // 붕괴 위험
  Collapse_Hazard,
  // 기계 결함
  Machanical_Failure,
  // 화학 물질 누출 위험
  Chemical_Spill_Hazard,
  // 전기 위험
  Electric_Hazard,
  // 탈락 위험
  Falling_Hazard,
  // 폭바라 위험
  Explosion_Hazard,
  // 기타 위험
  Etc_Hazard,
}

extension ReportStatusExtension on ReportStatus {
  // Get the code of the enum
  String get code {
    return toString().split('.').last.replaceAll('_', ' ');
  }

  // Get the display name of the enum
  String get displayName {
    switch (this) {
      case ReportStatus.Fire_Hazard:
        return '화재 위험';
      case ReportStatus.Collapse_Hazard:
        return '붕괴 위험';
      case ReportStatus.Machanical_Failure:
        return '기계 결함';
      case ReportStatus.Chemical_Spill_Hazard:
        return '화학 물질 누출 위험';
      case ReportStatus.Electric_Hazard:
        return '전기 위험';
      case ReportStatus.Falling_Hazard:
        return '탈락 위험';
      case ReportStatus.Explosion_Hazard:
        return '폭발 위험';
      case ReportStatus.Etc_Hazard:
        return '기타 위험';
      default:
        return '';
    }
  }
}
