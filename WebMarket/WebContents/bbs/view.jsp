<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><html><head>
<link rel="stylesheet" 
      href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>      
<meta charset="UTF-8">
<title>글 내용 보기</title>
<script>
function confirmDelete(num,pageNum,items,text){
 location.href="./BbsDeleteAction.go?num="+num+"&pageNum="+pageNum+"&items="+items+"&text="+text;
}
</script>
</head>
<body>
<jsp:include page="../menu.jsp"/>
<div class="jumbotron">
   <div class="container">
     <h1 class="display-3">게시판</h1>
   </div>
</div>

<div class="container">
    <form name="newUpdate" 
          action="BbsUpdateAction.go?num=${bbs.num}&pageNum=${page}&items=${items}&text=${text}"
          class="form-horizontal" 
          method="post"
          enctype="multipart/form-data" >
         <input type="hidden" name="id" value="${sessionId}"><!-- request->session->application순으로 조회 -->
    <div class="form-group row">
        <label class="col-sm-2 control-label">작성자</label>
        <div class="col-sm-3">
            <input name="writer" class="form-control" value="${bbs.writer}">
        </div>
    </div>
        <div class="form-group row">
        <label class="col-sm-2 control-label">제목</label>
        <div class="col-sm-3">
            <input name="subject" class="form-control" value="${bbs.subject}">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 control-label">내용</label>
        <div class="col-sm-8" style="word-break:break-all;">
            <textarea rows="5" cols="50" name="content"
               class="form-control">${bbs.content}</textarea>
        </div>
    </div>
   
   
    <div class="form-group row">
        <div class="col-sm-offset-2 col-sm-10">
        	<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#exampleModal">삭제
        	</button>
             <input type="submit" class="btn btn-success" value="수정">
            <a href="./BbsListAction.go?pageNum=${page}&items=${items}&text=${text}" class="btn btn-primary">목록</a>
            <a href="./BbsReplyForm.go?id=${sessionId}&pageNum=${page}&items=${items}&text=${text}&num=${bbs.num}&ref=${bbs.ref}&re_step=${bbs.re_step}&re_level=${bbs.re_level}" 
            class="btn btn-warning">답변</a>
        </div>
    </div>
    </form>
    <hr>
</div>
<jsp:include page="../footer.jsp"/>


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">게시글 삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
         ${board.num}번 글을 삭제하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
        <button type="button" class="btn btn-primary" onclick="confirmDelete('${bbs.num}','${page}','${items}','${text}')">예</button>
      </div>
    </div>
  </div>
</div>
    
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
const inputImage = document.getElementById("input-image")
inputImage.addEventListener("change", e => {readImage(e.target)})
</script>    
</body>
</html>