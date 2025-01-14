// lib/main.dart

import 'package:flutter/material.dart';
import 'chatting_room.dart';
import 'chatting.dart';
import 'lostPage.dart';
import 'searchResultPage.dart';
import 'login_page.dart';
import 'global.dart';
import 'faqPage.dart';
import 'noticePage.dart';
import 'views/lostViews.dart';

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
      theme: ThemeData(primarySwatch: Colors.orange),
      // 홈화면
      home: const HomePage(),
      // 라우트 등록
      routes: {
        // 분실물 페이지
        '/login': (context) => const LoginPage(),
        //'/join': (context) => const JoinPage(),
        '/main': (context) => const HomePage(),
        '/lost': (context) => const LostPage(),
// 분실물 상세 페이지
        '/lostViews': (context) => const LostViewsPage(lostIdx: '',),
        // 습득물, FAQ, CS, Police, GetTalk 등은 필요 시 구현
        // '/found': (context) => const FoundPage(),
         '/faq': (context) => const FaqPage(),
        // '/cs': (context) => const CsPage(),
         '/notice': (context) => const NoticePage(),
        // '/policeFound': (context) => const PoliceFoundPage(),
        '/getTalk': (context) => const GetTalkPage(),
        '/getTalkDetail': (context) => const GetTalkDetailPage(),
        // 검색결과 페이지
        '/searchResult': (context) => const SearchResultPage(),

        // 로그인 페이지
        '/login': (context) => const LoginPage(),
      },
    );
  }
}

// lib/home_page.dart

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 메뉴 목록
  final List<Map<String, String>> buttonData = [
    {
      "label": "분실물 게시판",
      "route": "/lost",
      "image": "assets/icon/lost_orange.png"
    },
    {
      "label": "습득물 게시판",
      "route": "/found",
      "image": "assets/icon/find_orange.png"
    },
    {"label": "FAQ", "route": "/faq", "image": "assets/icon/faq_orange.png"},
    {
      "label": "공지 사항",
      "route": "/notice",
      "image": "assets/icon/speaker_orange.png"
    },
    {
      "label": "경찰청 습득물",
      "route": "/policeFound",
      "image": "assets/icon/lost112_orange.png"
    },
    {
      "label": "Get 톡",
      "route": "/getTalk",
      "image": "assets/icon/get_talk_orange.png"
    },
  ];

  /// 검색어
  String _searchText = '';

  /// 검색 로직
  void _doSearch() {
    if (!GlobalState.isLoggedIn) {
      // 로그인 상태가 아니면 로그인 페이지로 이동
      Navigator.pushNamed(context, '/login');
      return;
    }
    // 로그인 상태라면 검색결과 페이지로 이동
    Navigator.pushNamed(context, '/searchResult', arguments: _searchText);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('홈 화면 예시'),
          actions: [
            // 임시: 로그인/로그아웃 상태 확인용 아이콘
            IconButton(
              icon: Icon(GlobalState.isLoggedIn ? Icons.logout : Icons.login),
              onPressed: () {
                // 로그아웃 → 로그인 상태 해제
                if (GlobalState.isLoggedIn) {
                  setState(() {
                    GlobalState.isLoggedIn = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('로그아웃되었습니다.')),
                  );
                } else {
                  // 로그인 페이지로 이동
                  Navigator.pushNamed(context, '/login');
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              //

              //

              //

              //

              // 검색창
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
                          onPressed: _doSearch,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  // 기존 '찾기' 버튼 제거
                ],
              ),
              const SizedBox(height: 20),

              // 2열 그리드
              Expanded(
                child: GridView.builder(
                  itemCount: buttonData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 가로 2개
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1, // 정사각형
                  ),
                  itemBuilder: (context, index) {
                    final item = buttonData[index];
                    return ElevatedButton(
                      onPressed: () {
                        if (!GlobalState.isLoggedIn) {
                          // 로그인 안 되어 있으면 로그인 페이지로 이동
                          Navigator.pushNamed(context, '/login');
                          return;
                        }
                        // 로그인 상태라면 해당 라우트로 이동
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
      ),
    );
  }
}
