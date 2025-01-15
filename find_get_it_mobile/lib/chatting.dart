import 'package:find_get_it_mobile/ChatBubble.dart';
import 'package:find_get_it_mobile/appConfig.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'global.dart';

class RoomInfo {
  final String chatting_no;
  final Map<String, dynamic> room;

  RoomInfo({
    required this.chatting_no,
    required this.room,
  });

  @override
  String toString() {
    print(chatting_no);
    print(room);
    return "OK";
  }

  factory RoomInfo.fromJson(Map<String, dynamic> json) {
    RoomInfo roomInfo = RoomInfo(
        chatting_no: json['chatting_no'] ?? '',
        room: Map<String, dynamic>.from(json['room']));
    return roomInfo;
  }
}

class Chat {
  String message_no;
  String message_content;
  String read_fl;
  String send_time;
  String sender;
  String chatting_no;

  Chat(
      {required this.message_no,
      required this.message_content,
      required this.read_fl,
      required this.send_time,
      required this.sender,
      required this.chatting_no});

  factory Chat.fromJson(Map<String, dynamic> json) {
    Chat chat = Chat(
        message_no: json['message_no'].toString() ?? '',
        message_content: json['message_content'].toString() ?? '',
        read_fl: json['read_fl'].toString() ?? '',
        send_time: json['send_time'].toString() ?? '',
        sender: json['sender'].toString() ?? '',
        chatting_no: json['chatting_no'].toString() ?? '');
    return chat;
  }
}

class GetTalkDetailPage extends StatefulWidget {
  const GetTalkDetailPage({super.key});

  @override
  State<StatefulWidget> createState() => _GetTalkDetailPageState();
}

