<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html><html><head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
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
   <form name="newWrite" action="./BoardWriteAction.do"
      class="form-horizontal" 
      method="post" 
      enctype="multipart/form-data" 
      onsubmit="return checkForm()">
      <input name="id" type="hidden" class="form-control" value="${sessionId}">
      <div class="form-group row">
        <label class="col-sm-2 control-label">성명</label>
        <div class="col-sm-3">
              <%-- ${}의 속성값은 자동 형변환처리 및 null 처리, String 인 경우 빈 문자열("")로 처리 --%>
           <input name="name" class="form-control" value="${name}" placeholder="name">
        </div>
      </div>
      
      <div class="form-group row">
        <label class="col-sm-2 control-label">제목</label>
        <div class="col-sm-5">
           <input name="subject" class="form-control" placeholder="subject">
        </div>
      </div>
      
      <div class="form-group row">
        <label class="col-sm-2 control-label">내용</label>
        <div class="col-sm-8">
           <textarea rows="5" cols="50" class="form-control" placeholder="content" name="content"></textarea>
        </div>
      </div>
   
     <div class="form-group row">
        <div class="col-sm-offset-2 col-sm-10">
           <input type="submit" class="btn btn-success" value="등록">
           <input type="reset" class="btn btn-primary" value="취소">
        </div>
      </div>
      
     <div class="form-group row">
      <label class="col-sm-2">이미지</label>
       <div class="col-sm-5">
         <img style="width: 500px;" id="preview-image" >
         <input type="file" name="attachFile" class="form-control" id="input-image">
       </div>
   </div>
   </form>
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
<jsp:include page="../footer.jsp"/>
</body>
</html>