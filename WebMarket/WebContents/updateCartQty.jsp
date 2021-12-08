<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%><%@page import="java.util.ArrayList"%><%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%><%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%
   String id = request.getParameter("id");
   String sQty = request.getParameter("qty");
   int qty = Integer.parseInt(sQty);
   
 //넘어온 파라미터가 없으면 products.jsp로 이동처리
   if(id == null || id.trim().equals("")) {
 	   response.sendRedirect("products.jsp");
 	   return;
   }
   String sql="select * from product where p_id=?";
   PreparedStatement pstmt=conn.prepareStatement(sql);
   pstmt.setString(1,id);
   ResultSet rs  = pstmt.executeQuery();
    
   Product goods =null;
   //id에 해당하는 상품정보 얻기 
   //상품정보없으면 에러페이지로 이동 처리
   if(!rs.next()) { 
 	  response.sendRedirect("exceptionNoProductId.jsp");
    }else {    
   //상품등록리스트에서 상품정보 얻기
      goods = new Product(id,rs.getString("p_name"),rs.getInt("p_unitPrice")); 
   }
  
  //세션으로부터 장바구니 정보 얻기
  ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
  Product goodsQnt = new Product();
  //장바구니에서 해당 id의 상품 삭제 처리
  for(int i=0;i<cartList.size();i++) {
	   goodsQnt = cartList.get(i);
	   if(goodsQnt.getProductId().equals(id)) {
		  goodsQnt.setQuantity(qty);
	   }
  }
  
  //카트페이지로 이동하여 삭제후 내역확인
  //response.sendRedirect("cart.jsp");
%>
<script>
  alert("장바구니 수량을 수정하였습니다");
  location.href="cart.jsp";
</script>