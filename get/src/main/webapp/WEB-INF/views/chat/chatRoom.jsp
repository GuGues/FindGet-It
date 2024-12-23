<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
  <title>채팅방</title>
  <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/stompjs@2/dist/stomp.min.js"></script>
</head>
<body>
<h1>${roomId}번 채팅방</h1>
<div id="chatMessages">
  <c:forEach var="msg" items="${messages}">
    <div>
      <strong>${msg.senderEmail}:</strong> ${msg.messageContent} <small>${msg.sentAt}</small>
    </div>
  </c:forEach>
</div>

<input type="text" id="messageInput" placeholder="메시지 입력"/>
<button onclick="sendMessage()">전송</button>

<script>
  var socket = new SockJS('/ws/chat');
  var stompClient = Stomp.over(socket);
  stompClient.connect({}, function(frame) {
    stompClient.subscribe('/topic/room', function(response){
      var data = JSON.parse(response.body);
      if(data.roomId == ${roomId}) {
        var div = document.getElementById('chatMessages');
        var msgDiv = document.createElement('div');
        msgDiv.innerHTML = '<strong>' + data.senderEmail + ':</strong> ' + data.messageContent;
        div.appendChild(msgDiv);
      }
    });
  });

  function sendMessage(){
    var message = document.getElementById('messageInput').value;
    stompClient.send("/app/sendMessage", {}, JSON.stringify({
      "roomId": ${roomId},
      "messageContent": message
    }));
    document.getElementById('messageInput').value = '';
  }
</script>
</body>
</html>