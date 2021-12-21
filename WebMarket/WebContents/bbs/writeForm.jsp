<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
<meta charset="UTF-8">
<title>Bbs</title>
</head>
<body>
<jsp:include page="../menu.jsp"/>
<div class="jumbotron">
   <div class="container">
      <h1 class="display-3">Bbs</h1>
   </div>
</div>
<div class="container">
   <form name="newWrite" action="./BbsWriteAction.go"
      class="form-horizontal" 
      method="post" 
      onsubmit="return checkForm()">
      <input name="id" type="hidden" class="form-control" value="${sessionId}">
      <input name="pageNum" type="hidden" value="${pageNum}">
      <input name="items" type="hidden" value="${items}">
      <input name="text" type="hidden" value="${text}">
      <input name="ref" type="hidden" value="${ref}">
      <input name="re_step" type="hidden" value="${re_step}">
      <input name="re_level" type="hidden" value="${re_level}">
      
      <div class="form-group row">
        <label class="col-sm-2 control-label">작성자</label>
        <div class="col-sm-3">
              <%-- ${}의 속성값은 자동 형변환처리 및 null 처리, String 인 경우 빈 문자열("")로 처리 --%>
           <input name="writer" class="form-control" value="${writer}" placeholder="writer">
        </div>
      </div>
      
      <div class="form-group row">
        <label class="col-sm-2 control-label">제목</label>
        <div class="col-sm-5">
           <input name="subject" class="form-control" placeholder="subject" 
           <c:if test='${num!=null}'>
             value="답변 :"
           </c:if>
           >
         </div>
      </div>
      
      <div class="form-group row">
        <label class="col-sm-2 control-label">내용</label>
        <div class="col-sm-8">
           <textarea rows="5" cols="50" class="form-control" placeholder="content" name="content"></textarea>
        </div>
      </div>
      
      <div class="form-group row">
        <label class="col-sm-2 control-label">password</label>
        <div class="col-sm-5">
           <input name="password" type="password" class="form-control" placeholder="password" required>
        </div>
      </div>

      
     <div class="form-group row">
        <div class="col-sm-offset-2 col-sm-10">
           <input type="submit" class="btn btn-success" value="등록">
           <input type="reset" class="btn btn-primary" value="취소">
        </div>
      </div>
 
   </form>
</div>

<jsp:include page="../footer.jsp"/>
</body>
</html>