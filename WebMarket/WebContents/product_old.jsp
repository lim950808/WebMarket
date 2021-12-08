<%@page import="dao.ProductRepository"%>
<%@page import="dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 서버와 접속후 브라우저 종료전까지 모든페이지에서 사용가능한 session범위로 지정 -->
<%--     <jsp:useBean id="productDAO" class="dao.ProductRepository" scope="session" /> --%>
<% ProductRepository productDAO = ProductRepository.getInstance(); %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품정보</h1>
		</div>
	</div>
	<%
		String id = request.getParameter("id");
		Product product = productDAO.getProductById(id);
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="./resources/images/<%=product.getFilename() %>" style="width: 100%">
			</div>
			<div class="col-md-6">
				<h3><%=product.getPname() %></h3>
				<p><%=product.getDescription() %>
				<p><b>상품코드: </b><span class="badge badge-danger"><%=product.getProductId() %></span>
				<p><b>제조사</b>: <%=product.getManufacturer() %>
				<p><b>분류</b>: <%=product.getCategory() %>
				<p><b>재고 수</b>: <%=product.getUnitsInStock() %>
				<h4><%=product.getUnitPrice() %>원</h4>
				<p><a href="#" class="btn btn-info">상품주문 &raquo;</a>
				   <a href="./products.jsp" class="btn btn-secondary">상품목록 &raquo;</a>
			</div>
		</div>
	</div>
<jsp:include page="footer.jsp"/>
</body>
</html>