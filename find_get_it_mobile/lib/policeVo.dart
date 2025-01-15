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
    final fdFilePathImg = json['fdfilepathimg'] ?? json['fdFilePathImg'];
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