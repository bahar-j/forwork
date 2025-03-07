<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css">

<!-- Optional JavaScript; choose one of the two! -->

<!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
	crossorigin="anonymous"></script>

<!-- Option 2: Separate Popper and Bootstrap JS -->
<!--
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    -->
    

<style type="text/css">

.container {
	margin: 0px;
}

.list-group-item {
	height: 37px;
}

.boardMenuList {
	border: 2px solid gray;
	min-height: 450px;
	width: 185px;
	margin-top: 40px;
	font-size: 14px;
	position: relative;
	padding: 10px;
	border-radius: 10px;
	position: relative;
	left: 10px;
}

.boardManagerBtn {
	position: absolute;
	bottom: 10px;
	left: 10px;
}

.container a {
	text-decoration: none;
	color: #000;
}

.container a:hover {
	font-weight: bold;
}

.listWrap {
	margin-top: 30px;
	padding-left: 40px;
	position: relative;
}

.boardName {
	font-size: 20px;
	font-weight: bold;
	margin-bottom: 20px; 
}

table {
	
}

.write {
	border: 3px solid gray;
	height: 30px;
	width: 80px;
	border-radius: 5px;
	position: absolute;
	right: 10px;	
	top: 0px;
}

.writeBox {
	position: relative;
	left: 13px;
}

</style>
<title>4WORK | ${boardName.board_name}</title>
</head>
<body>

	<div class="wrap">
		<div class="container">
			<div class="row">
				<div class="col-2">
				
					<div class="boardMenuList">
						<ul class="list-group list-group-flush">
							<li class="list-group-item"><a href="boardMainAction.do?project_id=${boardName.project_id}"><i class="bi bi-house-door"></i> 게시판 홈</a></li>
							<c:forEach var="boardMenu" items="${boardMenu}">
								<li class="list-group-item">
									<a href="listAction.do?project_id=${boardMenu.project_id}&board_id=${boardMenu.board_id}">
									<i class="bi bi-clipboard"></i> ${boardMenu.board_name}</a></li>
							</c:forEach>
						</ul>
						<a href="boardManagerAction.do?project_id=${boardName.project_id}" class="boardManagerBtn"><i class="bi bi-pencil-square"></i> 게시판 관리</a>
					</div>
					
				</div>
				<div class="col-10">
					<div class="listWrap">
						<div class="boardName">${boardName.board_name}</div>
						 <div class="write"><a href="insertPost.do?project_id=${boardName.project_id}&board_id=${boardName.board_id}" class="writeBox">글쓰기</a></div>

						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col">No.</th>
									<th scope="col" style="width: 55%; text-align: center">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col">조회</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="board" items="${list}">
									<tr>
										<td>${board.post_id}</td>
										<td><a href="detailAction.do?post_id=${board.post_id}&board_id=${boardName.board_id}&project_id=${boardName.project_id}">${board.post_title}</a></td>
										 <td>${board.post_writer}</td>
										<td><fmt:parseDate var="dt" value="${board.post_date}"
												pattern="yyyy-MM-dd HH:mm:ss"></fmt:parseDate> <fmt:formatDate
												value="${dt}" pattern="yyyy.MM.dd HH:mm" /></td>
										<td>${board.hitcount}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<!-- col-10 -->
			</div>
		</div>
	</div>

</body>
</html>

<%@ include file="footer.jsp"%>