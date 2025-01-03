import 'package:flutter/material.dart';
import 'lostPage.dart';
import 'searchResultPage.dart'; // 검색 결과 페이지

void main() {
  runApp(const MyApp());
}

/// 최상위 위젯
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
      // 라우트 등록
      routes: {
        // 분실물 페이지
        '/lost': (context) => const LostPage(),
        // 습득물, FAQ, CS, Police, GetTalk 등은 필요 시 구현
        // '/found': (context) => const FoundPage(),
        // '/faq': (context) => const FaqPage(),
        // '/cs': (context) => const CsPage(),
        // '/policeFound': (context) => const PoliceFoundPage(),
        // '/getTalk': (context) => const GetTalkPage(),

        // 검색결과 페이지
        '/searchResult': (context) => const SearchResultPage(),
      },
    );
  }
}

/// 홈화면 (검색 + 메뉴버튼)
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 그리드에 표시될 메뉴 목록
  final List<Map<String, String>> buttonData = [
    {"label": "분실물 게시판", "route": "/lost", "image": "assets/icon/lost_orange.png"},
    {"label": "습득물 게시판", "route": "/found", "image": "assets/icon/find_orange.png"},
    {"label": "FAQ", "route": "/faq", "image": "assets/icon/faq_orange.png"},
    {"label": "공지 사항", "route": "/cs", "image": "assets/icon/speaker_orange.png"},
    {"label": "경찰청 습득물", "route": "/policeFound", "image": "assets/icon/lost112_orange.png"},
    {"label": "Get 톡", "route": "/getTalk", "image": "assets/icon/get_talk_orange.png"},
  ];

  /// 검색어
  String _searchText = '';

  /// 검색 로직
  void _doSearch() {
    // 검색결과 페이지로 이동
    Navigator.pushNamed(
      context,
      '/searchResult', // searchResultPage.dart
      arguments: _searchText, // 검색어 전달
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈 화면 예시'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// 검색창
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    onSubmitted: (value) {
                      _doSearch();
                    },
                    decoration: InputDecoration(
                      labelText: '검색',
                      hintText: '검색어를 입력하세요',
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => _doSearch(),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                // 기존 찾기 버튼 제거
              ],
            ),
            const SizedBox(height: 20),

            /// 2열 그리드
            Expanded(
              child: GridView.builder(
                itemCount: buttonData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1, // 정사각
                ),
                itemBuilder: (context, index) {
                  final item = buttonData[index];
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, item['route']!);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          item['image']!,
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['label']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}