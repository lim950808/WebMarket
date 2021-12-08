<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원정보</h1>
		</div>
	</div>
	<div class="container" align="center">
		<%
			/* 파라미터로 넘어온 msg값 얻기 */
			String msg = request.getParameter("msg");
			/* 파라미터 값: 0->수정, 1->가입(입력), 2->로그인, 없으면->삭제 */
			if(msg != null) {
				if(msg.equals("0"))
					out.print("<h2 class='alert alert-primary'>회원정보가 수정되었습니다.</h2>");
				else if(msg.equals("1"))
					out.print("<h2 class='alert alert-success'>회원가입을 축하드립니다.</h2>");
				else if(msg.equals("2")) {
					String loginId = (String)session.getAttribute("sessionId");
					out.print("<h2 class='alert alert-info'>" + loginId + "님 환영합니다.</h2>");
				}else if(msg.equals("3")) {
					out.print("<h2 class='alert alert-danger'>회원정보가 삭제되었습니다.</h2>");
				}
			}
		%>
	</div>
</body>
</html>