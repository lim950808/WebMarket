package dto;

import java.io.Serializable;

public class Review implements Serializable {
 //원본여부확인번호
 private static final long serialVersionUID = 1L;

 private String productId;   //상품 아이디
 private int  seq;           //순번
 private String  id;         //작성자 id
 private String subject;     //제목
 private String content;     //내용
 private int rate;           //별 점 1,2,3,4,5
 private String attachImage; //이미지   
 
public String getProductId() {
	return productId;
}
public void setProductId(String productId) {
	this.productId = productId;
}
public int getSeq() {
	return seq;
}
public void setSeq(int seq) {
	this.seq = seq;
}
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getSubject() {
	return subject;
}
public void setSubject(String subject) {
	this.subject = subject;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public int getRate() {
	return rate;
}
public void setRate(int rate) {
	this.rate = rate;
}
public String getAttachImage() {
	return attachImage;
}
public void setAttachImage(String attachImage) {
	this.attachImage = attachImage;
}
 


}