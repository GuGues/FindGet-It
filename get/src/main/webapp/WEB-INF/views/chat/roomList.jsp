<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    #modalOpenButton, #modalCloseButton {
        cursor: pointer;
    }

    #modalContainer {
        width: 100%;
        height: 100%;
        position: fixed;
        top: 0;
        left: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        background: rgba(0, 0, 0, 0.5);
    }

    #modalContent {
        position: absolute;
        background-color: #ffffff;
        width: 330px;
        height: 600px;
        overflow-y: scroll;
        padding: 15px;
    }

    .roomList {
        width: 300px;
        height: 50px;
        margin: 10px 0;
        border: 1px solid silver;
        border-radius: 5px;
    }
    .roomList a{
        text-decoration: none;
        color: black;
        margin: 5px 10px;
    }
    .roomList:hover{
        transform: scale(1.03);
    }
    .message{
        font-size: 14px;
        color: #666666;
        margin: 5px 15px;
    }
    .send_time{
        float: right;
    }
    .chatCount{
        display: inline-block;
        float: right;
        padding: 0px;
        width: 18px;
        height: 18px;
        margin-right: 20%;
        margin-top: 5px;
        border-radius: 50%;
        text-align: center;
        line-height: 18px;
        color: black;
        background: #FF914B;
    }
    .hidden{
        display: none;
    }
</style>
<body>
<div id="modalContainer">
    <div id="modalContent">
        <h2>${sessionScope.nickname}님의 채팅방</h2>
        <div id="roomListContainer">
            <c:forEach items="${map.roomList}" var="room" varStatus="status">
                <div class="roomList">
                    <a href="/chatting/room/${room.chatting_no}">${map.memberList[status.index].nickname}님 채팅</a><div class="chatCount">${map.viewList[status.index]}</div>
                    <div class="message">${map.chatList[status.index].message_content}<div class="send_time"> ${map.chatList[status.index].send_time}</div></div></div>
            </c:forEach>

        </div>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>
<script>

    // 페이지 로드 시 connect() 메서드 실행
    window.onload = function () {
        connect();
    }

    const stompClient = new StompJs.Client({
        brokerURL: 'ws://192.168.0.214:9090/ws-connect'
    });

    stompClient.onConnect = (frame) => {
        console.log('Connected: ' + frame);

        stompClient.subscribe('/queue/chat/roomList/' + '${sessionScope.email}', (greeting) => {
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
        stompClient.activate();
    }

    function showGreeting(map) {
        console.log(map)
        document.querySelector("#roomListContainer").replaceChildren();
        for (let i = 0; i < map.roomList.length; i++) {
            if(map.chatList.length>i)
                $("#roomListContainer").append('<div class="roomList"><a href="/chatting/room/' + map.roomList[i].chatting_no + '"><div class="chatCount">'+map.viewList[i]+'</div>'
                    + map.memberList[i].nickname + '님 채팅</a><div class="message">'+map.chatList[i].message_content+' <span class="send_time">'+ map.chatList[i].send_time+'</span></div></div>');
            else
                $("#roomListContainer").append('<div class="roomList"><a href="/chatting/room/' + map.roomList[i].chatting_no + '">'
                    + map.memberList[i].nickname + '님 채팅</a><div class="message"></div></div>');
        }
        listClick();
        chatCountCheck();
    }
    const listClick = function (){

        document.querySelectorAll(".roomList").forEach(function (item,idx){
            item.addEventListener("click",function (e){
                e.preventDefault()
                e.stopPropagation()
                window.location.href=item.firstElementChild.href;
            })
        })
    }
    const chatCountCheck = function (){

        document.querySelectorAll(".chatCount").forEach(function (item,idx){
            if(item.innerHTML=="0" ||item.innerHTML==""){
                item.classList.add("hidden");
            }
        })
    }
    chatCountCheck();
    listClick();
</script>
</body>
</html>
