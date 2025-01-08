import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'appConfig.dart';

/* ================== (1) 헬퍼 함수 ================== */
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

/* ================== (2) VO 클래스들 ================== */
/// 분실물 VO
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

/// 습득물 VO
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

/// 경찰 습득물 VO
class PoliceItem {
  final String atcId;
  final String depplace;
  final String fdfilepathimg;
  final String fdPrdtNm;
  final String fdSbjt;
  final String fdsn;
  final String fdymd;
  final String prdtclnm;
  final String rnum;
  final String reg_date;
  final String clrnm;
  final String tel; // 전화번호 추가

  PoliceItem({
    required this.atcId,
    required this.depplace,
    required this.fdfilepathimg,
    required this.fdPrdtNm,
    required this.fdSbjt,
    required this.fdsn,
    required this.fdymd,
    required this.prdtclnm,
    required this.rnum,
    required this.reg_date,
    required this.clrnm,
    required this.tel, // 전화번호 추가
  });

  factory PoliceItem.fromJson(Map<String, dynamic> json) {
    return PoliceItem(
      atcId: parseString(json['atcId']),
      depplace: parseString(json['depplace']),
      fdfilepathimg: parseString(json['fdfilepathimg']),
      fdPrdtNm: parseString(json['fdPrdtNm']),
      fdSbjt: parseString(json['fdSbjt']),
      fdsn: parseString(json['fdsn']),
      fdymd: parseString(json['fdymd']),
      prdtclnm: parseString(json['prdtclnm']),
      rnum: parseString(json['rnum']),
      reg_date: parseString(json['reg_date']),
      clrnm: parseString(json['clrnm']),
      tel: parseString(json['tel']), // 전화번호 추가
    );
  }
}
/* ================== (3) 검색 결과 페이지 ================== */
// 위에 언급한 `SearchResultPage`와 관련 메서드, 페이징 UI는 변경 없이 유지됩니다.
/* ================== (2) 페이징 결과 공용 구조 ================== */
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

