// ignore_for_file: constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportStatusProvider =
    StateNotifierProvider<ReportStatusNotifier, ReportStatus>(
  (ref) => ReportStatusNotifier(),
);

class ReportStatusNotifier extends StateNotifier<ReportStatus> {
  ReportStatusNotifier() : super(ReportStatus.FIRE_HAZARD);

  void setReportStatus(ReportStatus status) {
    state = status;
  }
}

enum ReportStatus {
  // 화재 위험
  FIRE_HAZARD,
  // 붕괴 위험
  COLLAPSE_HAZARD,
  // 기계 결함
  MECHANICAL_FAILURE,
  // 화학 물질 누출 위험
  CHEMICAL_SPILL_HAZARD,
  // 전기 위험
  ELECTRIC_HAZARD,
  // 탈락 위험
  FALLING_HAZARD,
  // 폭바라 위험
  EXPLOSION_HAZARD,
  // 기타 위험
  ETC_HAZARD,
}

// 문자열을 ReportStatus로 변환하는 함수
ReportStatus convertStringToReportStatus(String input) {
  for (ReportStatus status in ReportStatus.values) {
    if (status.displayName == input) {
      return status;
    }
  }
  // 일치하는 것을 찾지 못하면 기본값 반환 또는 예외 처리
  return ReportStatus.FIRE_HAZARD;
}

extension ReportStatusExtension on ReportStatus {
  // Get the code of the enum and only first letter to uppercase
  // ex) FIRE_HAZARD -> Fire hazard
  String get code {
    return toString().split('.').last.split('_').map((e) {
      return '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}';
    }).join(' ');
  }

  // Get the display name of the enum
  String get displayName {
    switch (this) {
      case ReportStatus.FIRE_HAZARD:
        return '화재 위험';
      case ReportStatus.COLLAPSE_HAZARD:
        return '붕괴 위험';
      case ReportStatus.MECHANICAL_FAILURE:
        return '기계 결함';
      case ReportStatus.CHEMICAL_SPILL_HAZARD:
        return '화학 물질 누출 위험';
      case ReportStatus.ELECTRIC_HAZARD:
        return '전기 위험';
      case ReportStatus.FALLING_HAZARD:
        return '탈락 위험';
      case ReportStatus.EXPLOSION_HAZARD:
        return '폭발 위험';
      case ReportStatus.ETC_HAZARD:
        return '기타 위험';
      default:
        return '';
    }
  }
}
