import 'package:find_get_it_mobile/appConfig.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Faq {
  String faq_idx;
  String faq_question;
  String faq_answer;
  String faq_reg_date;

  Faq(
      {required this.faq_idx,
      required this.faq_question,
      required this.faq_answer,
      required this.faq_reg_date});

  // JSON을 Dart 객체로 변환하는 메서드
  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
        faq_idx: json['faq_idx'] ?? '',
        faq_question: json['faq_question'] ?? '',
        faq_answer: json['faq_answer'] ?? '',
        faq_reg_date: json['faq_reg_date'] ?? '');
  }
}

// API 호출 함수
Future<List<Faq>> fetchItems() async {
  //final response = await http.get(Uri.parse('http://192.168.100.23:9090/app/lostList'));  //보경
  final response =
      await http.get(Uri.parse(appConfig.url+'/app/faqList')); //규황

  if (response.statusCode == 200) {
    // 서버에서 받은 JSON 데이터를 파싱해서 List<Lost>로 변환
    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    // 데이터를 받자마자 콘솔에 출력
    print(data);

    return data.map((json) => Faq.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FAQ'),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.orange[300],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      width: 350,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                          "자주 묻는 질문",
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],)),
                ],
              ),
              Expanded(
                child: FutureBuilder<List<Faq>>(
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
                              title: Text(
                                item.faq_question,
                                style: TextStyle(fontSize: 16),
                              ),
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
                                        item.faq_answer,
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
  final Faq item;

  const LostDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.faq_question),
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
