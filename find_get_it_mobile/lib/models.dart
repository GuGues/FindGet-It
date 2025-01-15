import 'package:flutter/material.dart';

/// ================== 헬퍼 함수 (공용) ==================
String parseString(dynamic value, {String defaultValue = ''}) {
  if (value is String) return value;
  if (value != null) return value.toString();
  return defaultValue;
}

int parseInt(dynamic value, {int defaultValue = 0}) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? defaultValue;
  return defaultValue;
}

/// ================== (1) 분실물 VO ==================
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
  final String? filePath;

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

  factory LostItem.fromJson(Map<String, dynamic> json) {
    return LostItem(
      lostIdx: parseString(json['lostIdx']),
      email: parseString(json['email']),
      lostTitle: parseString(json['lostTitle']),
      lostContent: parseString(json['lostContent']),
      lostDate: parseString(json['lostDate']),
      lRegDate: parseString(json['lRegDate']),
      lViews: parseInt(json['lViews']),
      locationCode: parseString(json['locationCode']),
      lLocationDetail: parseString(json['lLocationDetail']),
      itemCode: parseString(json['itemCode']),
      lItemDetail: parseString(json['lItemDetail']),
      reward: parseInt(json['reward']),
      colorCode: parseString(json['colorCode']),
      lostState: parseInt(json['lostState']),
      itemName: parseString(json['itemName']),
      colorName: parseString(json['colorName']),
      sidoName: parseString(json['sidoName']),
      gugunName: parseString(json['gugunName']),
      nickname: parseString(json['nickname']),
      filePath: json['filePath'] != null ? parseString(json['filePath']) : null,
    );
  }
}

/// ================== (2) 습득물 VO ==================
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
  final String? filePath;

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

/// ================== (3) 경찰 습득물 VO ==================
/// 여기서 parseString2 를 사용 (함수 이름 충돌 방지)
String parseString2(dynamic value, {String defaultValue = ''}) {
  if (value is String) return value;
  if (value != null) return value.toString();
  return defaultValue;
}

class PoliceItem {
  final String atcId;
  final String depPlace;
  final String fdFilePathImg;
  final String fdPrdtNm;
  final String fdsn;
  final String fdSbjt;
  final String fdYmd;
  final String prdtClNm;
  final String clrNm;
  final String regDate;

  PoliceItem({
    required this.atcId,
    required this.depPlace,
    required this.fdFilePathImg,
    required this.fdPrdtNm,
    required this.fdsn,
    required this.fdSbjt,
    required this.fdYmd,
    required this.prdtClNm,
    required this.clrNm,
    required this.regDate,
  });

  factory PoliceItem.fromJson(Map<String, dynamic> json) {
    // 디버깅용 출력
    print('===== PoliceItem JSON Debug =====');
    json.forEach((key, value) {
      print('key=$key, value=$value');
    });
    print('=================================');

    final atcId         = json['atcid']         ?? json['ATCID'];
    final depPlace      = json['depplace']      ?? json['DEPPLACE'];
    final fdFilePathImg = json['fdfilepathimg'] ?? json['FDFILEPATHIMG'];
    final fdPrdtNm      = json['fdprdtnm']      ?? json['FDPRDTNM'];
    final fdsn          = json['fdsn']          ?? json['FDSN'];
    final fdSbjt        = json['fdsbjt']        ?? json['FDSBJT'];
    final fdYmd         = json['fdymd']         ?? json['FDYMD'];
    final prdtClNm      = json['prdtclnm']      ?? json['PRDTCLNM'];
    final clrNm         = json['clrnm']         ?? json['CLRNM'];
    final regDate       = json['regdate']       ??
        json['reg_date']      ??
        json['REG_DATE'];

    return PoliceItem(
      atcId:         parseString2(atcId),
      depPlace:      parseString2(depPlace),
      fdFilePathImg: parseString2(fdFilePathImg),
      fdPrdtNm:      parseString2(fdPrdtNm),
      fdsn:          parseString2(fdsn),
      fdSbjt:        parseString2(fdSbjt),
      fdYmd:         parseString2(fdYmd),
      prdtClNm:      parseString2(prdtClNm),
      clrNm:         parseString2(clrNm),
      regDate:       parseString2(regDate),
    );
  }
}

/// ================== (4) 공용 페이징 결과 구조 ==================
class PagedResult<T> {
  final List<T> items;
  final int currentPage;
  final int totalPages;
  final int totalRecords;

  PagedResult({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
  });
}