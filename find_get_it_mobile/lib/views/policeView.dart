import 'package:flutter/material.dart';
import '../../models/police_item.dart';

class PoliceDetailPage extends StatelessWidget {
  final PoliceItem item;
  final String serverUrl;

  const PoliceDetailPage({
    Key? key,
    required this.item,
    required this.serverUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("경찰 습득물 상세"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "물품명: ${item.fdPrdtNm}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "소속 기관: ${item.depplace}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            if (item.fdfilepathimg.isNotEmpty)
              Image.network(
                '$serverUrl/imgView?filePath=${item.fdfilepathimg}',
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
            _buildInfoRow("접수일", item.fdymd),
            _buildInfoRow("물품분류", item.prdtclnm),
            _buildInfoRow("물품색상", item.clrnm),
            _buildInfoRow("접수자", item.atcId),
            const SizedBox(height: 16),
            const Text(
              "상세내용:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(item.fdSbjt, style: const TextStyle(fontSize: 16)),
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
