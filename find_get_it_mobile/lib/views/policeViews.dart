import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../appConfig.dart';
import '../models.dart';  // PoliceItem

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
  final String serverUrl = appConfig.url;

  @override
  void initState() {
    super.initState();
    _futurePolice = fetchPolice(widget.atcId, widget.fdsn);
  }

  Future<PoliceItem> fetchPolice(String id, String fdsn) async {
    // URL: /app/getPoliceItem/{atcId}/{fdsn}
    final uri = Uri.parse('$serverUrl/app/getPoliceItem/$id/$fdsn');
    print('=====> Fetching PoliceItem: $uri'); // [디버깅]
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      return PoliceItem.fromJson(data);
    } else {
      throw Exception(
          'Failed to load PoliceItem (status=${response.statusCode})');
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('데이터가 없습니다.'));
          }

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

                // 소속 기관
                Text(
                  "소속 기관: ${item.depPlace}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),

                // 이미지
                if (item.fdFilePathImg.isNotEmpty)
                  Image.network(
                    '$serverUrl/imgView?filePath=${item.fdFilePathImg}',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/noimg.png',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
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
                _buildInfoRow("접수일", item.fdYmd),
                _buildInfoRow("물품분류", item.prdtClNm),
                _buildInfoRow("물품색상", item.clrNm),
                _buildInfoRow("접수자", item.atcId),
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
}