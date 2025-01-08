import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'appConfig.dart';
import 'views/lostView.dart';
import 'views/foundView.dart';
import 'views/policeView.dart';
import 'models/lost_item.dart';
import 'models/found_item.dart';
import 'models/police_item.dart';

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
/* ================== (1) 페이징 결과 공용 구조 ================== */
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

/* ================== (2) 검색 결과 페이지 ================== */
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
        _keyword = args; // 검색어
        _loadData();
      } else {
        setState(() {
          _errorMsg = '검색어를 전달받지 못했습니다.';
        });
      }
    });
  }

  /// API 호출해서 분실물/습득물/경찰 습득물 각각 페이지 데이터 로드
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMsg = '';
    });

    try {
      final url = Uri.parse(
          '${appConfig.url}/appSearch/result'
              '?keyword=$_keyword'
              '&lostPage=$_lostPage'
              '&foundPage=$_foundPage'
              '&policePage=$_policePage');

      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final data = json.decode(utf8.decode(resp.bodyBytes));

        // ----- 분실물 -----
        final lostJson = data['lostPageData'];
        final lostItemsJson = lostJson['items'] as List<dynamic>;
        final lostItems = lostItemsJson.map((e) => LostItem.fromJson(e)).toList();
        _lostData = PagedResult<LostItem>(
          items: lostItems,
          currentPage: lostJson['currentPage'] as int,
          totalPages: lostJson['totalPages'] as int,
          totalRecords: lostJson['totalRecords'] as int,
        );

        // ----- 습득물 -----
        final foundJson = data['foundPageData'];
        final foundItemsJson = foundJson['items'] as List<dynamic>;
        final foundItems = foundItemsJson.map((e) => FoundItem.fromJson(e)).toList();
        _foundData = PagedResult<FoundItem>(
          items: foundItems,
          currentPage: foundJson['currentPage'] as int,
          totalPages: foundJson['totalPages'] as int,
          totalRecords: foundJson['totalRecords'] as int,
        );

        // ----- 경찰 습득물 -----
        final policeJson = data['policePageData'];
        final policeItemsJson = policeJson['items'] as List<dynamic>;
        final policeItems = policeItemsJson.map((e) => PoliceItem.fromJson(e)).toList();
        _policeData = PagedResult<PoliceItem>(
          items: policeItems,
          currentPage: policeJson['currentPage'] as int,
          totalPages: policeJson['totalPages'] as int,
          totalRecords: policeJson['totalRecords'] as int,
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

    // 로딩 중
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
          _buildLostTab(),
          _buildFoundTab(),
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
                child: ListTile(
                  title: Text(item.lostTitle),
                  subtitle: Text(item.lostContent),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LostDetailPage(item: item, serverUrl: appConfig.url),
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
                child: ListTile(
                  title: Text(item.foundTitle),
                  subtitle: Text(item.foundContent),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FoundDetailPage(item: item, serverUrl: appConfig.url),
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
                child: ListTile(
                  title: Text(item.fdPrdtNm),
                  subtitle: Text(item.fdSbjt),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PoliceDetailPage(item: item, serverUrl: appConfig.url),
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

  /* ================== (D) 공통 페이징 영역 위젯 ================== */
  Widget _pagingControl({
    required int currentPage,
    required int totalPages,
    required VoidCallback onPrev,
    required VoidCallback onNext,
  }) {
    return Container(
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

