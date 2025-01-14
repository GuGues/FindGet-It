import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../appConfig.dart';
import '../models.dart'; // 위의 models.dart 임포트

class LostViewsPage extends StatefulWidget {
  final String lostIdx;
  const LostViewsPage({Key? key, required this.lostIdx}) : super(key: key);

  @override
  State<LostViewsPage> createState() => _LostViewsPageState();
}

class _LostViewsPageState extends State<LostViewsPage> {
  late Future<LostItem> _futureLost;
  final String serverUrl = appConfig.url;

  @override
  void initState() {
    super.initState();
    _futureLost = fetchLost(widget.lostIdx);
  }

  Future<LostItem> fetchLost(String idx) async {
    final uri = Uri.parse('$serverUrl/app/getLostItem/$idx');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return LostItem.fromJson(data);
    } else {
      throw Exception('Failed to load LostItem');
    }
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF914B), // 예시 색상
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
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isAuthor = true;
    final bool isAdmin = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("분실물 상세"),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<LostItem>(
        future: _futureLost,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 로딩중
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 에러
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            // 데이터 없음
            return const Center(child: Text('데이터가 없습니다.'));
          } else {
            // 데이터 정상
            final item = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목/작성자
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

                  // 이미지
                  if (item.filePath != null && item.filePath!.isNotEmpty)
                    Image.network(
                      '$serverUrl/imgView?filePath=${item.filePath}',
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

                  // 정보
                  _buildInfoRow("분실일", item.lostDate),
                  _buildInfoRow("물품분류", item.itemName),
                  _buildInfoRow("물품세부분류", item.lItemDetail),
                  _buildInfoRow("물품색상", item.colorName),
                  _buildInfoRow("지역",
                      "${item.sidoName} ${item.gugunName} ${item.lLocationDetail}"),
                  _buildInfoRow("사례금", "${item.reward}원"),
                  _buildInfoRow("조회수", "${item.lViews}회"),
                  const SizedBox(height: 16),

                  // 본문 내용
                  const Text("내용:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(item.lostContent, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),

                  // 세로 버튼 (1:1 채팅, 처리현황, 지도)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: _buttonStyle(),
                        onPressed: () {},
                        child: const Text("1대1 채팅 보내기"),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: _buttonStyle(),
                        onPressed: () {},
                        child: const Text("분실물 처리현황"),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: _buttonStyle(),
                        onPressed: () {},
                        child: const Text("지도에 분실위치 보기"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 목록/수정/블라인드
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("목록"),
                      ),
                      if (isAuthor)
                        ElevatedButton(
                          onPressed: () {
                            // 수정 페이지 이동
                          },
                          child: const Text("수정"),
                        ),
                      if (isAdmin)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {
                            // 블라인드 로직
                          },
                          child: const Text("블라인드"),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}