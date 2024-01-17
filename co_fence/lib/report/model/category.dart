// ignore_for_file: constant_identifier_names

enum Category {
  // 화재
  FIRE,
  // 붕괴
  COLLAPSE,
  // 기계
  MACHINE,
  // 화학 물질
  CHEMICAL,
  // 전기
  ELECTRIC,
  // 탈락
  DROP_OUT,
  // 폭발
  EXPLOSION,
  // 기타
  ETC,
}

List<Category> categories = Category.values;
