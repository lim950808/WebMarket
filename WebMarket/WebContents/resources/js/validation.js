/**
 * 상품등록 페이지 입력 데이타 검증 자바스크립트
 */
function chk(){
	var productId = document.getElementById("productId");
	var unitPrice = document.getElementById("unitPrice");
	var unitsInStock = document.getElementById("unitsInStock");
	//상품 아이디 체크 {m,n}:m~n개, {m,}:m개 이상 ,{,n}:n개 이하
/* 	if(!check(/^P[0-9]{4,11}$/, productId,
			  "[상품코드]\nP와 숫자를 조합하여 5~12자 까지 입력하세요\n첫 글자는 반드시 P로 시작하세요" )){
		return false;
	} */
	//상품 가격 체크
	if(unitPrice.value.lenght==0 || isNaN(unitPrice.value)){
		alert("[가격]\n숫자만 입력하세요");
		unitPrice.select();
		unitPrice.focus();
		return false;
	}
	//
	if(unitPrice.value < 0 ){
		alert("[가격]\n음수를 입력할 수 없습니다.");
		unitPrice.select();
		unitPrice.focus();
		return false; 
	}else if(!check(/^\d+$/,unitPrice, "[가격]\n정수만 입력하세요")){
		return false;
	}
	//재고 수 체크
	if(unitsInStock.value.lenght==0 || isNaN(unitsInStock.value)){
		alert("[재고 수]\n숫자만 입력하세요");
		unitsInStock.select();
		unitsInStock.focus();
		return false;
	}
	//
	if(unitsInStock.value < 0 ){
		alert("[재고 수]\n음수를 입력할 수 없습니다.");
		unitsInStock.select();
		unitsInStock.focus();
		return false;
	}
	
	document.newProduct.submit();
}
/* check(정규표현신, element, 메세지) */
function check(regExp, e, msg){
	if(regExp.test(e.value)){//정규표현식 객체 regExp.test(값); 정규표현식 규칙에 맞으면 true, false를 리턴하는 함수
		return true;
	}
	alert(msg);
	e.select();
	e.focus();
	return false;
}