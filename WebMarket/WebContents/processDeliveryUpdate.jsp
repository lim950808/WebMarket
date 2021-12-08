<%@page import="org.w3c.dom.html.HTMLDivElement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%  
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="deliveryInfo" class="dto.Delivery"/>
<jsp:setProperty property="*" name="deliveryInfo"/>
<%@ include file="dbconn.jsp" %>
<%
  String sql="update delivery set nickName=?,country=?,zipcode=?,roadAddress=?,jibunAddress=?,detailAddress=?,extraAddress=? where seq=?";
  PreparedStatement pstmt =conn.prepareStatement(sql);
  pstmt.setString(1,deliveryInfo.getName());
  pstmt.setString(2,deliveryInfo.getCountry());
  pstmt.setString(3,deliveryInfo.getZipcode());
  pstmt.setString(4,deliveryInfo.getRoadAddress());
  pstmt.setString(5,deliveryInfo.getJibunAddress());
  pstmt.setString(6,deliveryInfo.getDetailAddress());
  pstmt.setString(7,deliveryInfo.getExtraAddress());
  pstmt.setInt(8, deliveryInfo.getSeq());
  
  int result = pstmt.executeUpdate();
  if(result>0){
	 out.print("<script>alert('배송지 정보 수정 완료');</script>");  
	 out.print("<script>location.href='listDelivery.jsp';</script>");
  }else{
	  out.print("<script>alert('배송지 정보 수정 실패');</script>");
	  out.print("<script>history.go(-1);</script>");
  }
%>