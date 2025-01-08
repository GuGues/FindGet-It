// lib/models/found_item.dart

import '../utils/parsing.dart';

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

  factory FoundItem.fromJson(Map<String, dynamic> json) {
    return FoundItem(
      foundIdx: parseString(json['foundIdx']),
      email: parseString(json['email']),
      foundTitle: parseString(json['foundTitle']),
      foundContent: parseString(json['foundContent']),
      foundDate: parseString(json['foundDate']),
      fRegDate: parseString(json['fRegDate']),
      fViews: parseInt(json['fViews']),
      itemState: parseString(json['itemState']),
      locationCode: parseString(json['locationCode']),
      fLocationDetail: parseString(json['fLocationDetail']),
      itemCode: parseString(json['itemCode']),
      fItemDetail: parseString(json['fItemDetail']),
      colorCode: parseString(json['colorCode']),
      foundState: parseInt(json['foundState']),
      itemName: parseString(json['itemName']),
      colorName: parseString(json['colorName']),
      sidoName: parseString(json['sidoName']),
      gugunName: parseString(json['gugunName']),
      nickname: parseString(json['nickname']),
      filePath: json['filePath'] != null ? parseString(json['filePath']) : null,
    );
  }
}