<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>배송 정보</title>
<script>
function registerDelivery(){
  location.href="registerDelivery.jsp";	
}
</script>
<script>
function listDelivery(){
	window.open("listDelivery.jsp","배송지리스트","toolbar=yes, scrollbars=yes, resizable=yes, top=50, left=50, width=960,height=640");
}
</script>
</head>
<body>
<jsp:include page="menu.jsp" />
<div class="jumbotron">
   <div class="container">
   		<h1 class="display-3">배송 정보</h1>
   </div>
</div>
<%@include file="dbconn.jsp" %>
<%
    String sql="select max(ifnull(seq,'')) seq ,max(ifnull(nickname,'')) nickName, "
              +" max(ifnull(country,'')) country, max(ifnull(zipcode,'')) zipcode, "
              +" max(ifnull(roadAddress,'')) roadAddress, max(ifnull(jibunAddress,'')) jibunAddress, "
              +" max(ifnull(detailAddress,'')) detailAddress, max(ifnull(extraAddress,'')) extraAddress "
    		  +" from delivery where seq=1";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs=pstmt.executeQuery();
	if(rs.next()){
%>
<div class="container">
   <form name="frm" action="./processShippingInfo.jsp" class="form-horizontal" method="post">
         <input type="hidden" name="cartId" value="<%=request.getParameter("cartId") %>">
         <div class="form-group row">
             <label class="col-sm-2">배송지 명</label>
             <div class="col-sm-3">
                 <input name="name" type="text" class="form-control" value="<%=rs.getString("nickName")!=null?rs.getString("nickName"):""%>">
                 <input type="button" value="배송지등록" class="btn btn-primary" onclick="registerDelivery()">
                 <input type="button" value="배송지리스트" class="btn btn-success" onclick="listDelivery()">
             </div>
         </div>
         <div class="form-group row">
             <label class="col-sm-2">배송일</label>
             <div class="col-sm-3">
                 <input name="shippingDate" type="text" class="form-control">(yyyy/mm/dd)
             </div>
         </div>
         <div class="form-group row">
             <label class="col-sm-2">국가</label>
             <div class="col-sm-3">
                 <input name="country" type="text" class="form-control" value="<%=rs.getString("country")!=null?rs.getString("country"):""%>">
             </div>
         </div>
         <div class="form-group row">
             <label class="col-sm-2">우편번호</label>
             <div class="col-sm-3">
                 <input name="zipcode" id="zipcode" type="text" class="form-control" value="<%=rs.getString("zipcode")!=null?rs.getString("zipcode"):""%>">
                 <input type="button" onclick="Postcode()" value="우편번호 찾기"><br>
             </div>
         </div>
          <div class="form-group row">
             <label class="col-sm-2">도로명주소</label>
             <div class="col-sm-3">
                 <input name="roadAddress" id="roadAddress"  type="text" class="form-control" value="<%=rs.getString("roadAddress")!=null?rs.getString("roadAddress"):""%>">
             </div>
         </div>
         <div class="form-group row">
             <label class="col-sm-2">지번주소</label>
             <div class="col-sm-3">
                 <input name="jibunAddress" id="jibunAddress"  type="text" class="form-control" value="<%=rs.getString("jibunAddress")!=null?rs.getString("jibunAddress"):""%>">
             </div>
         </div>
         <span id="guide" style="color:#999;display:none"></span>
         <div class="form-group row">
             <label class="col-sm-2">상세주소</label>
             <div class="col-sm-3">
                 <input name="detailAddress"  id="detailAddress" type="text" class="form-control" value="<%=rs.getString("detailAddress")!=null?rs.getString("detailAddress"):""%>">
             </div>
         </div>
         <div class="form-group row">
             <label class="col-sm-2">참고항목</label>
             <div class="col-sm-3">
                 <input name="extraAddress"id="extraAddress" type="text" class="form-control" value="<%=rs.getString("extraAddress")!=null?rs.getString("extraAddress"):""%>">
             </div>
         </div>
         <div class="form-group row">
             <div class="col-sm-offset-2 col-sm-10">
                <a href="./cart.jsp?cartId=<%=request.getParameter("cartId")%>" 
                             class="btn btn-secondary" role="button">이전</a>
                <input type="submit" class="btn btn-primary" value="등록">
                <a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button">취소</a>             
             </div>
         </div>
    <% }%>
   </form>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
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