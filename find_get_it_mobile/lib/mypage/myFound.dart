import 'package:find_get_it_mobile/global.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../appConfig.dart';
import '../models.dart';
import '../views/FoundViews.dart';

class MyFoundPage extends StatefulWidget {
  const MyFoundPage({Key? key}) : super(key: key);

  @override
  State<MyFoundPage> createState() => _MyFoundPageState();
}

class _MyFoundPageState extends State<MyFoundPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _isLoading = false;
  String _errorMsg = '';


  // 탭별 현재 페이지
  int _findingPage = 1;
  int _foundPage = 1;
  int _reportPage = 1;

  // 탭별 데이터
  PagedResult<FoundItem>? _findingData;
  PagedResult<FoundItem>? _foundData;
  PagedResult<FoundItem>? _reportData;

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
        '${appConfig.url}/app/myFound?email='+GlobalState.loginEmail+
            '&findingPage=$_findingPage'
            '&foundPage=$_foundPage'
            '&reportPage=$_reportPage',
      );

      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final data = json.decode(utf8.decode(resp.bodyBytes));

        // 찾는중
        final findingJson = data['findingPageData'];
        final findingItemsJson = findingJson['items'] as List<dynamic>;
        final findingItems = findingItemsJson.map((e) => FoundItem.fromJson(e)).toList();
        _findingData = PagedResult<FoundItem>(
          items: findingItems,
          currentPage: findingJson['currentPage'],
          totalPages: findingJson['totalPages'],
          totalRecords: findingJson['totalRecords'],
        );
        // 찾았음
        final foundJson = data['foundPageData'];
        final foundItemsJson = foundJson['items'] as List<dynamic>;
        final foundItems = foundItemsJson.map((e) => FoundItem.fromJson(e)).toList();
        _foundData = PagedResult<FoundItem>(
          items: foundItems,
          currentPage: foundJson['currentPage'],
          totalPages: foundJson['totalPages'],
          totalRecords: foundJson['totalRecords'],
        );
        // 신고글
        final reportJson = data['reportPageData'];
        final reportItemsJson = reportJson['items'] as List<dynamic>;
        final reportItems = reportItemsJson.map((e) => FoundItem.fromJson(e)).toList();
        _reportData = PagedResult<FoundItem>(
          items: reportItems,
          currentPage: reportJson['currentPage'],
          totalPages: reportJson['totalPages'],
          totalRecords: reportJson['totalRecords'],
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
    final appBarTitle = "나의 습득물";

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
            Tab(text: "FOUND!"),
            Tab(text: "신고글"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFindingTab(),
          _buildFoundTab(),
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
                    item.foundTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.foundContent),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // 분실물 상세페이지: LostViewsPage
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
          currentPage: _findingData!.currentPage,
          totalPages: _findingData!.totalPages,
          onPrev: _findingPrev,
          onNext: _findingNext,
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
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                    item.foundTitle,  // "핸드폰" 등
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.foundContent),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // 상세 페이지
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FoundViewsPage(foundIdx: item.foundIdx,
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