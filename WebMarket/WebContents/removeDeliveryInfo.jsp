<%@page import="java.sql.PreparedStatement"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%  
	request.setCharacterEncoding("utf-8");
	String seq = request.getParameter("seq");
%>
<%@ include file="dbconn.jsp" %>
<%
  String sql="delete from delivery where seq = ?";
  PreparedStatement pstmt = conn.prepareStatement(sql);
  pstmt.setInt(1, Integer.parseInt(seq));
  
  int result = pstmt.executeUpdate();
  if(result > 0) {
	 out.print("<script>alert('배송지 정보 수정 완료');</script>");  
	 out.print("<script>location.href='listDelivery.jsp';</script>");
  }else {
	  out.print("<script>alert('배송지 정보 수정 실패');</script>");
	  out.print("<script>history.go(-1);</script>");
  }
%>