<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%
	/* 파라미터로 넘어온 값 얻기, 문자셋 설정 */
	request.setCharacterEncoding("UTF-8");
    
    String id = request.getParameter("id");
    String password = request.getParameter("password");
%>
<%--데이타 셋 설정 --%>
<sql:setDataSource  var="dataSource"   
      url="jdbc:mysql://localhost:3306/WebMarketDB"
      user="director" password="director"
      driver="com.mysql.cj.jdbc.Driver" />
      
<%--id,password 에 맞는 회원정보를 db에서 추출 --%>
<sql:query dataSource="${dataSource}" var="resultSet" >
  select * from member where id=? and password=?
  <sql:param value="<%=id%>" />
  <sql:param value="<%=password %>"/>
</sql:query>

<%--출력 결과 처리, session에 id정보 저장 후, 결과 페이지로 이동(get방식) --%>
<c:forEach var="row" items="${resultSet.rows}" >
      <%
      	 session.setAttribute("sessionId",id);
      %>
      <c:redirect url="resultMember.jsp?msg=2"/>
</c:forEach>

<%-- 조회 결과 데이타가 없으면 다시 로그인 페이지로 이동,이동시 error의 파라미터값을 1로 전달. --%>
<c:redirect url="loginMember.jsp?error=1"/>