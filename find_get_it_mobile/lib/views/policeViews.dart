import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../appConfig.dart';         // 여기에 serverUrl 정의됨
import '../policeVo.dart';         // PoliceItem 정의됨

class PoliceViewsPage extends StatefulWidget {
  final String atcId;
  final String fdsn;

  const PoliceViewsPage({
    Key? key,
    required this.atcId,
    required this.fdsn,
  }) : super(key: key);

  @override
  State<PoliceViewsPage> createState() => _PoliceViewsPageState();
}

class _PoliceViewsPageState extends State<PoliceViewsPage> {
  late Future<PoliceItem> _futurePolice;

  // 반드시 http://IP:포트 형식이어야 함 (예: "http://192.168.0.214:9090")
  final String serverUrl = appConfig.url;

  @override
  void initState() {
    super.initState();
    _futurePolice = fetchPolice(widget.atcId, widget.fdsn);
  }

  /// 경찰 습득물 상세 API 호출
  Future<PoliceItem> fetchPolice(String id, String fdsn) async {
    // 예) GET  http://.../app/getPoliceItem/{atcId}/{fdsn}
    final uri = Uri.parse('$serverUrl/app/getPoliceItem/$id/$fdsn');
    print('=====> Fetching PoliceItem: $uri'); // [디버깅]

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return PoliceItem.fromJson(data);
    } else {
      throw Exception('Failed to load PoliceItem (status=${response.statusCode})');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("경찰 습득물 상세"),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<PoliceItem>(
        future: _futurePolice,
        builder: (context, snapshot) {
          // 1) 로딩중
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2) 에러
          if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          }
          // 3) 데이터 없음
          if (!snapshot.hasData) {
            return const Center(child: Text('데이터가 없습니다.'));
          }

          // 4) 정상 데이터
          final item = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 물품명
                Text(
                  "물품명: ${item.fdPrdtNm}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // 소속기관
                Text(
                  "소속 기관: ${item.depPlace}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),

                // 이미지 섹션
                _buildImageSection(item.fdFilePathImg),

                const SizedBox(height: 16),

                // 기타 정보
                _buildInfoRow("접수일", item.fdYmd),
                _buildInfoRow("물품분류", item.prdtClNm),
                _buildInfoRow("물품색상", item.clrNm),
                _buildInfoRow("접수번호 (atcId)", item.atcId),
                _buildInfoRow("등록일", item.regDate),

                const SizedBox(height: 16),
                const Text(
                  "상세내용:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                Text(item.fdSbjt, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("목록"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 공통 정보 표시 위젯
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  /// 이미지 섹션
  Widget _buildImageSection(String imagePath) {
    // Lost112 표준 "img02_no_img.gif" 주소인 경우 -> 로컬 noimg 사용
    if (imagePath == 'https://www.lost112.go.kr/lostnfs/images/sub/img02_no_img.gif') {
      return Image.asset(
        'assets/icon/noimg.png',
        height: 400,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    // (1) 절대경로(http...)
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
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
    // (2) 상대경로 (DB에만 있는 파일경로) -> 서버 imgView 사용
    else if (imagePath.isNotEmpty) {
      final fullUrl = '$serverUrl/imgView?filePath=$imagePath';
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
    // (3) 완전 빈값이면 noimg
    else {
      return Image.asset(
        'assets/icon/noimg.png',
        height: 400,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }
}