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

class LostItem {
  final String lostIdx;
  final String email;
  final String lostTitle;
  final String lostContent;
  final String lostDate;
  final String lRegDate;
  final int lViews;
  final String locationCode;
  final String lLocationDetail;
  final String itemCode;
  final String lItemDetail;
  final int reward;
  final String colorCode;
  final int lostState;
  final String itemName;
  final String colorName;
  final String sidoName;
  final String gugunName;
  final String nickname;
  final String? filePath; // 이미지 경로 (nullable)

  LostItem({
    required this.lostIdx,
    required this.email,
    required this.lostTitle,
    required this.lostContent,
    required this.lostDate,
    required this.lRegDate,
    required this.lViews,
    required this.locationCode,
    required this.lLocationDetail,
    required this.itemCode,
    required this.lItemDetail,
    required this.reward,
    required this.colorCode,
    required this.lostState,
    required this.itemName,
    required this.colorName,
    required this.sidoName,
    required this.gugunName,
    required this.nickname,
    this.filePath,
  });

  /// JSON 데이터를 `LostItem` 객체로 변환하는 팩토리 생성자
  factory LostItem.fromJson(Map<String, dynamic> json) {
    return LostItem(
      lostIdx: json['lostIdx'] as String,
      email: json['email'] as String,
      lostTitle: json['lostTitle'] as String,
      lostContent: json['lostContent'] as String,
      lostDate: json['lostDate'] as String,
      lRegDate: json['lRegDate'] as String,
      lViews: json['lViews'] as int? ?? 0, // null일 경우 0으로 처리
      locationCode: json['locationCode'] as String,
      lLocationDetail: json['lLocationDetail'] as String,
      itemCode: json['itemCode'] as String,
      lItemDetail: json['lItemDetail'] as String,
      reward: json['reward'] as int? ?? 0, // null일 경우 0으로 처리
      colorCode: json['colorCode'] as String,
      lostState: json['lostState'] as int? ?? 0, // null일 경우 0으로 처리
      itemName: json['itemName'] as String,
      colorName: json['colorName'] as String,
      sidoName: json['sidoName'] as String,
      gugunName: json['gugunName'] as String,
      nickname: json['nickname'] as String,
      filePath: json['filePath'] as String?, // nullable
    );
  }
}