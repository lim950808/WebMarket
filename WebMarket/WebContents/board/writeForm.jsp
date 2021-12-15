<%@ page contentType="text/html; charset=UTF-8"%>
<% /* 콘트롤러에서 db에서 조회한 id에 해당하는 name을 request에 실어서 전달한 name을 받음 */
String name = (String)request.getAttribute("name")==null?"":(String)request.getAttribute("name"); %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<jsp:include page="../menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">게시판</h1>
		</div>
	</div>
	<div class="container">
		<form name="newWrite" action="./BoardWriteAction.do" class="form-horizontal" method="post" onsubmit="return checkForm()">
			<input name="id" type="hidden" class="form-control" value="${sessionId }">
			<div class="form-group row">
				<label class="col-sm-2 control-label">성명</label>
				<div class="col-sm-3">
					<input name="name" class="form-control" value="<%=name %>" placeholder="name">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2 control-label">제목</label>
				<div class="col-sm-5">
					<input name="subject" class="form-control" placeholder="subject">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2 control-label">내용</label>
				<div class="col-sm-8">
					<textarea rows="5" cols="50" class="form-control" placeholder="content" name="content"></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="submit" class="btn btn-success" value="등록">
					<input type="reset" class="btn btn-secondary" value="취소">
				</div>
			</div>
		</form>
		<hr>
	</div>
	<%@ include file="../footer.jsp" %>
</body>
</html>