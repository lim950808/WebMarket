<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head>
<script>
function selectDomain(obj){
	document.newMember.mail2.value=obj.value;
	if(obj.value=="") document.newMember.mail2.focus();
}
</script> 
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
	var regExpName = /^[가-힣]*$/;
	var regExpPassword =/^[0-9]*$/;
	var regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/;
	var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; //akim
	//form명
	var form = document.newMember;
	
	var id = form.id.value;
	var name = form.name.value;
	var passwd = form.password.value;
	var phone = form.phone1.value +"-" + form.phone2.value +"-" + form.phone3.value;
	var email = form.mail1.value +"@"+form.mail2.value;
	
	if(!regExpId.test(id)){
		alert("아이디는 문자로 시작해주세요");
		form.id.focus();
		form.id.value="";
		return false;
	}
	
	if(!regExpName.test(name)){
		alert("이름은 한글만 입력해주세요!");
		form.name.focus();
		form.name.value='';
		return false;
	}
	
	if(!regExpPassword.test(passwd)){
		alert("비밀번호는 숫자만 입력해주세요");
		form.password.focus();
		form.password.value='';
		form.password_confirm.value='';
		return false;
	}
	
	if(!regExpPhone.test(phone)){
		alert("연락처 입력을 확인 해주세요");
		form.phone2.focus();
		form.phone2.value='';
		form.phone3.value='';
		return false;	
	}
	if(!regExpEmail.test(email)){
		alert("이메일 입력을 확인 해주세요");
	    form.email1.focus();
		form.email1.value='';
		form.email2.value='';
		return false;	
	}
	
	if(!isConfirm){
		alert("본인 인증을 해주세요!");
		form.cert.focus();
		return false;
	}
	return true;
}
</script>
<script>
/* id check function() */
function idChk() {
	var id=document.newMember.id.value;
	if(id.length==0){
		alert("아이디를 입력하세요");
		document.newMember.id.focus();
		return;
	}else {
		/* 팝업창 열기 window.open(페이지); <-현재페이지는 opener임. */
		window.open('idCheck.jsp?id='+id);
	}
}
</script>
<script>
function sendEmail(){
	var mailId = document.newMember.mail1.value+'@'+document.newMember.mail2.value;
	//var emailPassword =prompt("이메일 비번을 입력하세요",'');
	var emailPassword = document.getElementById('Emailpassword').value;
	alert(mailId+":"+emailPassword);
	console.log(mailId, emailPassword);
 if(emailPassword.length>0){	
		window.open("certMail.jsp?email="+mailId+"&emailPassword="+emailPassword);
	  } 
}
</script>
<script>
/* 글로벌 변수 */
var isConfirm=false;
function confirm(){
	var cert1 = document.getElementById("cert").value;
	var cert2 = document.getElementById("cert_confirm").value;
	if(cert1.length==0 || cert2.length==0) {
		alert("인증확인 바랍니다.");
	}else if(cert1 != cert2) {
		alert("인증확인 바랍니다.");
	}else{
		alert("인증이 완료되었습니다.");
		isConfirm = true;
	}
}
</script>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>회원가입</title>
</head>
<body>
 <jsp:include page="/menu.jsp"/>
  <div class="jumbotron">
      <div class="container">
      	<h1 class="display-3">회원가입</h1>
      </div>
  </div>
  
  <div class="container">
    <form name="newMember" class="form-horizontal" action="processAddMember.jsp" 
                method="post" onsubmit="return checkForm()"> 
        <div class="form-group row">
              <label class="col-sm-2">아이디</label>
              <div class="col-sm-3">
                   <input name="id" type="text" class="form-control" placeholder="아이디" required>
                    <input type="button" value="아이디 중복검사"  class="btn btn-success" onclick="idChk()">
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
        
        <div class="form-group row">
              <label class="col-sm-2">성별</label>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender" id="inlineRadio1" value="남" checked="checked">
                <label class="form-check-label" for="inlineRadio1">남자</label>
              </div>
              <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" name="gender" id="inlineRadio2" value="여">
              <label class="form-check-label" for="inlineRadio2">여자</label>
              </div>
        </div>

        <div class="form-group row">
              <label class="col-sm-2">생일</label>
              <div class="col-sm-4">
                   <input type="text" name="birthyy" maxlength="4" placeholder="년(4자리)" size="6" required>
                   <select name="birthmm" required>
                   	<option value="">월</option>
                   	<option value="01">1</option>
                   	<option value="02">2</option>
                   	<option value="03">3</option>
                   	<option value="04">4</option>
                   	<option value="05">5</option>
                   	<option value="06">6</option>
                   	<option value="07">7</option>
                   	<option value="08">8</option>
                   	<option value="09">9</option>
                   	<option value="10">10</option>
                   	<option value="11">11</option>
                   	<option value="12">12</option>
                   </select>
                   <input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" required>
              </div>
        </div>
        
       <div class="form-group row">
             <label class="col-sm-2">이메일</label>
             <div class="col-sm-10">
                <input type="text" name="mail1" maxlength="50" required> @
                <input type="text" name="mail2" maxlength="50" required>
                 <select name="mail2_select" onchange="selectDomain(this)">
                    <option disabled="disabled" selected="selected">선택</option>
                    <option>naver.com</option>
                    <option>daum.net</option>
                    <option>gmail.com</option>
                    <option>nate.com</option>
                    <option value="">직접입력</option>
                </select>
             </div>
       </div>
       
        <div class="form-group row">
              <label class="col-sm-2">이메일 인증</label>
              <div class="col-sm-3">
                   <input type="button" value="네이버 메일 인증" class="btn btn-success" data-toggle="modal" data-target="#exampleModal">
                   <input class="form-control" name="cert" type="password" id="cert" value="" readonly>
                   <input class="form-control" name="cert_confirm" id="cert_confirm" type="password" placeholder="인증코드" value="">
                   <input type="button" value="확인" class="btn btn-success" onclick="confirm()">
              </div>
        </div>
        
       <div class="form-group row">
         <label class="col-sm-2">전화번호</label>
         <div class="col-sm-5">
               <select name="phone1" required>
		              <option value="010" selected>010</option>
		              <option value="011">011</option>
		              <option value="016">016</option>
		              <option value="017">017</option>
		              <option value="019">019</option>
		           </select>
				- <input maxlength="4" size="4" name="phone2" required>
				- <input maxlength="4" size="4" name="phone3" required>
         </div>
       </div>
  
  <div class="form-group row">
             <label class="col-sm-2">우편번호</label>
             <div class="col-sm-3">
                 <input name="zipcode" id="zipcode" type="text" class="form-control" placeholder="우편번호" required>
                 <input type="button" onclick="Postcode()" value="우편번호 찾기"><br>
             </div>
         </div>
          <div class="form-group row">
             <label class="col-sm-2">도로명주소</label>
             <div class="col-sm-3">
                 <input name="roadAddress" id="roadAddress"  type="text" class="form-control" placeholder="도로명주소" required>
             </div>
         </div>
         <div class="form-group row">
             <label class="col-sm-2">지번주소</label>
             <div class="col-sm-3">
                 <input name="jibunAddress" id="jibunAddress"  type="text" class="form-control" placeholder="지번주소" required>
             </div>
         </div>
         <span id="guide" style="color:#999;display:none"></span>
         <div class="form-group row">
             <label class="col-sm-2">상세주소</label>
             <div class="col-sm-3">
                 <input name="detailAddress"  id="detailAddress" type="text" class="form-control" placeholder="상세주소" required>
             </div>
         </div>
         <div class="form-group row">
             <label class="col-sm-2">참고항목</label>
             <div class="col-sm-3">
                 <input name="extraAddress"id="extraAddress" type="text" class="form-control" placeholder="참고항목" required>
             </div>
         </div>
       
       <div class="form-gorup row">
          <div class="col-sm-offset-2 col-sm-10">
               <input type="submit" class="btn btn-success" value="등록">
               <input type="reset"  class="btn btn-secondary" value="취소" onclick="reset()">
          </div>
       </div>
    </form>

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">네이버 메일 인증</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">네이버 계정 비밀번호:</label>
            <input type="password" class="form-control" id="Emailpassword" name="emailPassword">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" >닫기</button>
        <button type="button" class="btn btn-success" onclick="sendEmail()">인증코드 받기</button>
      </div>
    </div>
  </div>
</div>    
    
  </div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function Postcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }
                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';
                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
</body>
</html>