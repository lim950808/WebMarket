<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html><html><head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<script>
function checkForm(){
	console.log('${sessionScope.sessionId}');
	if(${sessionScope.sessionId==null}){
		$('#myModal').modal('show');
	}else{
		location.href="./BbsWriteForm.go?id=${sessionScope.sessionId}&pageNum=${pageNum}&items=${items}&text=${text}";
	}	
}
</script>
<title>bbs</title>
</head>
<body>
<jsp:include page="../menu.jsp"/>
<div class="jumbotron">
   <div class="container">
      <h1 class="display-3">bbs</h1>
   </div>
</div>
<div class="container">
  <form action="<c:url value="./BbsListAction.go"/>" method="post">  
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
     
   <c:if test="${not empty bbslist }">
     <c:forEach items="${bbslist}"  var="bbs">          
        <tr>
         <td>${bbs.num}</td>
         <td>
         <c:forEach var="blank" begin="1" end="${bbs.re_level}">
         <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-reply" viewBox="0 0 16 16">
  <path d="M6.598 5.013a.144.144 0 0 1 .202.134V6.3a.5.5 0 0 0 .5.5c.667 0 2.013.005 3.3.822.984.624 1.99 1.76 2.595 3.876-1.02-.983-2.185-1.516-3.205-1.799a8.74 8.74 0 0 0-1.921-.306 7.404 7.404 0 0 0-.798.008h-.013l-.005.001h-.001L7.3 9.9l-.05-.498a.5.5 0 0 0-.45.498v1.153c0 .108-.11.176-.202.134L2.614 8.254a.503.503 0 0 0-.042-.028.147.147 0 0 1 0-.252.499.499 0 0 0 .042-.028l3.984-2.933zM7.8 10.386c.068 0 .143.003.223.006.434.02 1.034.086 1.7.271 1.326.368 2.896 1.202 3.94 3.08a.5.5 0 0 0 .933-.305c-.464-3.71-1.886-5.662-3.46-6.66-1.245-.79-2.527-.942-3.336-.971v-.66a1.144 1.144 0 0 0-1.767-.96l-3.994 2.94a1.147 1.147 0 0 0 0 1.946l3.994 2.94a1.144 1.144 0 0 0 1.767-.96v-.667z"/>
</svg>
      </c:forEach>
         <a href="./BbsViewAction.go?firstNum=${firstNum}&lastNum=${lastNum}&num=${bbs.num}&pageNum=${pageNum}&items=${items}&text=${text}">${bbs.subject}</a></td>
         <td>${bbs.reg_date}</td>
         <td>${bbs.readcount}</td>
         <td>${bbs.writer}</td>
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
     <a  class="page-link" href="<c:url value="./BbsListAction.go?pageNum=${startPage-1}"/>">Previous</a> 
    </li>
   </c:if>
   <c:if test="${startPage-1>1 }">
    <li class="page-item"> 
     <a  class="page-link" href="<c:url value="./BbsListAction.go?pageNum=${startPage-1}&items=${items}&text=${text}"/>">Previous</a> 
    </li>
  </c:if>
      
     <c:forEach var="i" begin="${startPage}" end="${endPage}">
         <c:choose>
            <c:when test="${pageNum==i }">
                 <li class="page-item active" aria-current="page">
                    <a class="page-link" href="<c:url value="./BbsListAction.go?pageNum=${i}&items=${items}&text=${text}"/>">${i}</a>
                  </li>
            </c:when>
            <c:otherwise>
                   <li class="page-item"><a class="page-link" href="<c:url value="./BbsListAction.go?pageNum=${i}&items=${items}&text=${text}"/>">${i}</a></li>
            </c:otherwise>
         </c:choose>
     </c:forEach>
     <c:if test="${endPage+1==finalPage }">
   <li class="page-item  disabled"> 
     <a  class="page-link" href="<c:url value="./BbsListAction.go?pageNum=${endPage+1}&items=${items}&text=${text}"/>">Next</a> 
    </li>
   </c:if>
   <c:if test="${endPage+1 < finalPage }">
    <li class="page-item"> 
     <a  class="page-link" href="<c:url value="./BbsListAction.go?pageNum=${endPage+1}&items=${items}&text=${text}"/>">Next</a> 
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
                <option value="writer" <c:if test="${items=='writer'}">selected</c:if> >글쓴이에서</option>
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
<div class="modal" id="myModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">글쓰기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>로그인 해주세요</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
        <button type="button" class="btn btn-primary" onclick='javascript:location.href="./BbsWriteForm.go?id=${sessionScope.sessionId}&pageNum=${pageNum}&items=${items}&text=${text}"'>예</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="../footer.jsp"/>
</body>
</html>