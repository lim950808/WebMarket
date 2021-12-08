<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/dbconn.jsp" %>
<%
	String id = request.getParameter("id");

	String sql = "select count(*) from member where id = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	//id에 해당하는 결과가 없으면 0이 리턴, 있으면 1이 리턴
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()) {
		if(rs.getInt(1) > 0) {
%>
	<script>
		alert('이미 존재하는 아이디 입니다.');
			opener.member.id.value = '';
			opener.member.id.focus();
			self.close(); /*자신을 닫는 함수*/
	</script>
	<%}else {%>
		<script>alert("가입 가능한 아이디 입니다.");
			window.close();
		</script>
		<%}
		}%>