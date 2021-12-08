<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script type="text.javascript" src="./resources/js/validation.js"></script>
<title>Insert title here</title>
</head>
<script>
	function chk() {
		var productId = document.getElementById("productId");
		var unitPrice = document.getElementById("unitPrice");
		var unitsInStock = document.getElementById("unitsInStock");
		//상품 아이디 체크 {m,n}: m~n개, {m,}: m개 이상, {,n}: n개 이하
		//if(!check(/^P[0-9]{4,11}$/, productId, "[상품코드]\nP와 숫자를 조합하여 5~12자까지 입력하세요.\n첫 글자는 반드시 '대문자 P'로 시작하세요.")) {
			//return false;
		//}
		상품 가격 체크
		/if(unitPrice.value.length==0 || isNaN(unitPrice.value)) {
			alert("[가격]\n숫자만 입력하세요.");
			unitPrice.select();
			unitPrice.focus();
			return false;
		}
		//
		if(unitPrice.value < 0) {
			alert("[가격]\n음수를 입력할 수 없습니다.");
			unitPrice.select();
			unitPrice.focus();
			return false;
		}else if(!check(/^\d+(?:[.]?[\d]?[\d])?$/, unitPrice, "[가격]\n'소수점 둘째자리' 까지만 입력하세요.")) {
			return false;
		}
		//재고 수 체크
		if(unitsInStock.value.length==0 || isNaN(unitsInStock.value)) {
			alert("[재고 수]\n숫자만 입력하세요.");
			unitsInStock.select();
			unitsInStock.focus();
			return false;
		}
		//
		if(unitsInStock.value < 0) {
			alert("[재고 수]\n음수를 입력할 수 없습니다.");
			unitsInStock.select();
			unitsInStock.focus();
			return false;
		}
		
		document.newProduct.submit();
	}
	/* check(정규표현식, element, 메세지) */
	function check(regExp, e, msg) {
		if(regExp.test(e.value)) { //정규표현식 객체 regExp.test(값); 정규표현식 규칙에 맞으면 true, 아니면 false를 리턴하는 함수
			return true;
		}
		alert(msg);
		e.select();
		e.focus();
		return false;
	}
</script>

<body>
<fmt:setLocale value='<%=request.getParameter("language") %>'/>
<fmt:bundle basename="resourceBundle.message">
<jsp:include page="menu.jsp"/>
<div class="jumbotron">
  <div class="container">
     <h1 class="display-3"><fmt:message key="title"/></h1>
  </div>
</div>
<div class="container">
	<%@ include file = "dbconn.jsp" %>
	
	<div class="text-right">
		<a href="?language=ko">Korean</a> | <a href="?language=en">English</a>
		<a href="logout.jsp" class="btn btn-sm btn-success pull-right">Logout</a>
	</div>
	
	  <form name="newProduct" action="./processAddProduct.jsp" class="form-horizontal" 
	        method="post" enctype="multipart/form-data">
	    <div class="form-group row">
	       <label class="col-sm-2"><fmt:message key="productId"/></label>
	       <div class="col-sm-3">
	         <input type="text" name="productId" id="productId" class="form-control" disabled="disabled">
	       </div>
	    </div>
	   <div class="form-group row">
	       <label class="col-sm-2"><fmt:message key="pname"/></label>
	       <div class="col-sm-3">
	       <%--페이지 출력시 name태그에 자동 으로 커서이동 처리 autofocus() --%>
	         <input type="text" name="name" class="form-control"  autofocus required>
	       </div>
	    </div>
	    
	  <div class="form-group row">
	       <label class="col-sm-2"><fmt:message key="unitPrice"/></label>
	       <div class="col-sm-3">
	         <input type="text" name="unitPrice" id="unitPrice" class="form-control" required>
	       </div>
	   </div>
	    <div class="form-group row">
	       <label class="col-sm-2"><fmt:message key="description"/></label>
	       <div class="col-sm-5">
	         <textarea rows="2" cols="50" name="description" class="form-control" required></textarea>
	       </div>
	   </div>
	   <%
		PreparedStatement pstmt = conn.prepareStatement("select p_manufacturer, name from manufacturer");
		ResultSet rs = pstmt.executeQuery();
	   %>
	   <div class="form-group row">
	       <label class="col-sm-2"><fmt:message key="manufacturer"/></label>
	       <div class="col-sm-3">
		       	<select name="manufacturer" class="form-control" required>
		       		<%
		       			while(rs.next()) {
		       				out.print("<option value=" + rs.getString(1) + ">" + rs.getString(2) + "</option>");
		       			}
		       		%>
		       	</select>
	       </div>
	   </div>
	  <div class="form-group row">
	       <label class="col-sm-2"><fmt:message key="category"/></label>
	       <div class="col-sm-3">
		       <select name="manufacturer" class="form-control" required>
		       		<%
			       		pstmt = conn.prepareStatement("select p_category, name from category");
			    		rs = pstmt.executeQuery();
		       			while(rs.next()) {
		       				out.print("<option value='" + rs.getString(1) + "'>" + rs.getString(2) + "</option>");
		       			}
		       		%>
		       	</select>
	       </div>
	   </div>
	   
	   <div class="form-group row">
	       <label class="col-sm-2"><fmt:message key="unitsInStock"/></label>
	       <div class="col-sm-3">
	         <input type="text" name="unitsInStock"  id="unitsInStock" class="form-control" required>
	       </div>
	   </div>
	   <div class="form-group row">
	       <label class="col-sm-2"><fmt:message key="condition"/></label>
	       <div class="col-sm-5">
	         <input type="radio" name="condition" value="New " checked="checked"><fmt:message key="condition_New"/>
	         <input type="radio" name="condition" value="Old "><fmt:message key="condition_Old"/>
	         <input type="radio" name="condition" value="Refurbished "><fmt:message key="condition_Refurbished"/>
	       </div>
	   </div>
	   <div class="form-group row">
	      <label class="col-sm-2"><fmt:message key="productImage"/></label>
	       <div class="col-sm-5">
	         <img style="width: 500px;" id="preview-image" >
	         <input type="file" name="productImage" class="form-control" id="input-image">
	       </div>
	   </div>
	   
	   <div class="form-group row">
	       <div class="col-sm-offset-2 col-sm-10">
	         <input type="submit" value="<fmt:message key="button"/>" class="btn btn-primary" onclick="return chk()">
	       </div>
	   </div>
	  </form>
</div>
</fmt:bundle>

<hr>
<jsp:include page="footer.jsp"/>
</body>
</html>

<script>
	function readImage(input) {
	    // 인풋 태그에 파일이 있는 경우
	    if(input.files && input.files[0]) {
	        // 이미지 파일인지 검사 (생략)
	        // FileReader 인스턴스 생성
	        const reader = new FileReader()
	        // 이미지가 로드가 된 경우
	        reader.onload = e => {
	            const previewImage = document.getElementById("preview-image")
	            previewImage.src = e.target.result
	        }
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0])
	    }
	}
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("input-image")
	inputImage.addEventListener("change", e => {readImage(e.target)})
</script>