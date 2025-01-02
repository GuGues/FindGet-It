import 'package:flutter/material.dart';

import 'lostPage.dart';

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
      routes: {
        '/lost': (context) => LostPage(),
        //'/found': (context) => lostPage(),
        //'/faq': (context) => lostPage(),
        //'/cs': (context) => lostPage(),
        //'/policeFound': (context) => lostPage(),
        //'/getTalk': (context) => lostPage(),
      },
    );
  }
}

/// 검색창 + 버튼 Grid 페이지
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 새로 사용할 아이콘/텍스트 목록
  final List<Map<String, String>> buttonData = [
    {"label": "분실물 게시판", "route": "/lost", "image": "assets/icon/lost_orange.png"},
    {"label": "습득물 게시판", "route": "/found", "image": "assets/icon/find_orange.png"},
    {"label": "FAQ", "route": "/faq", "image": "assets/icon/faq_orange.png"},
    {"label": "공지 사항", "route": "/cs", "image": "assets/icon/speaker_orange.png"},
    {"label": "경찰청 습득물", "route": "/policeFound", "image": "assets/icon/lost112_orange.png"},
    {"label": "Get 톡", "route": "/getTalk", "image": "assets/icon/get_talk_orange.png"},
    // 필요하다면 더 추가...
  ];

  // 검색어를 저장할 State 변수
  String _searchText = '';

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
            // 검색창
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchText = value; // 검색어 State에 저장
                      });
                    },
                    decoration: InputDecoration(
                      labelText: '검색',
                      hintText: '검색어를 입력하세요',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // 검색 로직 등
                    debugPrint('검색어: $_searchText');
                  },
                  child: const Text('찾기'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 2~n X m 형태의 아이콘 그리드
            Expanded(
              child: GridView.builder(
                itemCount: buttonData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,     // 한 줄에 2개씩
                  crossAxisSpacing: 10,  // 가로 간격
                  mainAxisSpacing: 10,   // 세로 간격
                  childAspectRatio: 1,   // 정사각형 형태 (1:1)
                ),
                itemBuilder: (context, index) {
                  final item = buttonData[index];
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, item['route']!);
                      // TODO: 실제 라우트 이동 등 로직
                      // Navigator.pushNamed(context, item['route']!);
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
                          width: 80, // 이미지 크기
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