import 'package:flutter/material.dart';
import '../models/found_item.dart';
import '../helpers/common_widgets.dart';

class FoundDetailPage extends StatelessWidget {
  final FoundItem item;
  final String serverUrl;

  const FoundDetailPage({
    Key? key,
    required this.item,
    required this.serverUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("습득물 상세"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
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
            _buildInfoRow("습득일", item.foundDate),
            _buildInfoRow("물품분류", item.itemName),
            _buildInfoRow("물품색상", item.colorName),
            _buildInfoRow("지역", "${item.sidoName} ${item.gugunName}"),
            const SizedBox(height: 16),
            const Text(
              "내용:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(item.foundContent, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}