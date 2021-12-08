<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mysql.cj.xdevapi.PreparableStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html><html><head>
<meta charset="UTF-8">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script type="text/javascript" src="./resources/js/validation.js"></script>
<title><fmt:message key="updateTitle"/></title>
</head>
<body>
<fmt:setLocale value='<%=request.getParameter("language") %>'/>
<fmt:bundle basename="resourceBundle.message">
<jsp:include page="menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><fmt:message key="updateTitle"/></h1>
		</div>
	</div>
	<%@ include file="dbconn.jsp"%>
	<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
    String sql="select p_manufacturer, name from manufacturer";
	
	pstmt= conn.prepareStatement(sql);
    rs = pstmt.executeQuery();
	List<String> list = new ArrayList<String>();
	while(rs.next()){
		list.add(rs.getString(1)+"-"+rs.getString(2));
	}
	/* for(String s:list)
		System.out.println(s); */
	%>
	<%
    sql="select p_category, name from category";
	pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();
	List<String> cateList = new ArrayList<String>();
	while(rs.next()){
		cateList.add(rs.getString(1)+"-"+rs.getString(2));
	}
/* 	 for(String s:cateList)
		System.out.println(s);  */
	%>
	<%
		String productId = request.getParameter("id");
	
		sql = "select * from product where p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		rs = pstmt.executeQuery();
		if (rs.next()) {
	%>
	<div class="container">
		<div class="row">
		<div class="text-right">
         <a href="?language=ko&id=<%=request.getParameter("id")%>">Korean</a> | <a href="?language=en&id=<%=request.getParameter("id")%>">English</a>
         <a href="logout.jsp" class="btn btn-sm btn-success pull-right">logout</a>
       </div>
			<div class="col-md-5">
				<img src="/resources/upload/<%=rs.getString("p_filename")%>" alt="image" style="width: 100%" />
			</div>
			<div class="col-md-7">
				<form name="newProduct" action="./processUpdateProduct.jsp" class="form-horizontal" method="post" enctype="multipart/form-data">
					<div class="form-group row">
						<label class="col-sm-2">상품 코드</label>
						<div class="col-sm-3">
							<input type="text" id="productId" name="productId" class="form-control" value='<%=rs.getString("p_id")%>' disabled>
							<input type="hidden" id="productId" name="productId" value='<%=rs.getString("p_id")%>'>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">상품명</label>
						<div class="col-sm-3">
							<input type="text" id="name" name="name" class="form-control" value="<%=rs.getString("p_name")%>">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">가격</label>
						<div class="col-sm-3">
							<input type="text" id="unitPrice" name="unitPrice" class="form-control" value="<%=rs.getInt("p_unitPrice")%>">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">상세 설명</label>
						<div class="col-sm-5">
							<textarea name="description" cols="50" rows="2" class="form-control"><%=rs.getString("p_description")%></textarea>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">제조사</label>
						<div class="col-sm-3">
							<select name="manufacturer" class="form-control">
						<%
						for(String s:list)
							out.print("<option value='"+s.substring(0,s.indexOf('-'))+"'>"
						                     +s.substring(s.indexOf('-')+1)+"</option>");
						%>	
						</select>	
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">분류</label>
						<div class="col-sm-3">
							<select name="category" class="form-control">
							<%
							for(String s:cateList)
								out.print("<option value='"+s.substring(0,s.indexOf('-'))+"'>"
							                  +s.substring(s.indexOf('-')+1)+"</option>");
							%>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">재고 수</label>
						<div class="col-sm-3">
							<input type="text" id="unitsInStock" name="unitsInStock" class="form-control" value="<%=rs.getLong("p_unitsInStock")%>">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">상태</label>
						<div class="col-sm-5">
							<input type="radio" name="condition" value="New " <%=rs.getString("p_condition")!=null && rs.getString("p_condition").trim().toLowerCase().equals("new")?"checked":""%> > 신규 제품
							<input type="radio" name="condition" value="Old" <%=rs.getString("p_condition")!=null && rs.getString("p_condition").trim().toLowerCase().equals("old")?"checked":""%>> 중고 제품
							<input type="radio" name="condition" value="Refurbished" <%=rs.getString("p_condition")!=null && rs.getString("p_condition").trim().toLowerCase().equals("refurbished")?"checked":""%>> 재생 제품
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">이미지</label>
						<div class="col-sm-5">
						    <img style="width: 500px;" id="preview-image" >
							<input type="file" name="productImage" id="productImage" class="form-control" >
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-10 ">
							<input type="submit" class="btn btn-primary" value="<fmt:message key="buttonEdit"/>">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%
		}
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	%>
</fmt:bundle>	
</body>
</html>
<script>
function readImage(input) {
    // 인풋 태그에 파일이 있는 경우
    if(input.files && input.files[0]) {
        // 이미지 파일인지 검사 (생략)
        // FileReader 인스턴스 생성
        const reader = new FileReader()
        // 이미지가 로드가 된 경우
        reader.onload = e => {
            const previewImage = document.getElementById("preview-image")
            previewImage.src = e.target.result
        }
        // reader가 이미지 읽도록 하기
        reader.readAsDataURL(input.files[0])
    }
}
// input file에 change 이벤트 부여
const inputImage = document.getElementById("productImage")
inputImage.addEventListener("change", e => {readImage(e.target)})
</script>