/* ================== (3) 검색 결과 페이지 본문 ================== */
class SearchResultPage extends StatefulWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _isLoading = false;
  String _errorMsg = '';
  String _keyword = '';

  // 탭별 현재 페이지
  int _lostPage = 1;
  int _foundPage = 1;
  int _policePage = 1;

  // 탭별 데이터
  PagedResult<LostItem>? _lostData;
  PagedResult<FoundItem>? _foundData;
  PagedResult<PoliceItem>? _policeData;

  @override
  void initState() {
    super.initState();
    // 탭: 분실물 / 습득물 / 경찰 습득물
    _tabController = TabController(length: 3, vsync: this);

    // 화면 빌드 후 arguments 로부터 검색어 받기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String) {
        _keyword = args;  // 검색어
        _loadData();
      } else {
        setState(() {
          _errorMsg = '검색어를 전달받지 못했습니다.';
        });
      }
    });
  }

  /// API 호출해서 분실물/습득물/경찰 습득물 각각 페이지 데이터 로드
  // Helper 함수 정의
  int parseInt(dynamic value, {int defaultValue = 0}) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMsg = '';
    });

    try {
      final url = Uri.parse(
          appConfig.url+'/appSearch/result'
              '?keyword=$_keyword'
              '&lostPage=$_lostPage'
              '&foundPage=$_foundPage'
              '&policePage=$_policePage'
      );

      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final data = json.decode(utf8.decode(resp.bodyBytes));

        // ----- 분실물 -----
        final lostJson = data['lostPageData'];
        final lostItemsJson = lostJson['items'] as List<dynamic>;
        final lostItems = lostItemsJson.map((e) => LostItem.fromJson(e)).toList();
        _lostData = PagedResult<LostItem>(
          items: lostItems,
          currentPage: parseInt(lostJson['currentPage']),
          totalPages: parseInt(lostJson['totalPages']),
          totalRecords: parseInt(lostJson['totalRecords']),
        );

        // ----- 습득물 -----
        final foundJson = data['foundPageData'];
        final foundItemsJson = foundJson['items'] as List<dynamic>;
        final foundItems = foundItemsJson.map((e) => FoundItem.fromJson(e)).toList();
        _foundData = PagedResult<FoundItem>(
          items: foundItems,
          currentPage: parseInt(foundJson['currentPage']),
          totalPages: parseInt(foundJson['totalPages']),
          totalRecords: parseInt(foundJson['totalRecords']),
        );

        // ----- 경찰 습득물 -----
        final policeJson = data['policePageData'];
        final policeItemsJson = policeJson['items'] as List<dynamic>;
        final policeItems = policeItemsJson.map((e) => PoliceItem.fromJson(e)).toList();
        _policeData = PagedResult<PoliceItem>(
          items: policeItems,
          currentPage: parseInt(policeJson['currentPage']),
          totalPages: parseInt(policeJson['totalPages']),
          totalRecords: parseInt(policeJson['totalRecords']),
        );

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMsg = '서버 오류: ${resp.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMsg = '예외 발생: $e';
      });
    }
  }

  /* ================== 탭별 페이지 이동 함수 ================== */
  Future<void> _lostPrev() async {
    if (_lostData != null && _lostPage > 1) {
      _lostPage--;
      await _loadData();
    }
  }
  Future<void> _lostNext() async {
    if (_lostData != null && _lostPage < _lostData!.totalPages) {
      _lostPage++;
      await _loadData();
    }
  }

  Future<void> _foundPrev() async {
    if (_foundData != null && _foundPage > 1) {
      _foundPage--;
      await _loadData();
    }
  }
  Future<void> _foundNext() async {
    if (_foundData != null && _foundPage < _foundData!.totalPages) {
      _foundPage++;
      await _loadData();
    }
  }

  Future<void> _policePrev() async {
    if (_policeData != null && _policePage > 1) {
      _policePage--;
      await _loadData();
    }
  }
  Future<void> _policeNext() async {
    if (_policeData != null && _policePage < _policeData!.totalPages) {
      _policePage++;
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitle = "'$_keyword' 검색결과";

    // 로딩중
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(appBarTitle), backgroundColor: Colors.orange),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    // 에러
    if (_errorMsg.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(appBarTitle), backgroundColor: Colors.orange),
        body: Center(child: Text(_errorMsg)),
      );
    }

    // 정상
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Colors.orange,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "분실물"),
            Tab(text: "습득물"),
            Tab(text: "경찰 습득물"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // (1) 분실물 탭
          _buildLostTab(),
          // (2) 습득물 탭
          _buildFoundTab(),
          // (3) 경찰 습득물 탭
          _buildPoliceTab(),
        ],
      ),
    );
  }

  /* ================== (A) 분실물 탭 ================== */
  Widget _buildLostTab() {
    if (_lostData == null) {
      return const Center(child: Text("데이터 없음"));
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _lostData!.items.length,
            itemBuilder: (context, index) {
              final item = _lostData!.items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    item.lostTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(item.lostContent),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // 상세 페이지 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LostDetailPage(item: item),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        _pagingControl(
          currentPage: _lostData!.currentPage,
          totalPages: _lostData!.totalPages,
          onPrev: _lostPrev,
          onNext: _lostNext,
        ),
      ],
    );
  }

  /* ================== (B) 습득물 탭 ================== */
  Widget _buildFoundTab() {
    if (_foundData == null) {
      return const Center(child: Text("데이터 없음"));
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _foundData!.items.length,
            itemBuilder: (context, index) {
              final item = _foundData!.items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    item.foundTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.foundContent),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FoundDetailPage(item: item),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        _pagingControl(
          currentPage: _foundData!.currentPage,
          totalPages: _foundData!.totalPages,
          onPrev: _foundPrev,
          onNext: _foundNext,
        ),
      ],
    );
  }

  /* ================== (C) 경찰 습득물 탭 ================== */
// 경찰 습득물 탭
  Widget _buildPoliceTab() {
    if (_policeData == null) {
      return const Center(child: Text("데이터 없음"));
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _policeData!.items.length,
            itemBuilder: (context, index) {
              final item = _policeData!.items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    item.fdPrdtNm, // 변경됨
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.fdSbjt), // 변경됨
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PoliceDetailPage(item: item),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        _pagingControl(
          currentPage: _policeData!.currentPage,
          totalPages: _policeData!.totalPages,
          onPrev: _policePrev,
          onNext: _policeNext,
        ),
      ],
    );
  }
  /* ================== (D) 공통 페이징영역 위젯 ================== */
  Widget _pagingControl({
    required int currentPage,
    required int totalPages,
    required VoidCallback onPrev,
    required VoidCallback onNext,
  }) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: currentPage > 1 ? onPrev : null,
            child: const Text("이전"),
          ),
          const SizedBox(width: 20),
          Text("$currentPage / $totalPages"),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: currentPage < totalPages ? onNext : null,
            child: const Text("다음"),
          ),
        ],
      ),
    );
  }
}

/* ================== (4) 상세 페이지들 예시 ================== */

/// 분실물 상세 페이지
class LostDetailPage extends StatelessWidget {
  final LostItem item;
  final String severUrl = appConfig.url; // 서버 URL을 적절히 설정하세요

  const LostDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 사용자 정보 및 권한을 가져오는 로직이 필요합니다.
    // 예시로 isAuthor, isAdmin 변수를 사용합니다.
    final bool isAuthor = true; // 실제 로직으로 대체
    final bool isAdmin = false; // 실제 로직으로 대체

