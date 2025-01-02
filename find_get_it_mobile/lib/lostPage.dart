import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Lost {
  final String lostIdx;
  final String email;
  final String lostTitle;
  final String lostContent;
  final String lostDate;
  final String regDate;
  final int views;
  final int locationCode;
  final String locationDetail;
  final int itemCode;
  final String itemDetail;
  final int reward;
  final int colorCode;
  final int lostState;
  final String location;

  Lost({
    required this.lostIdx,
    required this.email,
    required this.lostTitle,
    required this.lostContent,
    required this.lostDate,
    required this.regDate,
    required this.views,
    required this.locationCode,
    required this.locationDetail,
    required this.itemCode,
    required this.itemDetail,
    required this.reward,
    required this.colorCode,
    required this.lostState,
    required this.location,
  });

  // JSON을 Dart 객체로 변환하는 메서드
  factory Lost.fromJson(Map<String, dynamic> json) {
    return Lost(
      lostIdx: json['lost_idx'] ?? '',
      email: json['email'] ?? '',
      lostTitle: json['lost_title'] ?? '',
      lostContent: json['lost_content'] ?? '',
      lostDate: json['lost_date'] ?? '',
      regDate: json['l_reg_date'] ?? '',
      views: json['l_views'] ?? 0,
      locationCode: json['location_code'] ?? 0,
      locationDetail: json['l_location_detail'] ?? '',
      itemCode: json['item_code'] ?? 0,
      itemDetail: json['l_item_detail'] ?? '',
      reward: json['reward'] ?? 0,
      colorCode: json['color_code'] ?? 0,
      lostState: json['lost_state'] ?? 0,
      location: json['location'] ?? '',
    );
  }
}

// API 호출 함수
Future<List<Lost>> fetchItems() async {
  //final response = await http.get(Uri.parse('http://192.168.100.23:9090/app/lostList'));  //보경
  final response = await http.get(Uri.parse('http://192.168.100.18:9090/app/lostList'));    //규황

  if (response.statusCode == 200) {
    // 서버에서 받은 JSON 데이터를 파싱해서 List<Lost>로 변환
    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    // 데이터를 받자마자 콘솔에 출력
    print(data);

    return data.map((json) => Lost.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}

class LostPage extends StatelessWidget {
  const LostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('분실물 게시판'),
        backgroundColor: Colors.orange,
        actions: [
          // PopupMenuButton을 사용한 메뉴 추가
          PopupMenuButton<int>(
            onSelected: (item) {
              switch (item) {
                case 1:
                  print("Menu item 1 selected");
                  // Menu item 1 클릭 시 처리할 내용
                  break;
                case 2:
                  print("Menu item 2 selected");
                  // Menu item 2 클릭 시 처리할 내용
                  break;
                case 3:
                  print("Menu item 3 selected");
                  // Menu item 3 클릭 시 처리할 내용
                  break;
                case 4:
                  print("Menu item 3 selected");
                  // Menu item 3 클릭 시 처리할 내용
                  break;
                case 5:
                  print("Menu item 3 selected");
                  // Menu item 3 클릭 시 처리할 내용
                  break;
                case 6:
                  print("Menu item 3 selected");
                  // Menu item 3 클릭 시 처리할 내용
                  break;
                default:
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<int>(
                value: 1,
                child: Text("분실물 게시판"),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text("습득물 게시판"),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Text("FAQ"),
              ),
              PopupMenuItem<int>(
                value: 4,
                child: Text("공지사항"),
              ),
              PopupMenuItem<int>(
                value: 5,
                child: Text("경찰청 습득물"),
              ),
              PopupMenuItem<int>(
                value: 6,
                child: Text("Get! 톡"),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Lost>>(
        future: fetchItems(),  // fetchItems() 함수에서 API 호출
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());  // 로딩 화면
          } else if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));  // 에러 처리
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('데이터가 없습니다.'));  // 데이터가 없을 때
          } else {
            final items = snapshot.data!;  // 받아온 Lost 리스트
            print("Items Loaded: $items");  // 데이터를 받아온 후 출력

            // ListView로 아이템 표시
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.lostTitle),
                  subtitle: Text(item.lostContent),
                  onTap: () {
                    // 아이템 클릭 시 처리
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LostDetailPage(item: item),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class LostDetailPage extends StatelessWidget {
  final Lost item;

  const LostDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.lostTitle),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('분실물 내용: ${item.lostContent}'),
            Text('위치: ${item.location}'),
            Text('보상금: ${item.reward}'),
            // 다른 항목들 추가 가능
          ],
        ),
      ),
    );
  }
}
