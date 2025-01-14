import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'appConfig.dart';
import 'models.dart';
import 'views/FoundViews.dart';
import 'views/lostViews.dart';
import 'views/policeViews.dart';


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
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String) {
        _keyword = args;
        _loadData();
      } else {
        setState(() {
          _errorMsg = '검색어를 전달받지 못했습니다.';
        });
      }
    });
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMsg = '';
    });

    try {
      final url = Uri.parse(
        '${appConfig.url}/appSearch/result?keyword=$_keyword'
            '&lostPage=$_lostPage'
            '&foundPage=$_foundPage'
            '&policePage=$_policePage',
      );

      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final data = json.decode(utf8.decode(resp.bodyBytes));

        // 분실물
        final lostJson = data['lostPageData'];
        final lostItemsJson = lostJson['items'] as List<dynamic>;
        final lostItems = lostItemsJson.map((e) => LostItem.fromJson(e)).toList();
        _lostData = PagedResult<LostItem>(
          items: lostItems,
          currentPage: lostJson['currentPage'],
          totalPages: lostJson['totalPages'],
          totalRecords: lostJson['totalRecords'],
        );

        // 습득물
        final foundJson = data['foundPageData'];
        final foundItemsJson = foundJson['items'] as List<dynamic>;
        final foundItems = foundItemsJson.map((e) => FoundItem.fromJson(e)).toList();
        _foundData = PagedResult<FoundItem>(
          items: foundItems,
          currentPage: foundJson['currentPage'],
          totalPages: foundJson['totalPages'],
          totalRecords: foundJson['totalRecords'],
        );

        // 경찰 습득물
        final policeJson = data['policePageData'];
        final policeItemsJson = policeJson['items'] as List<dynamic>;
        final policeItems =
        policeItemsJson.map((e) => PoliceItem.fromJson(e)).toList();
        _policeData = PagedResult<PoliceItem>(
          items: policeItems,
          currentPage: policeJson['currentPage'],
          totalPages: policeJson['totalPages'],
          totalRecords: policeJson['totalRecords'],
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

  // 페이징 이동 함수들
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

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(appBarTitle), backgroundColor: Colors.orange),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_errorMsg.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(appBarTitle), backgroundColor: Colors.orange),
        body: Center(child: Text(_errorMsg)),
      );
    }

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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.lostContent),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // 분실물 상세페이지: LostViewsPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LostViewsPage(lostIdx: item.lostIdx),
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
                    // 습득물 상세페이지: FoundViewsPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FoundViewsPage(foundIdx: item.foundIdx),
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

// searchResultPage.dart (일부)

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

              // 이제 PoliceItem.fromJson에서
              // fdPrdtNm, fdSbjt, depPlace 등을 파싱함

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    item.fdPrdtNm,  // "핸드폰" 등
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.fdSbjt),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // 상세 페이지
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PoliceViewsPage(
                          atcId: item.atcId,
                          // 검색 목록엔 fdsn 도 있을 수 있음
                          fdsn: item.fdsn, // 가능하다면 넘김
                        ),
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