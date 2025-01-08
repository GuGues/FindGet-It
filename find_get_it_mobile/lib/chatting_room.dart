import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'appConfig.dart';
import 'global.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';


class ChattingRoom {
  final List<Map<String,dynamic>> roomList;
  final List<Map<String,dynamic>> chatList;
  final List<Map<String,dynamic>> memberList;
  final List<dynamic> viewList;

  ChattingRoom({
    required this.roomList,
    required this.chatList,
    required this.memberList,
    required this.viewList
  });

  @override
  String toString() {
    print(chatList);
    print(roomList);
    print(memberList);
    print(viewList);
    return "OK";
  }

  factory ChattingRoom.fromJson(Map<String, dynamic> json){
    ChattingRoom chattingRoom =  ChattingRoom(roomList:List<Map<String,dynamic>>.from( json['roomList'])??List.empty(),
        chatList:List<Map<String,dynamic>>.from( json['chatList'])??List.empty(),
        memberList:List<Map<String,dynamic>>.from( json['memberList'])??List.empty(),
        viewList: List<dynamic>.from(json['viewList'])??List.empty());
    return chattingRoom;
  }
}
  Future<ChattingRoom> fetchItems() async {
    final response = await http.get(Uri.parse(
        appConfig.url+'/app/chatting-roomList/' +
            GlobalState.loginEmail)); //광석

    if (response.statusCode == 200) {
      // 서버에서 받은 JSON 데이터를 파싱해서 List<ChattingRoom>로 변환
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
    return ChattingRoom.fromJson(data);
    } else {
      throw Exception('Failed to load items');
    }
  }


class GetTalkPage extends StatefulWidget {
  const GetTalkPage({super.key});

  @override
  State<StatefulWidget> createState() => _GetTalkState();

}
class _GetTalkState extends State<GetTalkPage> with SingleTickerProviderStateMixin {
  String _errorMsg = '';
  bool _isLoading = false;
  String _roomIdx='';
  late StompClient stompClient;
  ScrollController scrollController = ScrollController();

  void onConnect(StompClient stompClient, StompFrame frame) {
    stompClient.subscribe(
      destination: '/queue/chat/roomList/'+GlobalState.loginEmail,
      callback: (frame) {
        //List<dynamic>? result = json.decode(frame.body!);
        Map<String, dynamic> obj = json.decode(frame.body!);
        print(obj);
        setState(() => {
        });
      },
    );
  }



  @override
  void initState() {
    super.initState();
    // 탭: 분실물 / 습득물 / 경찰 습득물
    // 화면 빌드 후 arguments 로부터 검색어 받기

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
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
      appBar: AppBar(
        title: const Text('GET TALK'),
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
      body: FutureBuilder<ChattingRoom>(
        future: fetchItems(),  // fetchItems() 함수에서 API 호출
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());  // 로딩 화면
          } else if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));  // 에러 처리
          } else if (!snapshot.hasData) {
            return const Center(child: Text('데이터가 없습니다.'));  // 데이터가 없을 때
          } else {
            final items = snapshot.data!;  // 받아온 Lost 리스트
            print(items.memberList);
            // ListView로 아이템 표시
            // ListView로 아이템 표시
            return ListView.builder(
              itemCount: items.roomList.length,
              itemBuilder: (context, index) {
                var room = items.roomList[index];
                var member = items.memberList[index];
                var chat = (items.chatList.length>index)?
                  items.chatList[index]: null;
                var view = (items.viewList.length>index)?
                  items.viewList[index]:"";
                return ListTile(
                  title: Text(member['nickname']+'님 채팅'),
                  subtitle: Text((chat?['message_content'] ?? '')),
                  trailing: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        /// 메세지 보낸 시간
                        Text(
                          chat?['send_time'] ?? '',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.black54),
                        ),

                        /// 읽지 않은 메세지 수
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            color: (view.toString()!="0"&&view.toString()!="")?Colors.red:Colors.white30,
                            alignment: Alignment.center,
                            child: Text(
                                view.toString(),
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.bold, color: Colors.white70),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/getTalkDetail', arguments: room['chatting_no']);
                  },
                );
              },
            );
          }
        },
      ),
    ),
    );
  }


}
