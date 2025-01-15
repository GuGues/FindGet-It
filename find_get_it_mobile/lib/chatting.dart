import 'package:find_get_it_mobile/ChatBubble.dart';
import 'package:find_get_it_mobile/appConfig.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'global.dart';

class Chatting {
  final String chatting_no;
  final Map<String, dynamic> room;
  final List<Map<String, dynamic>> chatList;

  Chatting({
    required this.chatting_no,
    required this.room,
    required this.chatList,
  });

  @override
  String toString() {
    print(chatting_no);
    print(room);
    print(chatList);
    return "OK";
  }

  factory Chatting.fromJson(Map<String, dynamic> json) {
    Chatting chatting = Chatting(
        chatting_no: json['chatting_no'] ?? '',
        room: Map<String, dynamic>.from(json['room']),
        chatList:
            List<Map<String, dynamic>>.from(json['chatList']) ?? List.empty());
    return chatting;
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

Future<Chatting> fetchItems(var args) async {
  var uri = Uri.parse(appConfig.url+'/app/chatting/' + args);
  final response = await http.get(uri); //광석

  if (response.statusCode == 200) {
    // 서버에서 받은 JSON 데이터를 파싱해서 List<ChattingRoom>로 변환
    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    return Chatting.fromJson(data);
  } else {
    throw Exception('Failed to load items');
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
  late Chatting chatting;
  late StompClient stompClient;
  ScrollController scrollController = ScrollController();

  fetch(var args) async {
    var uri = Uri.parse(appConfig.url+'/app/chatting/' + args);
    final response = await http.get(uri); //광석

    if (response.statusCode == 200) {
      // 서버에서 받은 JSON 데이터를 파싱해서 List<ChattingRoom>로 변환
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        chatting = Chatting.fromJson(data);
      });
    } else {
      throw Exception('Failed to load items');
    }
  }

  updateView(var args) async {
    var uri = Uri.parse(appConfig.url+'/app/chatting/update-view');
    final response = await http.post(uri,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'chatting_no': args,
          'email': GlobalState.loginEmail
        })); //광석

    if (response.statusCode == 200) {
      // 서버에서 받은 JSON 데이터를 파싱해서 List<ChattingRoom>로 변환
    } else {
      throw Exception('Failed to load items');
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
        setState(() => {chats.add(chat)});
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
        fetch(args);
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
              child: FutureBuilder<Chatting>(
                future: fetchItems(_roomIdx), // fetchItems() 함수에서 API 호출
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator()); // 로딩 화면
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('에러 발생: ${snapshot.error}')); // 에러 처리
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('데이터가 없습니다.')); // 데이터가 없을 때
                  } else {
                    final items = snapshot.data!; // 받아온 Lost 리스트
                    print(items);
                    return ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: items.chatList.length,
                      itemBuilder: (context, index) {
                        var chat = items.chatList[index];
                        return ChatBubble(
                            chat['message_content'],
                            chat['send_time'],
                            (chat['sender'] == GlobalState.loginEmail)
                                ? true
                                : false);
                      },
                    );
                  }
                },
              ),
            ),
// 텍스트 입력 필드와 전송 버튼을 가진 Row
            Row(
              children: [
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
                            chatting.room['open_member'], // 전송할 destination
                        body: json.encode({
                          "chatting_no": _roomIdx.toString(),
                          "sender": GlobalState.loginEmail,
                          "message_content": message,
                        }), // 메시지의 내용
                      );
                      stompClient.send(
                        destination: '/app/roomList/' +
                            chatting.room['participant'], // 전송할 destination
                        body: json.encode({
                          "chatting_no": _roomIdx.toString(),
                          "sender": GlobalState.loginEmail,
                          "message_content": message,
                        }), // 메시지의 내용
                      );
// 텍스트 입력 필드를 비움
                      textController.clear();
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
