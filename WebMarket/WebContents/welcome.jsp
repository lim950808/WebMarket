<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<html>
<head>
<meta charset="UTF-8">
<title>welcome</title>
</head>
<body>
	<%@ include file="menu.jsp" %>
	<%!
		String greeting = "Welcome to Web Shopping Mall";
		String tagline = "Welcome to Web Market!";
	%>
<div class="jumbotron">
	<div class="container">
		<h1 class="display-3"><%=greeting %></h1>
	</div>
</div>

<div class="container">
	<div class="text-center">
		<h3><%=tagline %></h3>
		<%
			Date day = new java.util.Date();
			String am_pm;
			int hour = day.getHours();
			int minute = day.getMinutes();
			int second = day.getSeconds();
			if(hour/12 == 0) {
				am_pm = "AM";
			}else {
				am_pm = "PM";
				hour = hour - 12;
			}
			String CT = (hour<10?"0"+hour:hour) + ":" 
					  + (minute<10?"0"+minute:minute) + ":" 
					  + (second<10?"0"+second:second) + " " + am_pm;
			out.print("현재 접속 시각: " + CT + "\n");
		%>
		<br>
	</div>
	<div class="text-center">
		<%@ include file="include02_header.jsp" %>
	</div>
  <hr>
</div>
	<%@ include file="footer.jsp" %>
</body>
</html>
<!-- web.xml에 welcome-file-list에 페이지를 등록하면 welcome페이지로 사용가능
http://localhost:8080/WebMarket/welcome.jsp
 -->