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
    // 디버깅용 출력
    print('===== LostItem JSON Debug =====');
    json.forEach((key, value) {
      print('key=$key, value=$value');
    });
    print('=================================');


    return LostItem(
      lostIdx: parseString(json['lostIdx']??json['LOSTIDX']),
      email: parseString(json['email']??json['EMAIL']),
      lostTitle: parseString(json['lostTitle']??json['LOSTTITLE']),
      lostContent: parseString(json['lostContent']??json['LOSTCONTENT']),
      lostDate: parseString(json['lostDate']??json['LOSTDATE']),
      lRegDate: parseString(json['lRegDate']??json['LREGDATE']),
      lViews: parseInt(json['lViews']??json['LVIEWS']),
      locationCode: parseString(json['locationCode']??json['LOCATIONCODE']),
      lLocationDetail: parseString(json['lLocationDetail']??json['LLOCATIONDETAIL']),
      itemCode: parseString(json['itemCode']??json['ITEMCODE']),
      lItemDetail: parseString(json['lItemDetail']??json['LITEMDETAIL']),
      reward: parseInt(json['reward']??json['REWARD']),
      colorCode: parseString(json['colorCode']??json['COLORCODE']),
      lostState: parseInt(json['lostState']??json['LOSTSTATE']),
      itemName: parseString(json['itemName']??json['ITEMNAME']),
      colorName: parseString(json['colorName']??json['COLORNAME']),
      sidoName: parseString(json['sidoName']??json['SIDONAME']),
      gugunName: parseString(json['gugunName']??json['GUGUNNAME']),
      nickname: parseString(json['nickname']??json['NICKNAME']),
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
    // 디버깅용 출력
    print('===== LostItem JSON Debug =====');
    json.forEach((key, value) {
      print('key=$key, value=$value');
    });
    print('=================================');


    return FoundItem(
      foundIdx: parseString(json['foundIdx']??json['FOUNDIDX']),
      email: parseString(json['email']??json['EMAIL']),
      foundTitle: parseString(json['foundTitle']??json['FOUNDTITLE']),
      foundContent: parseString(json['foundContent']??json['FOUNDCONTENT']),
      foundDate: parseString(json['foundDate']??json['FOUNDDATE']),
      fRegDate: parseString(json['fRegDate']??json['FREGDATE']),
      fViews: parseInt(json['fViews']??json['FVIEWS']),
      itemState: parseString(json['itemState']??json['ITEMSTATE']),
      locationCode: parseString(json['locationCode']??json['LOCATIONCODE']),
      fLocationDetail: parseString(json['fLocationDetail']??json['FLOCATIONDETAIL']),
      itemCode: parseString(json['itemCode']??json['ITEMCODE']),
      fItemDetail: parseString(json['fItemDetail']??json['FITEMDETAIL']),
      colorCode: parseString(json['colorCode']??json['COLORCODE']),
      foundState: parseInt(json['foundState']??json['FOUNDSTATE']),
      itemName: parseString(json['itemName']??json['ITEMNAME']),
      colorName: parseString(json['colorName']??json['COLORNAME']),
      sidoName: parseString(json['sidoName']??json['SIDONAME']),
      gugunName: parseString(json['gugunName']??json['GUGUNNAME']),
      nickname: parseString(json['nickname']??json['NICKNAME']),
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

    final atcId         = json['atcId']         ?? json['ATCID'];
    final depPlace      = json['depPlace']      ?? json['DEPPLACE'];
    final fdFilePathImg = json['fdFilePathImg'] ?? json['FDFILEPATHIMG'];
    final fdPrdtNm      = json['fdPrdtNm']      ?? json['FDPRDTNM'];
    final fdsn          = json['fdsn']          ?? json['FDSN'];
    final fdSbjt        = json['fdSbjt']        ?? json['FDSBJT'];
    final fdYmd         = json['fdYmd']         ?? json['FDYMD'];
    final prdtClNm      = json['prdtClNm']      ?? json['PRDTCLNM'];
    final clrNm         = json['clrNm']         ?? json['CLRNM'];
    final regDate       = json['regDate']       ??
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