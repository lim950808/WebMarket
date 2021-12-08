<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
<%
String shipping_cartId=""; 
String shipping_name=""; 
String shipping_shippingDate=""; 
String shipping_country=""; 
String shipping_zipCode=""; 
String shipping_roadAddress=""; 
String shipping_jibunAddress=""; 
String shipping_detailAddress=""; 
String shipping_extraAddress="";	
//쿠키정보 얻기
Cookie[] cookies = request.getCookies();
if(cookies!=null){
	for(int i=0;i<cookies.length;i++){
		Cookie thisCookie = cookies[i];
		String n=thisCookie.getName();
		if(n.equals("Shipping_cartId"))
			shipping_cartId = URLDecoder.decode(thisCookie.getValue(),"utf-8");
		if(n.equals("Shipping_name"))
			shipping_name = URLDecoder.decode(thisCookie.getValue(),"utf-8");
		if(n.equals("Shipping_shippingDate"))
			shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(),"utf-8");
		if(n.equals("Shipping_country"))
			shipping_country = URLDecoder.decode(thisCookie.getValue(),"utf-8");
		
		if(n.equals("Shipping_zipCode"))
			shipping_zipCode = URLDecoder.decode(thisCookie.getValue(),"utf-8");
		if(n.equals("Shipping_roadAddress"))
			shipping_roadAddress = URLDecoder.decode(thisCookie.getValue(),"utf-8");
		if(n.equals("Shipping_jibunAddress"))
			shipping_jibunAddress = URLDecoder.decode(thisCookie.getValue(),"utf-8");
		if(n.equals("Shipping_detailAddress"))
			shipping_detailAddress = URLDecoder.decode(thisCookie.getValue(),"utf-8");
		if(n.equals("Shipping_extraAddress"))
			shipping_extraAddress = URLDecoder.decode(thisCookie.getValue(),"utf-8");  
	}
}
%>
<%-- <%=shipping_cartId%><br> 
<%=shipping_name%><br>
<%=shipping_shippingDate%><br> 
<%=shipping_country%><br>
<%=shipping_zipCode%><br> 
<%=shipping_roadAddress%><br> 
<%=shipping_jibunAddress%><br> 
<%=shipping_detailAddress%><br> 
<%=shipping_extraAddress%><br> --%>
<jsp:include page="menu.jsp"/>
<div class="jumbotron">
    <div class="container">
      <h1 class="display-3">주문 완료</h1>
    </div>
</div>
<div class="container" >
   <h2 class="alert alert-success">주문해주셔서 감사합니다.</h2>
   <p> 주문은 <%=shipping_shippingDate %>에 배송될 예정입니다!
   <p> 주문번호:<%=shipping_cartId %>
</div>
 <div class="container">
  <p><a href="./products.jsp" class="btn btn-secondary">&laquo; 상품 목록</a>
 </div>
<!--쿠키 삭제하기  -->
<%
  //세션에서 장바구니 삭제
  session.invalidate();
  //쿠키 삭제
  for(int i=0;i<cookies.length;i++){
		Cookie thisCookie = cookies[i];
		String n=thisCookie.getName();
		if(n.equals("Shipping_cartId"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_name"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_shippingDate"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_country"))
			thisCookie.setMaxAge(0);
		
		if(n.equals("Shipping_zipCode"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_roadAddress"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_jibunAddress"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_detailAddress"))
			thisCookie.setMaxAge(0);
		if(n.equals("Shipping_extraAddress"))
			thisCookie.setMaxAge(0); 
		
		//응답객체에 실어서 브라우저로 전송 - 삭제처리
		response.addCookie(thisCookie);
	}
%> 
<jsp:include page="footer.jsp"/>
</body>
</html>