    return Scaffold(
      appBar: AppBar(
        title: const Text("분실물 상세"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상세 헤더
            Text(
              "제목: ${item.lostTitle}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "작성자: ${item.nickname}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            // 이미지 섹션
            if (item.filePath != null && item.filePath!.isNotEmpty)
              Image.network(
                '${severUrl}imgView?filePath=${item.filePath}',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            else
              Image.asset(
                'assets/images/noimg.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),

            // 정보 섹션
            _buildInfoRow("분실일", item.lostDate),
            _buildInfoRow("물품분류", item.itemName),
            _buildInfoRow("물품세부분류", item.lItemDetail),
            _buildInfoRow("물품색상", item.colorName),
            _buildInfoRow("지역", "${item.sidoName} ${item.gugunName} ${item.lLocationDetail}"),
            _buildInfoRow("사례금", "${item.reward}원"),
            _buildInfoRow("조회수", "${item.lViews}회"),
            const SizedBox(height: 16),

            // 본문 내용
            const Text(
              "내용:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              item.lostContent,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // 버튼 섹션
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 1:1 채팅 보내기 로직
                  },
                  child: const Text("1대1 채팅 보내기"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 처리현황 보기 로직
                  },
                  child: const Text("분실물 처리현황"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 지도에 분실 위치 보기 로직
                  },
                  child: const Text("지도에 분실위치 보기"),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 목록 및 수정 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("목록"),
                ),
                if (isAuthor)
                  ElevatedButton(
                    onPressed: () {
                      // 수정 페이지로 이동
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LostUpdatePage(lostIdx: item.lostIdx),
                        ),
                      );
                      */
                    },
                    child: const Text("수정"),
                  ),
                if (isAdmin)
                  ElevatedButton(
                    onPressed: () {
                      // 블라인드 처리 로직
                    },
                    child: const Text("블라인드"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}




/// 습득물 상세 페이지
class FoundDetailPage extends StatelessWidget {
  final FoundItem item;
  final String severUrl = appConfig.url; // 서버 URL을 적절히 설정하세요

  const FoundDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 사용자 정보 및 권한을 가져오는 로직이 필요합니다.
    // 예시로 isAuthor, isAdmin 변수를 사용합니다.
    final bool isAuthor = true; // 실제 로직으로 대체
    final bool isAdmin = false; // 실제 로직으로 대체

    return Scaffold(
      appBar: AppBar(
        title: const Text("습득물 상세"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상세 헤더
            Text(
              "제목: ${item.foundTitle}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "작성자: ${item.nickname}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            // 이미지 섹션
            if (item.filePath != null && item.filePath!.isNotEmpty)
              Image.network(
                '${severUrl}imgView?filePath=${item.filePath}',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            else
              Image.asset(
                'assets/images/noimg.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),

            // 정보 섹션
            _buildInfoRow("습득일", item.foundDate),
            _buildInfoRow("물품분류", item.itemName),
            _buildInfoRow("물품세부분류", item.fItemDetail),
            _buildInfoRow("물품색상", item.colorName),
            _buildInfoRow("지역", "${item.sidoName} ${item.gugunName} ${item.fLocationDetail}"),
            _buildInfoRow("조회수", "${item.fViews}회"),
            const SizedBox(height: 16),

            // 본문 내용
            const Text(
              "내용:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              item.foundContent,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // 버튼 섹션
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 1:1 채팅 보내기 로직
                  },
                  child: const Text("1대1 채팅 보내기"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 처리현황 보기 로직
                  },
                  child: const Text("습득물 처리현황"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 지도에 습득 위치 보기 로직
                  },
                  child: const Text("지도에 습득위치 보기"),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 목록 및 수정 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("목록"),
                ),
                if (isAuthor)
                  ElevatedButton(
                    onPressed: () {
                      // 수정 페이지로 이동
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LostUpdatePage(lostIdx: item.lostIdx),
                        ),
                      );
                      */
                    },
                    child: const Text("수정"),
                  ),
                if (isAdmin)
                  ElevatedButton(
                    onPressed: () {
                      // 블라인드 처리 로직
                    },
                    child: const Text("블라인드"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

/// 경찰 습득물 상세 페이지
class PoliceDetailPage extends StatelessWidget {
  final PoliceItem item;
  final String severUrl = appConfig.url;
  const PoliceDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("경찰 습득물 상세"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 및 소속 기관
            Text(
              "물품명: ${item.fdPrdtNm}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "소속 기관: ${item.depplace}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // 이미지 섹션
            if (item.fdfilepathimg.isNotEmpty)
              Image.network(
                '${severUrl}imgView?filePath=${item.fdfilepathimg}',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/noimg.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              )
            else
              Image.asset(
                'assets/images/noimg.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),

            // 상세 정보
            _buildInfoRow("접수일", item.fdymd),
            _buildInfoRow("물품분류", item.prdtclnm),
            _buildInfoRow("물품색상", item.clrnm),
            _buildInfoRow("접수자", item.atcId),
            _buildInfoRow("등록일", item.reg_date),
            const SizedBox(height: 16),

            // 본문 내용
            const Text(
              "상세내용:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(item.fdSbjt, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}