<%@ page contentType="text/html; charset=UTF-8"%>
<% /* String sessionId = (String)session.getAttribute("sessionId"); */
	String sessionId = "hong";
%>
<!DOCTYPE html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<html>
<head>
<meta charset="UTF-8">
	<script>
		function checkForm() {
			location.href="./BoardWriteForm.do?id=<%=sessionId%>";
		}
	</script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">게시판</h1>
		</div>
	</div>
	<div class="container">
		<a href="#" onclick="checkForm(); return false;" class="btn btn-primary">&laquo; 글쓰기</a>
		<hr>
	</div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>