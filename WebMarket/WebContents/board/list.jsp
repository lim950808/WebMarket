<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html><html><head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<script>
function checkForm(){
	if(${sessionScope.sessionId==null}){
		alert("로그인 해주세요");
		return false;
	}
	location.href="./BoardWriteForm.do?id=${sessionScope.sessionId}";
}
</script>
<title>게시판</title>
</head>
<body>
<jsp:include page="../menu.jsp"/>
<div class="jumbotron">
   <div class="container">
      <h1 class="display-3">게시판</h1>
   </div>
</div>
<div class="container">
  <form action="<c:url value="./BoardListAction.do"/>" method="post">  
    <div>
      <div class="text-right">
             <span class="badge badge-success">전체 ${total_record}</span>
      </div>
    </div>
    <div style="padding-top:50px">
       <table class="table table-hover">
            <tr>
             <th>번호</th>
             <th>제목</th>
             <th>작성일</th>
             <th>조회</th>
             <th>글쓴이</th>
            </tr>
     
   <c:if test="${not empty boardlist }">
     <c:forEach items="${boardlist}"  var="notice">          
        <tr>
         <td>${notice.num}</td>
         <td><a href="./BoardViewAction.do?num=${notice.num}&pageNum=${pageNum}&items=${items}&text=${text}">${notice.subject}</a></td>
         <td>${notice.regist_day}</td>
         <td>${notice.hit}</td>
         <td>${notice.name}</td>
        </tr>        	    	       
      </c:forEach>
   </c:if>  
    
       </table>
       
    </div><!-- 페이지별 게시글 리스트 출력 영역 끝. -->
   <div align="center">
     <c:set var="pageNum" value="${pageNum}"/>
   <nav aria-label="...">
   <ul class="pagination justify-content-center">
  
   <c:if test="${startPage-1==1 }">
   <li class="page-item  disabled"> 
     <a  class="page-link" href="<c:url value="./BoardListAction.do?pageNum=${startPage-1}"/>">Previous</a> 
    </li>
   </c:if>
   <c:if test="${startPage-1>1 }">
    <li class="page-item"> 
     <a  class="page-link" href="<c:url value="./BoardListAction.do?pageNum=${startPage-1}&items=${items}&text=${text}"/>">Previous</a> 
    </li>
  </c:if>
      
     <c:forEach var="i" begin="${startPage}" end="${endPage}">
         <c:choose>
            <c:when test="${pageNum==i }">
                 <li class="page-item active" aria-current="page">
                    <a class="page-link" href="<c:url value="./BoardListAction.do?pageNum=${i}&items=${items}&text=${text}"/>">${i}</a>
                  </li>
            </c:when>
            <c:otherwise>
                   <li class="page-item"><a class="page-link" href="<c:url value="./BoardListAction.do?pageNum=${i}&items=${items}&text=${text}"/>">${i}</a></li>
            </c:otherwise>
         </c:choose>
     </c:forEach>
     <c:if test="${endPage+1==finalPage }">
   <li class="page-item  disabled"> 
     <a  class="page-link" href="<c:url value="./BoardListAction.do?pageNum=${endPage+1}&items=${items}&text=${text}"/>">Next</a> 
    </li>
   </c:if>
   <c:if test="${endPage+1 < finalPage }">
    <li class="page-item"> 
     <a  class="page-link" href="<c:url value="./BoardListAction.do?pageNum=${endPage+1}&items=${items}&text=${text}"/>">Next</a> 
    </li>
  </c:if>
   </ul>
</nav>
   </div>
   <div align="left">
      <table>
        <tr>
         <td width="100%" align="left">&nbsp;&nbsp;
          <select name="items" class="txt">
                <option value="subject"  <c:if test="${items=='subject'}">selected</c:if>>제목에서</option>
                <option value="content" <c:if test="${items=='content'}">selected</c:if>>본문에서</option>
                <option value="name" <c:if test="${items=='name'}">selected</c:if> >글쓴이에서</option>
          </select>
                <input name="text" type="search" value="${text}">
                <input type="submit" id="btnAdd" class="btn btn-primary" value="검색">
         </td>
         <td width="100%" align="right">
        <a href="#" onclick="checkForm(); return false;" class="btn btn-primary">&laquo;글쓰기</a>
         </td>
        </tr>
      </table>
   </div>
  </form> 
  <hr>
</div>
<jsp:include page="../footer.jsp"/>
</body>
</html>