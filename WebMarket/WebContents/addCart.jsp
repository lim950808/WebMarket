<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%
  String id = request.getParameter("id");
  String sQty = request.getParameter("qty");
  int qty = Integer.parseInt(sQty);
  
//넘어온 파라미터가 없으면 products.jsp로 이동처리
  if(id == null || id.trim().equals("")){
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
  if(!rs.next()){ 
	  response.sendRedirect("exceptionNoProductId.jsp");
   }else{    
  //상품등록리스트에서 상품정보 얻기
     goods = new Product(id,rs.getString("p_name"),rs.getInt("p_unitPrice")); 
  }
  
  //세션으로부터 장바구니 객체 얻기
  ArrayList<Product> list =(ArrayList<Product>)session.getAttribute("cartlist");
  //장바구나 없으면 새로 생성
  if(list==null){
	  list = new ArrayList<Product>();//장바구니 리스트 신규생성
	  session.setAttribute("cartlist", list);//빈 장바구니를 세션에 추가
  }
  //장바구니 저장 갯수 선언
  int cnt=0;
  Product goodsQnt = new Product();
  //장바구니에서
  for(int i=0;i<list.size();i++){
	  goodsQnt = list.get(i);
	  if(goodsQnt.getProductId().equals(id)){//해당id상품이 이미 존재하면
		  cnt++;//수량증가
		  int orderQuantity = goodsQnt.getQuantity()+qty;//상품정보의 장바구니속성을 1증가
		  goodsQnt.setQuantity(orderQuantity);//
	  }
  }
    //cnt가 0이란건 장바구니에 해당 상품이 없다는 것임.
    if(cnt==0){
    	goods.setQuantity(qty);//최초갯수 1 개 설정
    	list.add(goods);//장바구니에 수량1로 추가
    }
    //다시 원래 상세 페이지로 이동처리
    response.sendRedirect("product.jsp?id=" +id);
    //out.print("<script>location.href='product.jsp?id="+id+"'</script>");
%>