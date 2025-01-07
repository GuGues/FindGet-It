import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'appConfig.dart';

class Notice {
  String notice_idx;
  String notice_title;
  String notice_content;
  int n_views;
  String n_reg_date;

  Notice(
      {required this.notice_idx,
      required this.notice_title,
      required this.notice_content,
      required this.n_views,
      required this.n_reg_date});

  // JSON을 Dart 객체로 변환하는 메서드
  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
        notice_idx: json['notice_idx'] ?? '',
        notice_title: json['notice_title'] ?? '',
        notice_content: json['notice_content'] ?? '',
        n_views: json['n_views'] ?? '',
        n_reg_date: json['n_reg_date'] ?? '');
  }
}

// API 호출 함수
Future<List<Notice>> fetchItems() async {
  final response = await http
      .get(Uri.parse(appConfig.url+'/app/noticeList')); //광석

  if (response.statusCode == 200) {
    // 서버에서 받은 JSON 데이터를 파싱해서 List<Lost>로 변환
    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    // 데이터를 받자마자 콘솔에 출력
    print(data);

    return data.map((json) => Notice.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('공지사항'),
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
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.orange[300],
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    width: 350,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text(
                      "               제목                                 등록일                ",
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder<List<Notice>>(
                  future: fetchItems(), // fetchItems() 함수에서 API 호출
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator()); // 로딩 화면
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('에러 발생: ${snapshot.error}')); // 에러 처리
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('데이터가 없습니다.')); // 데이터가 없을 때
                    } else {
                      final items = snapshot.data!; // 받아온 Lost 리스트
                      print("Items Loaded: $items"); // 데이터를 받아온 후 출력

                      // ListView로 아이템 표시
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return ExpansionTile(
                              trailing: SizedBox(),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                Text(item.notice_title),
                                Text(item.n_reg_date,style: TextStyle(fontSize: 12),),
                              ],),
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      width: 375,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Text(
                                        item.notice_content,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class LostDetailPage extends StatelessWidget {
  final Notice item;

  const LostDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.notice_title),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
