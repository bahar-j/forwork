<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="org.forwork.domain.Portfolio"%>
<%@page import="org.forwork.domain.Member"%>
<%@page import="org.forwork.dao.PortfolioDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%
String member_id = request.getParameter("member_id");

session.setAttribute("member_id", member_id);


%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="Start your development with a Dashboard for Bootstrap 4.">
  <meta name="author" content="Creative Tim">
  <title>MyProfile-Main</title>
  
	<!-- Favicon -->
	<link rel="icon" href="../assets/img/brand/favicon.png" type="image/png">
  
	<!-- Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
  
	<!-- Icons -->
	<link rel="stylesheet" href="../assets/vendor/nucleo/css/nucleo.css" type="text/css">
	<link rel="stylesheet" href="../assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
  
	<!-- Argon CSS -->
	<link rel="stylesheet" href="../assets/css/argon.css?v=1.2.0" type="text/css">

 	<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">


	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<!-- Popper JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

	<!-- CSS -->
	<link href="CSS/myprofile.css" type="text/css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="/CSS/myprofile.css">
	
	<!-- JSON 값 받아와서 차트그리기 -->

	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
		    google.charts.load('current', {'packages':['corechart']});
			google.charts.setOnLoadCallback(drawChart);
			
			function drawChart() { 
				var data = google.visualization.arrayToDataTable([
					['Programming Language','Count'],
				<% 
				List<Map<String,String>> li = (List<Map<String,String>>)request.getAttribute("statLangList");
					for(int i = 0; i < li.size()-1;i++){
						System.out.println(li.get(i).get("language"));
						System.out.println(li.get(i).get("langCount"));
						%>['<%=li.get(i).get("language")%>',
						<%=li.get(i).get("langCount")%>],
					<%}%>
				]);
				var options = {'title': 'Portfolio_language'}; 
				
			
				var chart = new google.visualization.PieChart(document.getElementById('piechart'));
		        chart.draw(data, options);
			}
			
			$(document).ready(function(){
				$(".alert-heading").click(function(){
					var submenu = $(".alert-heading-content");
					if( submenu.is(":visible")){
					submenu.slideUp();
					}else{
					submenu.slideDown();
					}
				});
			});
	</script> 
	<style>
		.alert-heading{
		 cursor:pointer;
		}
		.alert-heading-content {
		 display:none;
		}
	</style>
<title>My Profile main</title>
</head>
<body>
    <div class="header_myProfile">
      <div class="container_myProfile">
        <div class="row">
          <div class="col-lg-7 col-md-10">
            <h1 class="display-2 text-white">Hello ${member.name }</h1>
            <p class="text-white mt-0 mb-5">This is your profile page. You can see the progress you've made with your work and manage your projects or assigned tasks</p>
         	<a href="insertPortfolioFormAction.do"><button type="button" class="btn btn-primary">Add Portfolio</button></a>
          </div>
        </div>
      </div>
    </div>
    
    <div class="content_container">
    	<div class="row">
 <div class="column_left" style="width:40%">
	<c:forEach var="portfolio" items="${list }">
			<div class="alert alert-primary" role="alert" style="width:100%">
  				<h4 class="alert-heading">${portfolio.portfolio_title }</h4>
				<div class="alert-heading-content">
				<a href="selectPortfolioAction.do?portfolio_id=${portfolio.portfolio_id}">
					<button type="button" class="btn btn-outline-primary">수정</button>
				</a>
				<button type="button" class="btn btn-outline-secondary">삭제</button>
  				<p><table align="center" style="width:100%">
					<tr align="left">
						<td>진행 기간:</td>
						<td>${portfolio.portfolio_start_date }</td>
						<td>~</td>
						<td>${portfolio.portfolio_end_date }</td>
					</tr>
					<tr>
						<p>
						<td colspan="4">${portfolio.portfolio_detail }</td>
						<p>
					</tr>
					</table>
				</p>
  				<hr>
  				
  				<p class="mb-0">
  					<c:forEach var="portfolio_language"	items="${langList }">
						<c:if test="${portfolio.portfolio_id == portfolio_language.portfolio_id}">
						<span class="badge badge-pill badge-primary">${portfolio_language.portfolio_language}</span>
						</c:if>
					</c:forEach></p>
				</div>
			</div>
			
		</c:forEach>
 </div>
    	
    	<!-- 프로필 카드 영역 -->
			<div class="column_right">
				<div class="card card-profile">
					<div class="card-top"></div>
					<div class="row justify-content-center">
						<div class="col-lg-3 order-lg-2">
							<div class="card-profile-image">
								<a href="#"> <img src="https://ifh.cc/g/BGjWHX.png" class="rounded-circle">
								</a>
							</div>
						</div>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col">
								<div class="card-profile-stats d-flex justify-content-center">
									<!-- <div>
										<span class="heading">22</span> <span class="description">Project</span>
									</div>
									<div>
										<span class="heading">10</span> <span class="description">Task-to-do</span>
									</div>
									<div>
										<span class="heading">89</span> <span class="description">Comments</span>
									</div> -->
								</div>
							</div>
						</div>
						<div class="text-center" style="padding-top:100px;">
							<h5 class="h3">
								${member.name }<span class="font-weight-light">, 27</span>
							</h5>
							<div class="h5 mt-4">
								<i class="ni business_briefcase-24 mr-2"></i>${member.email }
							</div>
							<div>
								<i class="ni education_hat mr-2"></i>University of Computer
								Science
							</div>

							<div class="card-body">
							<!-- 차트 들어갈 곳.. -->
							      <div id="piechart" style="width: 500px; height: 400px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
    	</div>
    </div>
</body>
</html>
<%@ include file="footer.jsp" %>