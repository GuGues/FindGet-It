import 'dart:collection';

import 'package:find_get_it_mobile/appConfig.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Found {
  final String foundIdx;
  final String email;
  final String foundTitle;
  final String foundContent;
  final String foundDate;
  final String regDate;
  final int views;
  final int locationCode;
  final String locationDetail;
  final int itemCode;
  final String itemDetail;
  final int colorCode;
  final int foundState;
  final String location;
  int page = 1;

  Found({
    required this.foundIdx,
    required this.email,
    required this.foundTitle,
    required this.foundContent,
    required this.foundDate,
    required this.regDate,
    required this.views,
    required this.locationCode,
    required this.locationDetail,
    required this.itemCode,
    required this.itemDetail,
    required this.colorCode,
    required this.foundState,
    required this.location,
    required this.page,
  });

  // JSON to Dart object
  factory Found.fromJson(Map<String, dynamic> json) {
    return Found(
      foundIdx: json['found_idx'] ?? '',
      email: json['email'] ?? '',
      foundTitle: json['found_title'] ?? '',
      foundContent: json['found_content'] ?? '',
      foundDate: json['found_date'] ?? '',
      regDate: json['f_reg_date'] ?? '',
      views: json['f_views'] ?? 0,
      locationCode: json['location_code'] ?? 0,
      locationDetail: json['f_location_detail'] ?? '',
      itemCode: json['item_code'] ?? 0,
      itemDetail: json['f_item_detail'] ?? '',
      colorCode: json['color_code'] ?? 0,
      foundState: json['found_state'] ?? 0,
      location: json['location'] ?? '',
      page: json['page'] ?? 0,
    );
  }
}

class cate {
  final String item;
  final int item_code;

  cate({required this.item, required this.item_code});

  // JSON 파싱을 위한 factory constructor
  factory cate.fromJson(Map<String, dynamic> json) {
    return cate(
      item_code: json['item_code'],
      item: json['item'],
    );
  }
}

class bigLocation {
  final String sido_name;
  final int location_code;

  bigLocation({required this.sido_name, required this.location_code});

  // JSON 파싱을 위한 factory constructor
  factory bigLocation.fromJson(Map<String, dynamic> json) {
    return bigLocation(
      location_code: json['location_code'],
      sido_name: json['sido_name'],
    );
  }
}

class location {
  final String gugun_name;
  final int location_code;

  location({required this.location_code, required this.gugun_name});

  // JSON 파싱을 위한 factory constructor
  factory location.fromJson(Map<String, dynamic> json) {
    return location(
      location_code: json['location_code'],
      gugun_name: json['gugun_name'],
    );
  }
}

class color {
  final String color_name;
  final int color_code;

  color({required this.color_code, required this.color_name});

  // JSON 파싱을 위한 factory constructor
  factory color.fromJson(Map<String, dynamic> json) {
    return color(
      color_code: json['color_code'],
      color_name: json['color_name'],
    );
  }
}

class FoundPage extends StatefulWidget {
  const FoundPage({super.key});

  @override
  _LostPageState createState() => _LostPageState();
}

class _LostPageState extends State<FoundPage> {
  bool _isLoading = false;
  int page = 1;
  late int pageCnt;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  List<Found> foundList =List.empty();
  String selectedCategory = '물품 카테고리';
  String selectedLocation = '장소';
  String selectedColor = '색상';
  String selectedStartDate = '시작일';
  String selectedEndDate = '종료일';

