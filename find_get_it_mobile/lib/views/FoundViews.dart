import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../appConfig.dart';
import '../models.dart';

class FoundViewsPage extends StatefulWidget {
  final String foundIdx;
  const FoundViewsPage({Key? key, required this.foundIdx}) : super(key: key);

  @override
  State<FoundViewsPage> createState() => _FoundViewsPageState();
}

class _FoundViewsPageState extends State<FoundViewsPage> {
  late Future<FoundItem> _futureFound;
  final String serverUrl = appConfig.url;

  @override
  void initState() {
    super.initState();
    _futureFound = fetchFound(widget.foundIdx);
  }

  Future<FoundItem> fetchFound(String idx) async {
    final uri = Uri.parse('$serverUrl/app/getFoundItem/$idx');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return FoundItem.fromJson(data);
    } else {
      throw Exception('Failed to load FoundItem');
    }
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF914B),
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
        title: const Text("습득물 상세"),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<FoundItem>(
        future: _futureFound,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('데이터가 없습니다.'));
          } else {
            final item = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목/작성자
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
                  _buildInfoRow("습득일", item.foundDate),
                  _buildInfoRow("물품분류", item.itemName),
                  _buildInfoRow("물품세부분류", item.fItemDetail),
                  _buildInfoRow("물품색상", item.colorName),
                  _buildInfoRow(
                      "지역", "${item.sidoName} ${item.gugunName} ${item.fLocationDetail}"),
                  _buildInfoRow("조회수", "${item.fViews}회"),
                  const SizedBox(height: 16),

                  // 본문 내용
                  const Text("내용:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(item.foundContent, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),

                  // 세로 버튼
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
                        child: const Text("습득물 처리현황"),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: _buttonStyle(),
                        onPressed: () {},
                        child: const Text("지도에 습득위치 보기"),
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
                            // 수정 페이지
                          },
                          child: const Text("수정"),
                        ),
                      if (isAdmin)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {},
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