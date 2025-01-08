/* ================== 헬퍼 함수 ================== */
String parseString(dynamic value, {String defaultValue = ''}) {
  if (value is String) return value;
  if (value is int) return value.toString(); // int를 문자열로 변환
  if (value != null) return value.toString();
  return defaultValue;
}

int parseInt(dynamic value, {int defaultValue = 0}) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? defaultValue;
  return defaultValue;
}

class FoundItem {
  final String foundIdx;
  final String email;
  final String foundTitle;
  final String foundContent;
  final String foundDate;
  final String fRegDate;
  final int fViews;
  final String itemState;
  final String locationCode;
  final String fLocationDetail;
  final String itemCode;
  final String fItemDetail;
  final String colorCode;
  final int foundState;
  final String itemName;
  final String colorName;
  final String sidoName;
  final String gugunName;
  final String nickname;
  final String? filePath; // 이미지 경로 (nullable)

  FoundItem({
    required this.foundIdx,
    required this.email,
    required this.foundTitle,
    required this.foundContent,
    required this.foundDate,
    required this.fRegDate,
    required this.fViews,
    required this.itemState,
    required this.locationCode,
    required this.fLocationDetail,
    required this.itemCode,
    required this.fItemDetail,
    required this.colorCode,
    required this.foundState,
    required this.itemName,
    required this.colorName,
    required this.sidoName,
    required this.gugunName,
    required this.nickname,
    this.filePath,
  });

  /// JSON 데이터를 `FoundItem` 객체로 변환하는 팩토리 생성자
  factory FoundItem.fromJson(Map<String, dynamic> json) {
    return FoundItem(
      foundIdx: json['foundIdx'] as String,
      email: json['email'] as String,
      foundTitle: json['foundTitle'] as String,
      foundContent: json['foundContent'] as String,
      foundDate: json['foundDate'] as String,
      fRegDate: json['fRegDate'] as String,
      fViews: json['fViews'] as int? ?? 0, // null일 경우 0으로 처리
      itemState: json['itemState'] as String,
      locationCode: json['locationCode'] as String,
      fLocationDetail: json['fLocationDetail'] as String,
      itemCode: json['itemCode'] as String,
      fItemDetail: json['fItemDetail'] as String,
      colorCode: json['colorCode'] as String,
      foundState: json['foundState'] as int? ?? 0, // null일 경우 0으로 처리
      itemName: json['itemName'] as String,
      colorName: json['colorName'] as String,
      sidoName: json['sidoName'] as String,
      gugunName: json['gugunName'] as String,
      nickname: json['nickname'] as String,
      filePath: json['filePath'] as String?, // nullable
    );
  }
}
