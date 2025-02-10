import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../appConfig.dart';
import '../models.dart'; // LostItem 모델

class LostViewsPage extends StatefulWidget {
  final String lostIdx;
  const LostViewsPage({Key? key, required this.lostIdx}) : super(key: key);

  @override
  State<LostViewsPage> createState() => _LostViewsPageState();
}

class _LostViewsPageState extends State<LostViewsPage> {
  late Future<Map<String, dynamic>> _futureLost;

  /// 데이터 API 호출용 서버 주소
  final String serverUrl = appConfig.url;

  /// 이미지 표시용 서버 주소
  final String imageServerUrl = "http://192.168.0.214:9090";

  @override
  void initState() {
    super.initState();
    _futureLost = fetchLost(widget.lostIdx);
  }

  /// 분실물 상세 데이터 가져오기
  Future<Map<String, dynamic>> fetchLost(String idx) async {
    final uri = Uri.parse('$serverUrl/app/getLostItem/$idx');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final rootJson = json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      // Debugging JSON 전체 확인
      print('===== LostItem JSON Debug =====');
      print(rootJson);
      print('================================');
      return rootJson; // 전체 JSON 반환
    } else {
      throw Exception('Failed to load LostItem (status=${response.statusCode})');
    }
  }

  /// 공통 버튼 스타일
  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF914B),
    );
  }

  /// 라벨+값 형태로 표시
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
        title: const Text("분실물 상세"),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureLost,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('데이터가 없습니다.'));
          } else {
            final data = snapshot.data!;
            final lostItemJson = data['lostItem'] as Map<String, dynamic>;
            final filePath = data['filePath'] as String?;
            final item = LostItem.fromJson(lostItemJson);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "제목: ${item.lostTitle}",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "작성자 닉네임: ${item.nickname}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  _buildImageSection(filePath),
                  const SizedBox(height: 16),
                  _buildInfoRow("분실일", item.lostDate),
                  _buildInfoRow("물품분류", item.itemName),
                  _buildInfoRow("물품세부분류", item.lItemDetail),
                  _buildInfoRow("물품색상", item.colorName),
                  _buildInfoRow(
                    "지역",
                    "${item.sidoName} ${item.gugunName} ${item.lLocationDetail}",
                  ),
                  _buildInfoRow("사례금", "${item.reward}원"),
                  _buildInfoRow("조회수", "${item.lViews}회"),
                  const SizedBox(height: 16),
                  const Text(
                    "내용:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(item.lostContent, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: _buttonStyle(),
                        onPressed: () {
                          // TODO: 채팅
                        },
                        child: const Text("1대1 채팅 보내기"),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: _buttonStyle(),
                        onPressed: () {
                          // TODO: 처리현황
                        },
                        child: const Text("분실물 처리현황"),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: _buttonStyle(),
                        onPressed: () {
                          // TODO: 지도보기
                        },
                        child: const Text("지도에 분실위치 보기"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("목록"),
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