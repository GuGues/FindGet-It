import 'package:find_get_it_mobile/global.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../appConfig.dart';
import '../models.dart';
import '../views/lostViews.dart';

class MyLostPage extends StatefulWidget {
  const MyLostPage({Key? key}) : super(key: key);

  @override
  State<MyLostPage> createState() => _MyLostPageState();
}

class _MyLostPageState extends State<MyLostPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _isLoading = false;
  String _errorMsg = '';


  // 탭별 현재 페이지
  int _findingPage = 1;
  int _getPage = 1;
  int _reportPage = 1;

  // 탭별 데이터
  PagedResult<LostItem>? _findingData;
  PagedResult<LostItem>? _getData;
  PagedResult<LostItem>? _reportData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMsg = '';
    });

    try {
      final url = Uri.parse(
        '${appConfig.url}/app/myLost?email='+GlobalState.loginEmail+
            '&findingPage=$_findingPage'
            '&getPage=$_getPage'
            '&reportPage=$_reportPage',
      );

      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final data = json.decode(utf8.decode(resp.bodyBytes));

        // 찾는중
        final findingJson = data['findingPageData'];
        final findingItemsJson = findingJson['items'] as List<dynamic>;
        final findingItems = findingItemsJson.map((e) => LostItem.fromJson(e)).toList();
        print(findingItems);
        _findingData = PagedResult<LostItem>(
          items: findingItems,
          currentPage: findingJson['currentPage'],
          totalPages: findingJson['totalPages'],
          totalRecords: findingJson['totalRecords'],
        );
        // 찾았음
        final getJson = data['getPageData'];
        final getItemsJson = getJson['items'] as List<dynamic>;
        final getItems = getItemsJson.map((e) => LostItem.fromJson(e)).toList();
        print(getItems);
        _getData = PagedResult<LostItem>(
          items: getItems,
          currentPage: getJson['currentPage'],
          totalPages: getJson['totalPages'],
          totalRecords: getJson['totalRecords'],
        );
        // 신고글
        final reportJson = data['reportPageData'];
        final reportItemsJson = reportJson['items'] as List<dynamic>;
        final reportItems = reportItemsJson.map((e) => LostItem.fromJson(e)).toList();
        print(reportItems);
        _reportData = PagedResult<LostItem>(
          items: reportItems,
          currentPage: reportJson['currentPage'],
          totalPages: reportJson['totalPages'],
          totalRecords: reportJson['totalRecords'],
        );
        print(_getData);
        print(_reportData);
        print(_findingData);

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
  Future<void> _findingPrev() async {
    if (_findingData != null && _findingPage > 1) {
      _findingPage--;
      await _loadData();
    }
  }
  Future<void> _findingNext() async {
    if (_findingData != null && _findingPage < _findingData!.totalPages) {
      _findingPage++;
      await _loadData();
    }
  }
  Future<void> _getPrev() async {
    if (_getData != null && _getPage > 1) {
      _getPage--;
      await _loadData();
    }
  }
  Future<void> _getNext() async {
    if (_getData != null && _getPage < _getData!.totalPages) {
      _getPage++;
      await _loadData();
    }
  }
  Future<void> _reportPrev() async {
    if (_reportData != null && _reportPage > 1) {
      _reportPage--;
      await _loadData();
    }
  }
  Future<void> _reportNext() async {
    if (_reportData != null && _reportPage < _reportData!.totalPages) {
      _reportPage++;
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitle = "나의 분실물";

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
            Tab(text: "찾는 중"),
            Tab(text: "GET!"),
            Tab(text: "신고글"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFindingTab(),
          _buildLostTab(),
          _buildReportTab(),
        ],
      ),
    );
  }

  Widget _buildFindingTab() {
    if (_findingData == null) {
      return const Center(child: Text("데이터 없음"));
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _findingData!.items.length,
            itemBuilder: (context, index) {
              final item = _findingData!.items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
          currentPage: _findingData!.currentPage,
          totalPages: _findingData!.totalPages,
          onPrev: _findingPrev,
          onNext: _findingNext,
        ),
      ],
    );
  }

  Widget _buildLostTab() {
    if (_getData == null) {
      return const Center(child: Text("데이터 없음"));
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _getData!.items.length,
            itemBuilder: (context, index) {
              final item = _getData!.items[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                    // 습득물 상세페이지: LostViewsPage
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
          currentPage: _getData!.currentPage,
          totalPages: _getData!.totalPages,
          onPrev: _getPrev,
          onNext: _getNext,
        ),
      ],
    );
  }

// searchResultPage.dart (일부)

  Widget _buildReportTab() {
    if (_reportData == null) {
      return const Center(child: Text("데이터 없음"));
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _reportData!.items.length,
            itemBuilder: (context, index) {
              final item = _reportData!.items[index];

              // 이제 PoliceItem.fromJson에서
              // fdPrdtNm, fdSbjt, depPlace 등을 파싱함

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: ListTile(
                  title: Text(
                    item.lostTitle,  // "핸드폰" 등
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.lostContent),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // 상세 페이지
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LostViewsPage(lostIdx: item.lostIdx,
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
          currentPage: _reportData!.currentPage,
          totalPages: _reportData!.totalPages,
          onPrev: _reportPrev,
          onNext: _reportNext,
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