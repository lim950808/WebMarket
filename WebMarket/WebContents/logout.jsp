<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	session.invalidate();
	response.sendRedirect("addProduct.jsp");
%>