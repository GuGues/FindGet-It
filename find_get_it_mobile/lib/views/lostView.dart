import 'package:flutter/material.dart';
import '../../models/lost_item.dart';



class LostDetailPage extends StatelessWidget {
  final LostItem item;
  final String serverUrl; // 서버 URL을 외부에서 전달받도록 변경

  const LostDetailPage({
    Key? key,
    required this.item,
    required this.serverUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("분실물 상세"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
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
              "작성자: ${item.nickname}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
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
            _buildInfoRow("분실일", item.lostDate),
            _buildInfoRow("물품분류", item.itemName),
            _buildInfoRow("물품색상", item.colorName),
            _buildInfoRow("지역", "${item.sidoName} ${item.gugunName}"),
            const SizedBox(height: 16),
            const Text(
              "내용:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(item.lostContent, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
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
        Expanded(
          child: Text(value),
        ),
      ],
    ),
  );
}
