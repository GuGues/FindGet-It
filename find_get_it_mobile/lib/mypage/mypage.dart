import 'dart:collection';

import 'package:find_get_it_mobile/appConfig.dart';
import 'package:find_get_it_mobile/views/lostViews.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../appConfig.dart';
import '../foundPage.dart';
import '../global.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class Member {
  final String email;
  final String nickname;
  final String password;
  final String username;
  final String birth;
  final String phone;
  final String memIdx;
  final String address1;
  final String address2;
  final int postnumber;
  final String comDate;

  Member({
    required this.email,
    required this.nickname,
    required this.password,
    required this.username,
    required this.birth,
    required this.phone,
    required this.memIdx,
    required this.address1,
    required this.address2,
    required this.postnumber,
    required this.comDate,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      email: json['email'] ?? '',
      nickname: json['nickname'] ?? '',
      password: json['password'] ?? '',
      username: json['username'] ?? '',
      birth: json['birth'] ?? '',
      phone: json['phone'] ?? '',
      memIdx: json['memIdx'] ?? '',
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      postnumber: json['postnumber'] ?? 0,
      comDate: json['comDate'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Member(email: $email, nickname: $nickname, username: $username, birth: $birth, phone: $phone)';
  }
}

Future<Member> fetchItems() async {
  final String url =
      appConfig.url + '/app/lostInsert/' + GlobalState.loginEmail;
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // 서버에서 받은 JSON 데이터를 파싱하여 Member 객체로 변환
    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    if (data['email'] == null) {
      throw Exception('Invalid JSON: Member data is missing or malformed');
    }
    print(data);
    return Member.fromJson(data);
  } else {
    throw Exception('Failed to load member: ${response.statusCode}');
  }
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nicknameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('마이 페이지'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<Member>(
        future: fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final member = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80.0,0,40.0,0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Text(member.nickname),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('내정보 수정'),
                                      Text('>'),
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(member.email),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context,"/myFound");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[300],
                            padding: EdgeInsets.fromLTRB(32.0,0,32.0,0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('나의 습득물'),
                            Text('>'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context,"/myLost");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[300],
                            padding: EdgeInsets.fromLTRB(32.0, 0, 32.0, 0)),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('나의 분실물'),
                            Text('>'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context,"/myCs");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[300],
                            padding: EdgeInsets.fromLTRB(32.0, 0, 32.0, 0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('나의 문의글'),
                            Text('>'),
                          ],
                        ),
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
