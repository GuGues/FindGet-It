<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" import="org.springframework.web.util.UriComponentsBuilder" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat Room List</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
</head>
<style>
    #chatting {
        width: 400px;
        height: 550px;
        border: 1px solid silver;
        border-radius: 5%;
        background: azure;
        overflow-y: scroll;
        overflow-x: hidden;
    }


    .time {
        font-size: 10px;
    }

    .chat {
        display: inline-block;
        padding: 5px 5px;
        border: 1px solid silver;
        max-width: 300px;
        border-radius: 10px;
        background: white;
    }
    .receive{
        margin: 4px;
        display: flex;
        justify-content: left;
    }
    .send {
        margin: 4px;
        display: flex;
        justify-content: right;    }
</style>
<body>
<div>
    <button id="back"><</button>
</div>
<div class="row">
    <div class="col-md-12">
        <div id="chatting">
            <c:forEach items="${chatList}" var="chat">
                <c:choose>
                    <c:when test="${chat.sender eq sessionScope.email}">
                        <div class="send">
                            <div>
                                <span class="time">${chat.send_time}</span>
                                <span class="chat">${chat.message_content}</span>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="receive">
                            <div>
                                <span class="chat">${chat.message_content}</span>
                                <span class="time">${chat.send_time}</span>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>
</div>
<div class="row">
    <div class="row">
        <div class="col-md-6">
            <form class="form-inline">
                <div class="form-group">
                    <input type="text" id="message_content" class="form-control" placeholder="채팅 입력">
                    <button id="send" class="btn btn-default" onclick="sendMessage(event)">Send</button>
                </div>
            </form>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
    // 페이지 로드 시 connect() 메서드 실행
    window.onload = function () {
        connect();
    }

    const stompClient = new StompJs.Client({
        brokerURL: 'ws://192.168.0.214:9090/ws-connect'
    });

    stompClient.onConnect = (frame) => {
        console.log('Connected: ' + frame);

        stompClient.subscribe('/queue/chat/room/' + ${chatting_no}, (greeting) => {
            console.log("Send Message!!");
            showGreeting(JSON.parse(greeting.body));
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
                'sender': '<c:out value="${sessionScope.email}"/>',
            })
        });
        document.querySelector("#message_content").value = "";


    }

    function showGreeting(chat) {
        stompClient.publish({
            destination: "/app/roomList/" + '${room.open_member}',
            body: JSON.stringify({
                'message_content': $("#message_content").val(),
                'chatting_no': ${chatting_no},
                'sender': '<c:out value="${sessionScope.email}"/>',
            })
        });
        stompClient.publish({
            destination: "/app/roomList/" + '${room.participant}',
            body: JSON.stringify({
                'message_content': $("#message_content").val(),
                'chatting_no': ${chatting_no},
                'sender': '<c:out value="${sessionScope.email}"/>',
            })
        });
        if (chat.sender =='${sessionScope.email}') {
            $("#chatting").append('<div class="send"><div><span class="time">'+ chat.send_time+'</span><span class="chat">' + chat.message_content+'</span></div></div>')
        }
        else{
            $("#chatting").append('<div class="receive"><div><span class="chat">' + chat.message_content+'</span><span class="time">'+ chat.send_time+'</span></div></div>')
        }

        document.querySelector('#chatting').scrollTo(0,  document.querySelector('#chatting').scrollHeight);
    }
    document.querySelector('#chatting').scrollTo(0,  document.querySelector('#chatting').scrollHeight);

    document.getElementById("back").addEventListener('click',function (){
        window.location.href = "/chatting/roomList";
    })
</script>
</body>
</html>