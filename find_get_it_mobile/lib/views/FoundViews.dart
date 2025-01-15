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
  late Future<Map<String, dynamic>> _futureFound;

  /// 데이터 서버 주소
  final String serverUrl = appConfig.url;

  /// 이미지 표시용 서버 주소
  final String imageServerUrl = "http://192.168.0.214:9090";

  @override
  void initState() {
    super.initState();
    _futureFound = fetchFound(widget.foundIdx);
  }

  /// 습득물 상세 데이터 가져오기
  Future<Map<String, dynamic>> fetchFound(String idx) async {
    final uri = Uri.parse('$serverUrl/app/getFoundItem/$idx');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final rootJson = json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (rootJson.isEmpty) {
        throw Exception('Response is empty');
      }
      print('===== FoundItem JSON Debug =====');
      print(rootJson);
      print('================================');
      return rootJson;
    } else {
      throw Exception('Failed to load FoundItem (status=${response.statusCode})');
    }
  }

  /// 공통 버튼 스타일
  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF914B),
    );
  }

  /// 라벨 + 값 형태로 표시
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

  /// 이미지 섹션
  Widget _buildImageSection(String? filePath) {
    if (filePath == null || filePath.isEmpty || filePath.contains("img02_no_img.gif")) {
      return Image.asset(
        'assets/icon/noimg.png',
        height: 400,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    final fullUrl = '$imageServerUrl/imgView?filePath=$filePath';

    return Image.network(
      fullUrl,
      height: 400,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/icon/noimg.png',
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("습득물 상세"),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureFound,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('데이터가 없습니다.'));
          } else {
            final data = snapshot.data!;
            final foundItemJson = data['foundItem'] as Map<String, dynamic>? ?? {};
            final filePath = data['filePath'] as String? ?? '';

            if (foundItemJson.isEmpty) {
              return const Center(child: Text('데이터를 찾을 수 없습니다.'));
            }

            final item = FoundItem.fromJson(foundItemJson);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  _buildImageSection(filePath),
                  const SizedBox(height: 16),

                  // 정보
                  _buildInfoRow("습득일", item.foundDate),
                  _buildInfoRow("물품분류", item.itemName),
                  _buildInfoRow("물품세부분류", item.fItemDetail ?? "없음"),
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

                  // 목록 버튼
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("목록"),
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