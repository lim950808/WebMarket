<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Member Info</title>
</head>
<body>

	<div class="container">
      	<h1 class="display-5" align="center">Member Info</h1>
    </div>

    <div class="form-group row">
    	<label class="col-lg-10">*표시는 필수입력 표시입니다.</label>
    	<style>
	         	div{padding: 0 0 0 50px;}
	    </style>
    </div>
    
   		<div class="form-group row">
              <label class="col-sm-2">*ID</label>
              <style>
	         	div{padding: 0 0 0 50px;}
	         </style>
              <div class="col-sm-3">
                   <input name="id" type="text" class="form-control" required>
              </div>
        </div>
       
        <div class="form-group row">
              <label class="col-sm-2">*이름</label>
              <style>
	         	div{padding: 0 0 0 50px;}
	         </style>
              <div class="col-sm-3">
                   <input name="name" type="text" class="form-control" placeholder="이름" required>
              </div>
        </div>
        
        <div class="form-group row">
              <label class="col-sm-2">*비밀번호</label>
              <style>
	         	div{padding: 0 0 0 50px;}
	         </style>
              <div class="col-sm-3">
                   <input name="password" type="password" class="form-control" required>
              </div>
        </div>
        
        <div class="form-group row">
              <label class="col-sm-2">*비밀번호 확인</label>
              <style>
	         	div{padding: 0 0 0 50px;}
	         </style>
              <div class="col-sm-3">
                   <input name="password_confirm" type="password" class="form-control" required>
              </div>
        </div>
        
        <div class="form-group row">
              <label class="col-sm-2">*생일</label>
              <style>
	         	div{padding: 0 0 0 50px;}
	         </style>
              <div class="col-sm-4">
                   <input type="text" name="birthyy" maxlength="4" placeholder="2019" size="6" required>년
                   <input type="text" name="birthmm" maxlength="2" placeholder="12" size="4" required>월
                   <input type="text" name="birthdd" maxlength="2" placeholder="1" size="4" required>일
              </div>
        </div>
        
        <div class="form-group row">
             <label class="col-sm-2">*E-mail</label>
             <style>
	         	div{padding: 0 0 0 50px;}
	         </style>
             <div class="col-sm-10">
                <input type="text" name="mail1" maxlength="50" required> @
                <input type="text" name="mail2" maxlength="50" placeholder="naver.com" required>
                <input type="button" value="중복확인"  class="btn btn-info" onclick="emailChk()">
             </div>
       </div>
       
       <div class="form-group row">
         <label class="col-sm-2">*휴대폰</label>
	         <style>
	         	div{padding: 0 0 0 50px;}
	         </style>
         <div class="col-sm-5">
               <input maxlength="3" size="4" name="phone1" required>
				- <input maxlength="4" size="4" name="phone2" required>
				- <input maxlength="4" size="4" name="phone3" required>
         </div>
       </div>
       
       <div class="form-group row">
             <label class="col-sm-2">*주소</label>
             	<style>
	         		div{padding: 0 0 0 50px;}
	         	</style>
             <div class="col-sm-3">
                 <input name="address" id="address" type="text" class="form-control" required>
             </div>
        </div>
         
        <div class="form-group row">
             <label class="col-sm-2">*상세주소</label>
             <style>
	         	div{padding: 0 0 0 50px;}
	         </style>
             <div class="col-sm-3">
                 <input name="detailAddress" id="detailAddress" type="text" class="form-control" required>
             </div>
        </div>  
</body>
</html>