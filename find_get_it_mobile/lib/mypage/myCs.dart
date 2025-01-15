import 'package:find_get_it_mobile/appConfig.dart';
import 'package:find_get_it_mobile/global.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Cs{
  final String cs_idx;
  final String email;
  final String cs_title;
  final String cs_content;
  final String cs_reg_date;
  final String cs_state;
  final String cs_reply;
  Cs({
    required this.cs_idx,
    required this.email,
    required this.cs_title,
    required this.cs_content,
    required this.cs_reg_date,
    required this.cs_state,
    required this.cs_reply
});
  factory Cs.fromJson(Map<String,dynamic> json){
    return Cs(
      cs_idx:json['cs_idx']??'',
      email:json['email']??'',
      cs_title:json['cs_title']??'',
      cs_content:json['cs_content']??'',
      cs_reg_date:json['cs_reg_date']??'',
      cs_state:json['cs_state'].toString()??'',
      cs_reply:json['cs_reply']??''
    );
  }
}

// API 호출 함수
Future<List<Cs>> fetchItems() async {
  //final response = await http.get(Uri.parse('http://192.168.100.23:9090/app/lostList'));  //보경
  final response =
      await http.get(Uri.parse(appConfig.url+'/app/myCs/'+GlobalState.loginEmail)); //규황

  if (response.statusCode == 200) {
    // 서버에서 받은 JSON 데이터를 파싱해서 List<Lost>로 변환
    List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    // 데이터를 받자마자 콘솔에 출력
    print(data);

    return data.map((json) => Cs.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}

class MyCsPage extends StatelessWidget {
  const MyCsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('나의 문의글'),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(
                          "나의 문의",
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 16,
                          ),
                        ),
                          Text(
                            "등록일",
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "상태",
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 16,
                            ),
                          ),
                      ],)),
                ],
              ),
              Expanded(
                child: FutureBuilder<List<Cs>>(
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
                          if(item.cs_state=="2"){
                            String state_name = "처리중";
                            return ListTile(
                                trailing: SizedBox(),
                                title:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Text(
                                  item.cs_title,
                                  style: TextStyle(fontSize: 16),),
                                    Text(
                                      item.cs_reg_date.substring(0,10),
                                      style: TextStyle(fontSize: 16),),
                                    Text(
                                      state_name,
                                      style: TextStyle(fontSize: 16),),
                                  ],
                                ),
                              );
                          }
                          String state_name = "처리완료";
                          return ExpansionTile(
                              trailing: SizedBox(),
                              title:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.cs_title,
                                style: TextStyle(fontSize: 16),),
                              Text(
                                item.cs_reg_date.substring(0,10),
                                style: TextStyle(fontSize: 16),),
                              Text(
                                state_name,
                                style: TextStyle(fontSize: 16),),
                            ],
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
                                        item.cs_reply,
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
