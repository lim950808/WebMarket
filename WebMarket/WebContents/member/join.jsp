<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	
	Date currentDatetime = new Date(System.currentTimeMillis());
%>
<jsp:useBean id="member" class="MemberDTO" scope="page"/>

<jsp:setProperty name="member" property="memberId"/>
<jsp:setProperty name="member" property="memberPassword"/>
<jsp:setProperty name="member" property="memberName"/>
<jsp:setProperty name="member" property="memberReg_date"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<%
	String Id = null;
	
	if(member.getId()==null || member.getPassword()==null || member.getName()==null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('모든 정보를 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		MemberDTO memberDto = new MemberDTO();
		int result = MemberDTO.join(member);
		System.out.println(result);
		if(result==1){
		session.setAttribute("Id", member.getId());
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("입력성공");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}else if(result==-2){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('입력에 실패 하였습니다')");
		script.println("history.back()");
		script.println("</script>");		
	}
%>