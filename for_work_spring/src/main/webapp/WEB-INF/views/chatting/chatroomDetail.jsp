<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../header.jsp" %>
<%
	/* String chatroomId = request.getParameter("chatroomId"); */
	/* session.setAttribute("userId", "1");
	session.setAttribute("chatroomId", chatroomId); */
%>
<!DOCTYPE html>
<html>
  <head>
  	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	<script type="text/javascript" src="/resources/js/chatting.js"></script>
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
		  margin-bottom: 30px;
		  float: right;
		  clear: both;
		}
		
		.friend-bubble {
		  background-color: rgb(190, 194, 236);
		  border-radius: 14px 14px 14px 0;
		  padding: 7px 15px 7px 15px;
		  margin-left: 50px;
		  margin-top: -45px;
		  margin-bottom: 30px;
		  float: left;
		  clear: both;
		}
		
		.friend-profile {
		  float: left;
		  clear: both;
		}
		
		.friend-name {
			margin-left: 60px;
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
  		<span id="chatroom-title" data-chatroom-id="${chatroomId }" >${chatroomName }</span>
  	</div>
  	<div class="chatbox">
		<c:forEach var="message" items="${messages}">
			<div>
				<c:if test="${message.sender.member_id == userId }">
					<span class="bubble my-bubble">${message.message }</span>
				</c:if>
				<c:if test="${message.sender.member_id != userId }">
					<div class="bubble friend-profile friend-name">${message.sender.name }</div>
					<img class="bubble friend-profile" src="../Img/profile.png" width="38">
					<span class="bubble friend-bubble">${message.message }</span>
				</c:if>
			</div>
		</c:forEach>
	</div>

   	<div class="text-box">
   		<input type="text" onkeyup="isEnterKey()" id="message" />
   		<input type="button" onclick="sendMessage()" value="send" id="chat-send" />
     		<div class="clearfix"></div>
   	</div>
	<!-- <input type="button" onclick="disconnect()" value="disconnect"/> -->
	<input type="text" value="${userId }" id="user" style="display:none;">
	<input type="text" value="sdfsadf" id="userName" style="display:none;">
   		
  <script type="text/javascript">
  
  	document.addEventListener("DOMContentLoaded", function(){
  		let userId = document.getElementById("user").value;
  		let chatroomId = document.getElementById("chatroom-title").dataset.chatroomId;
  		let chatroomTitle = document.getElementById("chatroom-title");
  		chattingService.getChatroomName(chatroomId, function(result){
  			chatroomTitle.innerHTML = result.chatroom_name;
  		});
  		
  		let chatbox = document.querySelector(".chatbox");
  		chattingService.getMessages(chatroomId, function(messages){
  			let html = ""
  			messages.forEach( msg => {
  				if (msg.sender.member_id == userId){
  					html += '<span class="bubble my-bubble">' + msg.message + '</span>'
  				} else {
  					html += 
  	  					'<div class="bubble friend-profile friend-name">' + msg.sender.name + '</div>'
  						+ '<img class="bubble friend-profile" src="/resources/Img/profile.png" width="38">'
  						+ '<span class="bubble friend-bubble">' + msg.message + '</span>';
  				}
  			});
  			chatbox.innerHTML = html;
  		});
	});


  	
  	let stompClient = null;
  	/* let webSocket = new WebSocket("ws://localhost:8081/websocket"); */
  	let socket = new SockJS("/websocket");
  	socket.onopen = function () {
  		
  		console.log("connected");
  	}
  	stompClient = Stomp.over(socket);
  	stompClient.connect({}, function(frame){
  		/* setConnected(true); */
  		console.log('connected: ' + frame);
  		stompClient.subscribe("/topic/chatroom/" + chatroomId, function(response){
  			showMessage(JSON.parse(response.body));
  		});
  	}, function(error) {
  	    alert(error);
  	}); 
  	
  	function showMessage(message){
  		console.log(message);
  	}
  	
  	function sendMessage(){
  		let sender = document.getElementById("user").value;
  	  	let senderName = document.getElementById("userName").value;
  		let message = document.getElementById("message");
  		let date = new Date();
  		let sendTime = moment(date).format('YYYY-MM-DD HH:mm:ss');
  		console.log("sender: " + sender);
  		let msg = {
  			"content": message.value,
  			"senderId": sender,
  			"senderName": senderName,
  			"chatroomId": chatroomId,
  			"sendTime": sendTime
  		}
  		console.log(message.value)
  		stompClient.send("/app/message/" + chatroomId, {}, msg)
  	}
  
  	
  	/* let message = document.getElementById("message");
  	
  	webSocket.onopen = function(){
  	};
  	
  	webSocket.onclose = function(){
  	}
  	webSocket.onerror = function(){
  	}
  	// 소켓에 들어온 메세지가 있을 때
  	webSocket.onmessage = function(message){
  		let parsedMsg = JSON.parse(message.data);
        let chatBubble = document.createElement('span');
    	
        chatBubble.innerHTML =  parsedMsg.content;   
        chatBubble.classList.add('bubble');
        
        if (parsedMsg.senderId == sender){
        	chatBubble.classList.add('my-bubble');
  		} else {
  			let name = document.createElement('div');
  	    	let img = document.createElement('img');
  	    	
  			chatBubble.classList.add('friend-bubble');
  			name.innerHTML = parsedMsg.senderName;
  	        name.classList.add('bubble');
  	        name.classList.add('friend-profile');
  	        name.classList.add('friend-name');
  	        
  	        img.src = '../Img/profile.png';
  	        img.width = 38;
  	      	img.classList.add('bubble');
	        img.classList.add('friend-profile');
	  	    document.querySelector('.chatbox').appendChild(name);
	        document.querySelector('.chatbox').appendChild(img);
  		}
        document.querySelector('.chatbox').appendChild(chatBubble);
  	}
  	
  	// TODO: 시간 단위(1시간?)만큼의 메세지 불러와서 띄워주기
  	function loadMessage(){
  		
  	}
 
  	function isEnterKey(){
  		if (window.event.keyCode == 13) {
        	sendMessage();
       }
  	}
  	
  	function disconnect(){
  		webSocket.close();
  	} */
  	
  </script>
   </body>
</html>
<%@ include file="../footer.jsp" %>