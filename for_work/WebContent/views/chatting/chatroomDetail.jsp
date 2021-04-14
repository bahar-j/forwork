<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/views/header.jsp" %>
<%
	/* String chatroomId = request.getParameter("chatroomId"); */
	/* session.setAttribute("userId", "1");
	session.setAttribute("chatroomId", chatroomId); */
%>
<!DOCTYPE html>
<html>
  <head>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <title>chatting</title>
    <style type="text/css">
    	#chatroom-title-container {
    		width: 100%;
    		background-color: rgb(212, 214, 241);
    		height: 80px;
    	}
    	
    	#chatroom-title {
    		margin-left: 45px;
    		line-height: 80px;
    		font-weight: bold;
    		font-size: 20px;
    	}
    	.bubble {
		  margin: 5px 0;
		  display: inline-block;
		  max-width: 300px;
		  font-size: 14px;
		  position: relative;
		}
		
		.my-bubble {
		  background-color: #fff46d;
		  border-radius: 14px 14px 0px 14px;
		  padding: 7px 15px 7px 15px;
		  float: right;
		  clear: both;
		}
		
		.friend-bubble {
		  background-color: rgb(190, 194, 236);
		  border-radius: 14px 14px 14px 0;
		  padding: 7px 15px 7px 15px;
		  float: left;
		  clear: both;
		}
		
		
		.chatbox {
		  padding: 10px;
		  overflow-y: scroll;
		  position: relative;
		}
		
		#chat-send {
		  background-color: #4a90e2;
		  width: 60px;
		  height: 60px;
		  color: white;
		  border: none;
		  border-radius: 3px;
		  cursor: pointer;
		  margin-left: 10px;
		  float: left;
		}
		
		.text-box {
		  background-color: #fafafa;
		  padding: 10px;
		}
		
		.text-box #message {
		  height: 60px;
		  float: left;
		  width: calc(100% - 70px);
		  border-radius: 3px;
		  background-color: #ffffff;
		  border: solid 0.5px #d7d7d7;
		  resize: none;
		  padding: 10px;
		  font-size: 14px;
		}
    </style>
  </head>
  <body>
  	<div id="chatroom-title-container">
  		<span id="chatroom-title">${chatroomName }</span>
  	</div>
  	<div class="chatbox">
		<c:forEach var="message" items="${messages}">
			<c:if test="${message.sender == userId }">
				<span class="bubble my-bubble">${message.message }</span>
			</c:if>
			<c:if test="${message.sender != userId }">
				<span class="bubble friend-bubble">${message.message }</span>
			</c:if>
		</c:forEach>
	</div>
<!-- 	
    <textarea id="chattingRoom" rows="10" cols="50">
    </textarea> -->
    	<div class="text-box">
    		<input type="text" id="message" />
    		<input type="button" onclick="sendMessage()" value="send" id="chat-send"/>
      		<div class="clearfix"></div>
    	</div>
   		<input type="button" onclick="disconnect()" value="disconnect"/>
   		<input type="text" value="${userId }" id="user">
   		
  <script type="text/javascript">
  	let sender = document.getElementById("user").value;
  	let webSocket = new WebSocket("ws://localhost:8081/for_work/broadsocket");
  	
/*   	let chatRoom = document.getElementById("chattingRoom"); */
  	let message = document.getElementById("message");
  	
  	webSocket.onopen = function(){
  		/* chatRoom.value += "connected to server...\n" */
  	};
  	
  	webSocket.onclose = function(){
  		/* chatRoom.value += "disconnected...\n"; */
  	}
  	webSocket.onerror = function(){
  		/* chatRoom.value += "error....\n"; */
  	}
  	// 소켓에 들어온 메세지가 있을 때
  	webSocket.onmessage = function(message){
  		let parsedMsg = JSON.parse(message.data);
        let chatBubble = document.createElement('span');
        chatBubble.innerHTML =  parsedMsg.content;   
        chatBubble.classList.add('bubble');
        if (parsedMsg.sender == sender){
        	chatBubble.classList.add('my-bubble');
  		} else {
  			chatBubble.classList.add('friend-bubble');	
  		}
        document.querySelector('.chatbox').appendChild(chatBubble);
  	}
  	
  	// TODO: 시간 단위(1시간?)만큼의 메세지 불러와서 띄워주기
  	function loadMessage(){
  		
  	}
  	
  	function sendMessage(){
  		let url = document.location.href;
  		let param = url.substring(url.indexOf('chatroomId=') + 11);
  		console.log(param);
  		let date = new Date();
  		let sendTime = moment(date).format('YYYY-MM-DD HH:mm:ss');
  		console.log("sender: " + sender);
  		let msg = {
  			"content": message.value,
  			"sender": sender,
  			"chatroomId": param,
  			"sendTime": sendTime
  		}
		webSocket.send(JSON.stringify(msg));
  	}
  	
  	function disconnect(){
  		webSocket.close();
  	}
  	
  </script>
   </body>
</html>
<%@ include file="/views/footer.jsp" %>