  searchItems(int page) async {
    var params = '';
    if(found_title!=null && found_title.length!=0){
      params += '&found_title=$found_title';
    }if(item_code!=null && item_code!=0){
      params += '&item_code=$item_code';
    }if(location_code!=null && location_code!=0){
      params += '&location_code=$location_code';
    }if(color_code!=null && color_code!=0){
      params += '&color_code=$color_code';
    }if(start_date!=null && start_date.length!=0){
      params += '&start_date=$start_date';
    }if(end_date!=null && end_date.length!=0){
      params += '&end_date=$end_date';
    }
    final response = await http.get(
        Uri.parse('${appConfig.url}/app/getFoundSearch?page=$page$params'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> searchFoundList = data["searchFound"];
      print(data);
      setState(() {
        pageCnt = data["pageCnt"];
        foundList = searchFoundList.map((json) => Found.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load items');
    }
  }

  fetchItem(int page) async {
    setState(() {
      _isLoading = true;
    });
    final response =
    await http.get(Uri.parse('${appConfig.url}/app/foundList?page=$page'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      print(data);
      List<dynamic> getFoundList = data["foundList"];
      setState(() {
        pageCnt = data["pageCnt"];
        foundList= getFoundList.map((json) => Found.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load items');
    }
    setState(() {
      _isLoading = false;
    });
  }


  @override void initState() {
    super.initState();
    fetchItem(1);
  }

  var found_title = '';
  var item_code = 0;
  var location_code = 0;
  var start_date = '';
  var end_date = '';
  var color_code = 0;

  // Date picker method
  Future<void> _selectStartDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        controller.text =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      });
      start_date = controller.text;
    }
  }

  Future<void> _selectEndDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        controller.text =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      });
      end_date = controller.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 로딩중
    if (_isLoading) {
      return Scaffold(
        appBar:
        AppBar(title: Text(""), backgroundColor: Colors.orange),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    // 정상
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '습득물 게시판',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFFFA042),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) {
              switch (item) {
                case 1:
                  Navigator.pushNamed(context, '/lost');
                  break;
                default:
                  print("Menu item $item selected");
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<int>(value: 1, child: Text("분실물 게시판")),
              PopupMenuItem<int>(value: 2, child: Text("습득물 게시판")),
              PopupMenuItem<int>(value: 3, child: Text("FAQ")),
              PopupMenuItem<int>(value: 4, child: Text("공지사항")),
              PopupMenuItem<int>(value: 5, child: Text("경찰청 습득물")),
              PopupMenuItem<int>(value: 6, child: Text("Get! 톡")),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            // Make the whole page scrollable
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(30.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 15.0),
                    // margin 줄이기
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 물품명 입력
                        Row(
                          children: [
                            Text(
                              '물품명',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: titleController,
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
                        SizedBox(height: 8),

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
                                                final List<dynamic>
                                                jsonResponse =
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
                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // 분실 장소 선택
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
                                final response = await http.get(Uri.parse(
                                    '${appConfig.url}/getLocationBig'));
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
                                          for (var bigLocation
                                          in bigLocationList)
                                            ListTile(
                                              title:
                                              Text(bigLocation.sido_name),
                                              onTap: () async {
                                                setState(() {
                                                  selectedLocation =
                                                      bigLocation.sido_name;
                                                });
                                                print(
                                                    bigLocation.location_code);
                                                selectedLocation =
                                                    bigLocation.sido_name;
                                                final response = await http.get(
                                                    Uri.parse(
                                                        '${appConfig.url}/getLocationMiddle?location_code=${bigLocation.location_code}'));
                                                final List<dynamic>
                                                jsonResponse =
                                                jsonDecode(utf8.decode(
                                                    response.bodyBytes));
                                                final locationList =
                                                jsonResponse
                                                    .map((item) => location
                                                    .fromJson(item))
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
                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

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
                                final response = await http.get(
                                    Uri.parse('${appConfig.url}/getColor'));
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
                                textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),

                        // 분실 날짜 선택 (시작일과 종료일)
                        Row(
                          children: [
                            Text(
                              '습득일',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: startDateController,
                                readOnly: true, // 텍스트 입력 방지
                                decoration: InputDecoration(
                                  hintText: '시작일',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                onTap: () {
                                  _selectStartDate(
                                      context, startDateController);
                                },
                              ),
                            ),
                            SizedBox(width: 8),
                            Text('~', style: TextStyle(fontSize: 14)),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: endDateController,
                                readOnly: true, // 텍스트 입력 방지
                                decoration: InputDecoration(
                                  hintText: '종료일',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                onTap: () {
                                  _selectEndDate(context, endDateController);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        // 검색 버튼
                        Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    setState(() {
                                      found_title = '';
                                      titleController.clear();
                                      item_code = 0;
                                      location_code = 0;
                                      start_date = '';
                                      end_date = '';
                                      startDateController.clear();
                                      endDateController.clear();
                                      color_code = 0;
                                      selectedCategory = '물품 카테고리';
                                      selectedLocation = '장소';
                                      selectedColor = '색상';
                                      selectedStartDate = '시작일';
                                      selectedEndDate = '종료일';
                                    });
                                  },
                                  icon: Icon(Icons.refresh),
                                  label: Text('초기화'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black54,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    backgroundColor: Colors.grey,
                                    textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w800,),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    found_title = titleController.text;
                                    page=1;
                                    searchItems(page);
                                  },
                                  icon: Icon(Icons.search),
                                  label: Text('검색'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    backgroundColor: Colors.orange,
                                    textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w800,),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    )),
                SizedBox(height: 12), // Add spacing between filters and list
                ListView.builder(
                  itemCount: foundList.length,
                  shrinkWrap: true,
                  // Important: Allow ListView to shrink and not take full height
                  itemBuilder: (context, index) {
                    final item = foundList[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(item.foundTitle),
                        subtitle: Text(item.location),
                        onTap: () {

                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 80), // Adjust space for pagination
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            // Keep the pagination button at the bottom of the screen
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (page > 1) {
                        setState(() {
                          page--;
                        });
                        searchItems(page);
                      }
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 16),
                  Text("$page"),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: (page < pageCnt)
                        ? () {
                      setState(() {
                        page++;
                      });
                      searchItems(page);
                    }
                        : null,  // page가 pageCnt와 같을 경우 버튼을 비활성화
                    child: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}