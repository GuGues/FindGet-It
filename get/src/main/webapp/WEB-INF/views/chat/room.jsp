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
        height: 80vh;
        border: 2px solid #D9D9D9;
        border-bottom: none;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        overflow-y: scroll;
        overflow-x: hidden;

        background-color: white;
        background-image: url('/logo/logo_open_gray.png');
        background-size: contain; /* 이미지 크기를 요소에 맞게 조정 */
        background-position: center; /* 이미지가 가운데 정렬되도록 설정 */
        background-repeat: no-repeat; /* 이미지가 반복되지 않도록 설정 */
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
    .send .chat{background: #FFAE6B;}
    .receive .chat{background: #D9D9D9;}
    .receive{
        margin: 4px;
        display: flex;
        justify-content: left;
    }
    .send {
        margin: 4px;
        display: flex;
        justify-content: right;    }
     #back{
       position: fixed;
       margin: 10px;
       padding: 5px 15px;
       border: solid 2px #FFE3CC;
       border-radius: 5px;
       background-color: #FFE3CC;
     }
     #back:hover{ border: solid 2px #FE8015; }
     ::-webkit-scrollbar {
    width: 0; /* 세로 스크롤바의 너비 */
    height: 0; /* 가로 스크롤바의 높이 */
    }
    .chatInput{
      width: 100%;
      background-color: white;
      border: 2px solid #D9D9D9;
      border-bottom-left-radius: 10px;
      border-bottom-right-radius: 10px;
      padding: 5px;
      background-color: #FFE3CC;
    }
    .chatInput input{
      border: 1px solid #D9D9D9;
      border-radius: 2px;
      width: 80%;
      height: 25px;
      margin: 10px 0;
    }
    .chatInput button{
      border: 1px solid #D9D9D9;
      background-color: #FFAE6B;
      border-radius: 5px;
      padding: 7px 15px;
    }
    .col-md-6{ text-align: center;}
    .hidden{
        display: none;
    }
    .report-btn{
        position: fixed;
        margin: 10px;
        padding: 5px 15px;
        border: solid 2px #FFE3CC;
        border-radius: 5px;
        background-color: #FFE3CC;
    }
    #startReport{
        position: fixed;
        left: 100px;
        margin: 10px;
        padding: 5px 15px;
        border: solid 2px #FFE3CC;
        border-radius: 5px;
        background-color: #FFE3CC;
    }
    #submitReport{
        left: 100px;
    }
    #closeReport{
        left: 200px;
    }
    #reportMessage{
        position: fixed;
        left: 100px;
        margin: 10px;
        padding: 5px 15px;
        border: solid 2px #FFE3CC;
        border-radius: 5px;
        background-color: #FFE3CC;
    }
</style>
<body>
<div class="row">
    <div class="col-md-12">
        <div id="chatting">
            <div>
          <button id="back">⬅︎</button>
                <button id="startReport" onclick="clickReport()">신고 하기</button>
                <button class="report-btn hidden" id="submitReport" onclick="submitReport()">신고</button>
                <button class="report-btn hidden" id="closeReport" onclick="closeReport()">신고 취소</button>
                <div id = "reportMessage" class="hidden">신고 되었습니다.</div>
            </div>
          <c:forEach items="${chatList}" var="chat" varStatus="i">
            <c:if test="${ i.index==0 }">
              <div>&nbsp;</div><div>&nbsp;</div>

            </c:if>
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
  <div class="col-md-6">
    <form class="form-inline">
        <div class="form-group chatInput">
            <input type="text" id="message_content" class="form-control" placeholder="채팅 입력">
            <button id="send" class="btn btn-default" onclick="sendMessage(event)">Send</button>
        </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
const updateView = function(){
    fetch("/chatting/update-view",{
        method:"POST",
        headers:{
            'Content-Type':'application/json'
        },
        body:JSON.stringify({
            chatting_no:${chatting_no},
            email:'${sessionScope.email}',
        })
    }).then(json=>json.text())
        .then(result=>console.log(result))
}
const stompClient = new StompJs.Client({
    brokerURL: 'ws://192.168.0.214:9090/ws-connect'
});
    // 페이지 로드 시 connect() 메서드 실행
    window.onload = function () {
        connect();
    }



    stompClient.onConnect = (frame) => {
        console.log('Connected: ' + frame);

        stompClient.subscribe('/queue/chat/room/' + ${chatting_no}, (greeting) => {
            updateView();
            showGreeting(JSON.parse(greeting.body));
        },{id:"message"});

        stompClient.publish({
                    destination: "/app/roomList/" + '${sessionScope.email}',
                    body: JSON.stringify({
                        'message_content': $("#message_content").val(),
                        'chatting_no': ${chatting_no},
                        'sender': '<c:out value="${sessionScope.email}"/>',
                    })
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
        updateView();
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
        let other = "";
        if('${sessionScope.email}'=='${room.open_member}') other = '${room.participant}';
        else other='${room.open_member}'
        fetch("/alarm/message/"+other,{
            method:"GET"
        });
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
            $("#chatting").append('<div class="receive"><div><span class="chat">' + chat.message_content+'</span><span class="time">'+ chat.send_time+'</span></div>' +
                '<input type="checkbox" value="'+chat.message_content+'" class="report hidden" name="report_message"></div>')
        }

        document.querySelector('#chatting').scrollTo(0,  document.querySelector('#chatting').scrollHeight);
    }
    document.querySelector('#chatting').scrollTo(0,  document.querySelector('#chatting').scrollHeight);

document.getElementById("back").addEventListener('click',function (){
    stompClient.unsubscribe("message");
    window.location.href = "/chatting/roomList";
})
function report(){
    document.querySelectorAll(".receive").forEach(function (item){
        let checkbox = document.createElement("input")
        checkbox.setAttribute("type",'checkbox');
        checkbox.setAttribute("value",item.childNodes[1].childNodes[1].innerHTML)
        checkbox.setAttribute("name","report_message")
        checkbox.setAttribute("class","report hidden")
        item.childNodes[1].appendChild(checkbox);
    })
}
report()

function clickReport(){
    document.querySelectorAll(".report-btn").forEach(function (item){
        item.classList.remove("hidden");
    })
    document.querySelectorAll(".report").forEach(function (item){
        item.classList.remove("hidden");
    })
    document.querySelector("#startReport").classList.add("hidden");
}
function closeReport(){
    document.querySelectorAll(".report-btn").forEach(function (item){
        item.classList.add("hidden");
    })
    document.querySelectorAll(".report").forEach(function (item){
        item.classList.add("hidden");
    })
    document.querySelector("#startReport").classList.remove("hidden");
}
function submitReport(){
    let reportContent = ""
    let other = "";
    if('${sessionScope.email}'=='${room.open_member}') other = '${room.participant}';
    else other='${room.open_member}'
    document.querySelectorAll(".report").forEach(function (item){
        if(item.checked){
            reportContent+=item.getAttribute("value")+", ";
        }
    })
    fetch("/chatting/report",{
        method:"POST",
        headers:{
            'Content-Type':'application/json'
        },
        body:JSON.stringify({
            reporter_email:'${sessionScope.email}',
            receiver_email:other,
            chat_report_content:reportContent,
            report_room:'${chatting_no}'
        })
    })
    closeReport()
    document.querySelector("#reportMessage").classList.remove("hidden");
    setTimeout(function (){
        document.querySelector("#reportMessage").classList.add("hidden");
    },3000);

}
</script>
</body>
</html>