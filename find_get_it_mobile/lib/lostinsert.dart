import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'appConfig.dart';
import 'foundPage.dart';
import 'global.dart';

class LostInsertPage extends StatefulWidget {
  const LostInsertPage({Key? key}) : super(key: key);

  @override
  _LostInsertPageState createState() => _LostInsertPageState();
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

class _LostInsertPageState extends State<LostInsertPage> {
  insertLost() async {
    print(_selectedImage?.path);
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(_selectedImage!.path),
      'email':GlobalState.loginEmail,
      'itemCode': item_code.toString(),
      'locationCode': location_code.toString(),
      'colorCode': color_code.toString(),
      'lostDate': lost_date.toString().substring(0,10),
      'lostTitle': lost_titleController.text,
      'lostContent': lost_contentController.text,
      'reward': rewardController.text,
      'lLocationDetail': l_location_detailController.text,
    });
    var dio = new Dio();
    try {
      dio.options.contentType = 'multipart/form-data';
      dio.options.maxRedirects.isFinite;

      var response = await dio.post(
        appConfig.url + '/app/lostInsert/insert',
        data: formData,
      );
      print('성공적으로 업로드했습니다');
      return response.data;
    } catch (e) {
      print(e);
    }
/*    var uri = Uri.parse(appConfig.url + '/app/lostInsert/insert-post');
    final response = await http.post(uri,
        headers: <String, String>{'Content-Type': 'multipart/form-data'},
        body: jsonEncode(<String, String>{
          'item_code': item_code.toString(),
          'location_code': location_code.toString(),
          'color_code': color_code.toString(),
          'lost_date': lost_date.toString(),
          'lost_title': lost_titleController.text,
          'lost_content': lost_contentController.text,
          'reward': rewardController.text,
          'l_location_detail': l_location_detailController.text,
        }));
    if (response.statusCode == 200) {
      // 서버에서 받은 JSON 데이터를 파싱
    } else {
      throw Exception('Failed to load fetchRoom');
    }*/
  }

  //이미지 선택기
  final ImagePicker _picker = ImagePicker();

  bool _isLoading = false;
  int page = 1;
  late int pageCnt;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController lost_titleController = TextEditingController();
  TextEditingController lost_contentController = TextEditingController();
  TextEditingController l_location_detailController = TextEditingController();
  TextEditingController rewardController = TextEditingController();
  TextEditingController l_item_detailController = TextEditingController();
  String selectedCategory = '물품 카테고리';
  String selectedLocation = '장소';
  String selectedColor = '색상';
  String selectedStartDate = '시작일';
  String selectedEndDate = '종료일';
  var lost_title = '';
  var lost_content = '';
  var l_item_detail = '';
  var reward = 0;
  var item_code = 0;
  var location_code = 0;
  var l_location_detail = '';
  var start_date = '';
  var end_date = '';
  var color_code = 0;

  final _formKey = GlobalKey<FormState>();
  DateTime? lost_date;
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    TextEditingController nicknameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('분실물 의뢰'),
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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '닉네임 : ' + member.nickname,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '연락처 : ' + member.phone,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            '분실물명',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: lost_titleController,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                border: OutlineInputBorder(),
                                hintText: '물품명을 입력하세요',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "물품상세정보",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: l_item_detailController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: '내용',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      // 물품 카테고리 선택
                      Row(
                        children: [
                          Text(
                            '물품 카테고리',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () async {
                              final response = await http.get(
                                  Uri.parse('${appConfig.url}/getBigCate'));
                              final List<dynamic> jsonResponse =
                                  jsonDecode(utf8.decode(response.bodyBytes));
                              final bigCateList = jsonResponse
                                  .map((item) => cate.fromJson(item))
                                  .toList();

                              // 모달 바텀 시트 호출
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (var bigCate in bigCateList)
                                          ListTile(
                                            title: Text(bigCate.item),
                                            onTap: () async {
                                              print(bigCate.item_code);
                                              final response = await http.get(
                                                  Uri.parse(
                                                      '${appConfig.url}/getCate?item_code=${bigCate.item_code}'));
                                              final List<dynamic> jsonResponse =
                                                  jsonDecode(utf8.decode(
                                                      response.bodyBytes));
                                              final cateList = jsonResponse
                                                  .map((item) =>
                                                      cate.fromJson(item))
                                                  .toList();

                                              showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          for (var cate
                                                              in cateList)
                                                            ListTile(
                                                              title: Text(
                                                                  cate.item),
                                                              onTap: () {
                                                                print(cate
                                                                    .item_code);
                                                                item_code = cate
                                                                    .item_code;
                                                                setState(() {
                                                                  selectedCategory =
                                                                      cate.item;
                                                                });
                                                                Navigator.pop(
                                                                    context); //소분류닫기
                                                                Navigator.pop(
                                                                    context); //대분류닫기
                                                              },
                                                            )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(selectedCategory),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black54,
                              backgroundColor: Colors.orangeAccent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedCategory = "물품카테고리";
                                item_code = 0;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.remove_circle_outline),
                                Text(" 삭제"),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black54,
                              backgroundColor: Colors.orangeAccent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 5),
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            '장소',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () async {
                              final response = await http.get(
                                  Uri.parse('${appConfig.url}/getLocationBig'));
                              final List<dynamic> jsonResponse =
                                  jsonDecode(utf8.decode(response.bodyBytes));
                              final bigLocationList = jsonResponse
                                  .map((item) => bigLocation.fromJson(item))
                                  .toList();
                              print(bigLocationList);

                              // 모달 바텀 시트 호출
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (var bigLocation in bigLocationList)
                                          ListTile(
                                            title: Text(bigLocation.sido_name),
                                            onTap: () async {
                                              setState(() {
                                                selectedLocation =
                                                    bigLocation.sido_name;
                                              });
                                              print(bigLocation.location_code);
                                              selectedLocation =
                                                  bigLocation.sido_name;
                                              final response = await http.get(
                                                  Uri.parse(
                                                      '${appConfig.url}/getLocationMiddle?location_code=${bigLocation.location_code}'));
                                              final List<dynamic> jsonResponse =
                                                  jsonDecode(utf8.decode(
                                                      response.bodyBytes));
                                              final locationList = jsonResponse
                                                  .map((item) =>
                                                      location.fromJson(item))
                                                  .toList();

                                              showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          for (var location
                                                              in locationList)
                                                            ListTile(
                                                              title: Text(location
                                                                  .gugun_name),
                                                              onTap: () {
                                                                print(location
                                                                    .location_code);
                                                                location_code =
                                                                    location
                                                                        .location_code;
                                                                setState(() {
                                                                  selectedLocation += ' ' +
                                                                      location
                                                                          .gugun_name;
                                                                });
                                                                Navigator.pop(
                                                                    context); //소분류닫기
                                                                Navigator.pop(
                                                                    context); //대분류닫기
                                                              },
                                                            )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(selectedLocation),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black54,
                              backgroundColor: Colors.orangeAccent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedLocation = "장소";
                                location_code = 0;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.remove_circle_outline),
                                Text("삭제"),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black54,
                              backgroundColor: Colors.orangeAccent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 5),
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "상세분실장소",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: l_location_detailController,
                              decoration: InputDecoration(
                                labelText: 'ex) 서면 gs편의점',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // 색상 선택
                      Row(
                        children: [
                          Text(
                            '색상',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () async {
                              final response = await http
                                  .get(Uri.parse('${appConfig.url}/getColor'));
                              final List<dynamic> jsonResponse =
                                  jsonDecode(utf8.decode(response.bodyBytes));
                              final colorList = jsonResponse
                                  .map((item) => color.fromJson(item))
                                  .toList();
                              // 모달 바텀 시트 호출
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (var color in colorList)
                                          ListTile(
                                            title: Text(color.color_name),
                                            onTap: () async {
                                              print(color.color_code);
                                              color_code = color.color_code;
                                              setState(() {
                                                selectedColor =
                                                    color.color_name;
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(selectedColor),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black54,
                              backgroundColor: Colors.orangeAccent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              textStyle: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedColor = "색상";
                                color_code = 0;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.remove_circle_outline),
                                Text(" 삭제"),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black54,
                              backgroundColor: Colors.orangeAccent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 5),
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "분실일자",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: '분실일자',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    lost_date = pickedDate;
                                  });
                                }
                              },
                              controller: TextEditingController(
                                text: lost_date == null
                                    ? ''
                                    : "${lost_date!.year}-${lost_date!.month.toString().padLeft(2, '0')}-${lost_date!.day.toString().padLeft(2, '0')}",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            '금액',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: rewardController,
                              decoration: InputDecoration(
                                labelText: '선택사항',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _selectedImage == null
                                ? Text('No image selected.')
                                : Image.file(
                                    File(_selectedImage!.path),
                                    height: 150,
                                    width: 150,
                                  ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () async {
                                XFile? selectImage = await _picker.pickImage(
                                  source: ImageSource.gallery, // 갤러리에서 이미지 선택
                                  maxHeight: 75,
                                  maxWidth: 75,
                                  imageQuality: 30, // 이미지 압축
                                );

                                if (selectImage != null) {
                                  setState(() {
                                    _selectedImage = selectImage;
                                  });
                                }
                              },
                              child: Text('Select Image'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: lost_contentController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: '내용',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              insertLost();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            child: Text('등록'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey),
                            child: Text('취소'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            child: Text('목록'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
