<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
	String sessionId = (String)session.getAttribute("sessionId");
    String currentPassword =request.getParameter("currentPassword");
    String newPassword =request.getParameter("newPassword");
%>
<%--데이타 셋 설정 --%>
<sql:setDataSource  var="dataSource"   
      url="jdbc:mysql://localhost:3306/WebMarketDB"
      user="director" password="director"
      driver="com.mysql.cj.jdbc.Driver" />
      
<%--id,password 에 맞는 회원정보를 db에서 추출 --%>
<sql:query dataSource="${dataSource}" var="resultSet" >
	select * from member where id=? and password=?
	<sql:param value="<%=sessionId%>" />
	<sql:param value="<%=currentPassword%>"/>
</sql:query>

<%--출력 결과 처리, session에 id정보 저장 후, 결과 페이지로 이동(get방식) --%>
<c:forEach var="row" items="${resultSet.rows}" >
	<sql:update dataSource="${dataSource}" var="result" >
		update member set password=? where id=? 
		<sql:param value="<%=newPassword%>"/>
		<sql:param value="<%=sessionId%>" />
	</sql:update>
	<script>alert('비밀번호가 변경되었습니다.');</script>
	<script>window.close();</script> 
</c:forEach>