class _GetTalkDetailPageState extends State<GetTalkDetailPage>
    with SingleTickerProviderStateMixin {
  String _errorMsg = '';
  bool _isLoading = false;
  String _roomIdx = '';
  String open_member = '';
  String participant = '';
  List<Chat> chats = [];
  late RoomInfo roomInfo;
  late StompClient stompClient;
  ScrollController scrollController = ScrollController();




  double lat = 0;
  double lng = 0;
  Location location = new Location();
  bool _serviceEnabled = true;
  late PermissionStatus _permissionGranted;

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((value) {
      setState(() {
        lat = value.latitude!;
        lng = value.longitude!;
        var uri = Uri.parse(appConfig.url + '/app/chatting/update-location');
        if(roomInfo.room['open_member']==GlobalState.loginEmail){
            http.post(uri,
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, String>{
              'chatting_no':_roomIdx,
              'open_member':GlobalState.loginEmail,
              'open_member_permission':'Y',
              'open_member_lat': value.latitude.toString(),
              'open_member_lng': value.longitude.toString(),
            }));
        }else{
          http.post(uri,
              headers: <String, String>{'Content-Type': 'application/json'},
              body: jsonEncode(<String, String>{
                'chatting_no':_roomIdx,
                'participant':GlobalState.loginEmail,
                'participant_permission':'Y',
                'participant_lat': value.latitude.toString(),
                'participant_lng': value.longitude.toString(),
              }));
        }
        Navigator.pushNamed(context, "/map",arguments: _roomIdx);
      });
    });
  }





  fetchRoom(var args) async {
    var uri = Uri.parse(appConfig.url + '/app/roomInfo/' + args);
    final response = await http.get(uri); //광석

    if (response.statusCode == 200) {
      // 서버에서 받은 JSON 데이터를 파싱해서 List<ChattingRoom>로 변환
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        roomInfo = RoomInfo.fromJson(data);
      });
    } else {
      throw Exception('Failed to load fetchRoom');
    }
  }

  fetchChatting(var args) async {
    var uri = Uri.parse(appConfig.url + '/app/get-chatting/' + args);
    final response = await http.get(uri); //광석

    if (response.statusCode == 200) {
      // 서버에서 받은 JSON 데이터를 파싱해서 List<ChattingRoom>로 변환
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        chats = data.map((json) => Chat.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load fetchChatting');
    }
  }

  updateView(var args) async {
    var uri = Uri.parse(appConfig.url + '/app/chatting/update-view');
    final response = await http.post(uri,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'chatting_no': args,
          'email': GlobalState.loginEmail
        })); //광석

    if (response.statusCode == 200) {
      // 서버에서 받은 JSON 데이터를 파싱해서 List<ChattingRoom>로 변환
    } else {
      throw Exception('Failed to load updateView');
    }
  }

  void onConnect(StompClient stompClient, StompFrame frame) {
    stompClient.subscribe(
      destination: '/queue/chat/room/' + _roomIdx.toString(),
      callback: (frame) {
        //List<dynamic>? result = json.decode(frame.body!);
        Map<String, dynamic> obj = json.decode(frame.body!);
        updateView(_roomIdx);
        Chat chat = Chat.fromJson(obj);
        setState(() {
          chats.insert(0, chat);
        });
      },
    );
    stompClient.send(
      destination: '/app/roomList/' + GlobalState.loginEmail, // 전송할 destination
      body: json.encode({
        "chatting_no": _roomIdx.toString(),
        "sender": GlobalState.loginEmail,
        "message_content": "",
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    // 탭: 분실물 / 습득물 / 경찰 습득물
    // 화면 빌드 후 arguments 로부터 검색어 받기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String) {
        fetchRoom(args);
        fetchChatting(args);
        updateView(args);
        setState(() {
          _roomIdx = args;
        });
      } else {
        setState(() {
          _errorMsg = '채팅방을 불러오지 못했습니다';
        });
      }
    });

    stompClient = StompClient(
      config: StompConfig(
          url: 'ws://192.168.0.214:9090/ws-connect',
          onConnect: (frame) => onConnect(stompClient, frame),
          beforeConnect: () async {
            print('waiting to connect...');
            await Future.delayed(const Duration(milliseconds: 200));
            print('connecting...');
          },
          onWebSocketError: (dynamic error) => print(error.toString())
          //stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
          //webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
          ),
    );

    stompClient.activate();
  }

  @override
  void dispose() {
    super.dispose();
    // 웹소켓에서 연결 해제
    stompClient.deactivate();
    // 텍스트 입력 컨트롤러 해제
    textController.dispose();
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appBarTitle = "CHAT";

    // 로딩중
    if (_isLoading) {
      return Scaffold(
        appBar:
            AppBar(title: Text(appBarTitle), backgroundColor: Colors.orange),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    // 에러
    if (_errorMsg.isNotEmpty) {
      return Scaffold(
        appBar:
            AppBar(title: Text(appBarTitle), backgroundColor: Colors.orange),
        body: Center(child: Text(_errorMsg)),
      );
    }
    // 정상
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [
// 채팅 목록을 표시하는 ListView
            Expanded(
              child: ListView.builder(
                reverse: true,
                controller: scrollController,
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  var chat = chats[index];
                  return ChatBubble(chat.message_content, chat.send_time,
                      (chat.sender == GlobalState.loginEmail) ? true : false);
                },
              ),
            ),
// 텍스트 입력 필드와 전송 버튼을 가진 Row
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 300, // 모달 높이 크기
                          decoration: const BoxDecoration(
                            color: Colors.white, // 모달 배경색
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0), // 모달 좌상단 라운딩 처리
                              topRight: Radius.circular(0), // 모달 우상단 라운딩 처리
                            ),
                          ),
                          child: IconButton(
                              onPressed: () {
                                _locateMe();
                              },
                              icon: Icon(Icons.map)), // 모달 내부 디자인 영역
                        );
                      },
                    );
                  },
                ),

// 텍스트 입력 필드
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: '메세지 입력',
                    ),
                  ),
                ),
// 전송 버튼
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
// 텍스트 입력 필드의 내용을 가져옴
                    String message = textController.text;
                    if (message.isNotEmpty) {
// destination에 메시지 전송
                      stompClient.send(
                        destination: '/app/chat/' + _roomIdx.toString(),
                        // 전송할 destination
                        body: json.encode({
                          "chatting_no": _roomIdx.toString(),
                          "sender": GlobalState.loginEmail,
                          "message_content": message,
                        }), // 메시지의 내용
                      );
                      stompClient.send(
                        destination: '/app/roomList/' +
                            roomInfo.room['open_member'], // 전송할 destination
                        body: json.encode({
                          "chatting_no": _roomIdx.toString(),
                          "sender": GlobalState.loginEmail,
                          "message_content": message,
                        }), // 메시지의 내용
                      );
                      stompClient.send(
                        destination: '/app/roomList/' +
                            roomInfo.room['participant'], // 전송할 destination
                        body: json.encode({
                          "chatting_no": _roomIdx.toString(),
                          "sender": GlobalState.loginEmail,
                          "message_content": message,
                        }), // 메시지의 내용
                      );
                      // 텍스트 입력 필드를 비움
                      textController.clear();
                      scrollController.animateTo(
                          scrollController.position.minScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
