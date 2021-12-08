<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String id = request.getParameter("cartId");
	//카트아이디 파라미터가 없으면 cart.jsp페이지로 이동처리
	if(id==null || id.trim().equals("")) {
		response.sendRedirect("cart.jsp");
		return;
	}
	
	//카트아이디에 해당하는 세션정보 삭제처리
	session.invalidate();
	
	response.sendRedirect("cart.jsp");
%>