<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
function checkForm() {
	if(document.newMember.password.value!=document.newMember.password_confirm.value) {
		alert("비밀번호가 일치하지 않습니다!");
		document.newMember.password.value="";
		document.newMember.password_confirm.value="";
		document.newMember.password.focus();
		return false;
	}	
 
	//validation 체크
	var regExpId = /^[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	var regExpPassword =/^[0-9]*$/;
	var regExpName = /^[가-힣]*$/;
	//form명
	var form = document.newMember;
	
	var id = form.id.value;
	var password = form.password.value;
	var name = form.name.value;
}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/menu.jsp"/>
  <div class="jumbotron">
      <div class="container">
      	<h1 class="display-3">회원가입</h1>
      </div>
  </div>

	<div class="container">
		<form name="newMember" class="form-horizontal" action="join.jsp" method="post" onsubmit="return checkForm()">
			<div class="form-group row">
	              <label class="col-sm-2">아이디</label>
	              <div class="col-sm-3">
	                   <input name="id" type="text" class="form-control" placeholder="아이디" autofocus required>
	              </div>
	        </div>
	        <div class="form-group row">
	              <label class="col-sm-2">비밀번호</label>
	              <div class="col-sm-3">
	                   <input name="password" type="password" class="form-control" placeholder="비밀번호" required>
	              </div>
	        </div>      
	        <div class="form-group row">
	              <label class="col-sm-2">비밀번호(확인)</label>
	              <div class="col-sm-3">
	                   <input name="password_confirm" type="password" class="form-control" placeholder="비밀번호(확인)" required>
	              </div>
	        </div>
	        <div class="form-group row">
	              <label class="col-sm-2">이름</label>
	              <div class="col-sm-3">
	                   <input name="name" type="text" class="form-control" placeholder="이름" required>
	              </div>
	        </div>
			<input type="submit" value="확인">
		</form>
	</div>
</body>
</html>