<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="dto.RecentProduct"%><%@page import="dao.ProductRepository"%><%@page import="dto.Product"%><%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>        
<!DOCTYPE html><html><head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
<meta charset="UTF-8">
<fmt:setLocale value='<%=request.getParameter("language") %>'/>
<fmt:bundle basename="resourceBundle.message">
<title><fmt:message key="editTitle"/></title>
<script>
function deleteConfirm(id){
	if(confirm("해당상품을 삭제합니다!!")){
		location.href="./deleteProduct.jsp?id="+id;
	}else
		return;
}
</script>
<script>
$(document).ready(function(){
	$('#deleteModal').click(function(){
		alert($('#pid').val());
		alert("클릭");
	});
	
});
</script>
</head>
<%
	String edit = request.getParameter("edit");
%>
<body>
<jsp:include page="menu.jsp"/>
<div class="jumbotron">
  <div class="container">
     <h1 class="display-3"><fmt:message key="editTitle"/></h1>
  </div>
</div>
<div class="container">
	<div class="text-right">
         <a href="?language=ko&edit=update">Korean</a> | <a href="?language=en&edit=update">English</a>
   </div>
   <div class="row" align="center">
    <%@ include file="dbconn.jsp" %>
     <%  /* DB로 부터 상품 정보 리스트 얻기 */
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select * from product order by p_id";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        while(rs.next()){   
      %>
      <div class="col-md-4">
        <img src="/resources/upload/<%=rs.getString("p_fileName")%>"  style="width:100%">
        <h3><%=rs.getString("p_name") %></h3>
        <p><%=rs.getString("p_description") %></p>
        <p><fmt:formatNumber value='<%=rs.getInt("p_unitPrice") %>'/>원</p>
        <!-- 수정페이지로 이동, 링크태그 이동은 get방식 이동 -->
        <p><%
        	  if(edit.equals("update")){
            %>
            <a href="./updateProduct.jsp?id=<%=rs.getString("p_id") %>"
               class="btn btn-success" role="button"><fmt:message key="buttonEdit"/> &raquo;</a>		  
        </p>
        </div>	
        	<%
        	  } else if(edit.equals("delete")){
            %>
            <a href="#" onclick='deleteConfirm("<%=rs.getString("p_id")%>")' 
               class="btn btn-danger" role="button" data-toggle="modal" data-target="#myModal"><fmt:message key="buttonDelete"/> &raquo;</a>
             <input type="hidden" id="pid" value="<%=rs.getString("p_id")%>">                 
            <div class="container">
 

  <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          해당상품을 삭제합니다!!
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" id="deleteModal" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
  
</div>   
      </div>
       <%
          }/*if else 끝.  */
        }/* while끝. */
         if(rs!=null) rs.close();
         if(pstmt!=null) pstmt.close();
         if(conn!=null) conn.close();
       %>
   </div>
   <hr>   
</div>
</fmt:bundle>
<jsp:include page="footer.jsp"/>
<div id="recentPanel" 
     class="card bg-light mb-3" 
      style="position:fixed; max-width:18rem; top:55px; right:50px;">
  <h5 class="card-header">최근 본 상품</h5>
  <div>
    <ul>
<%
ArrayList<RecentProduct> recentProducts 
=(ArrayList<RecentProduct>)session.getAttribute("recentProducts");
if(recentProducts!=null) {
	for(int i=0;i<recentProducts.size();i++){
		RecentProduct recentProduct= recentProducts.get(i);
		out.print("<li><a href='product.jsp?id="+recentProduct.getProductId()+"'>"
		           +recentProduct.getPname()+"</a></li>");
	}
}
%>
    </ul>
  </div>
</div>
</body>
</html>