<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" import="org.springframework.web.util.UriComponentsBuilder" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat Room List</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
</head>
<body>
<div class="row">
    <h3>채팅방</h3>
</div>
<div class="row">
    <div class="row">
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <label for="message_content">채팅 입력</label>
                    <input type="text" id="message_content" class="form-control" placeholder="Your Message here...">
                </div>
                <button id="send" class="btn btn-default" onclick="sendMessage(event)">Send</button>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table id="conversation" class="table table-striped">
                <thead>
                <tr>
                    <th>Greetings</th>
                </tr>
                </thead>
                <tbody id="greetings">
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
    // 페이지 로드 시 connect() 메서드 실행
    window.onload = function() {
        connect();
    }

    const stompClient = new StompJs.Client({
        brokerURL: 'ws://localhost:9090/ws-connect'
    });

    stompClient.onConnect = (frame) => {
        console.log('Connected: ' + frame);

        stompClient.subscribe('/queue/chat/room/' + ${chatting_no}, (greeting) => {
            console.log("Send Message!!");
            showGreeting(JSON.parse(greeting.body).message_content);
        });
    };

    stompClient.onWebSocketError = (error) => {
        console.error('Error with websocket', error);
    };

    stompClient.onStompError = (frame) => {
        console.error('Broker reported error: ' + frame.headers['message']);
        console.error('Additional details: ' + frame.body);
    };

    function connect() {
        console.log("연결 시도");
        var chatroomId = ${chatting_no};

        console.log("채팅방 번호 " + chatroomId);
        stompClient.activate();
    }

    function sendMessage(event) {
        event.preventDefault(); // 기본 동작 중지
        console.log("보냄");
        stompClient.publish({
            destination: "/app/chat/" + ${chatting_no},
            body: JSON.stringify({
                'message_content': $("#message_content").val(),
                'chatting_no': ${chatting_no},
                'sender_no': 1,
            })
        });
    }

    function showGreeting(message) {
        $("#greetings").append("<tr><td>" + message + "</td></tr>");
    }

</script>
</body>
</html>