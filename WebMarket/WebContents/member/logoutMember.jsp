<%@ page contentType="text/html; charset=UTF-8"%>
<%
	/* 로그인정보 삭제 */
	session.invalidate();
	/* 다시 로그인 페이지로 이동처리 */
	response.sendRedirect("loginMember.jsp");
%>