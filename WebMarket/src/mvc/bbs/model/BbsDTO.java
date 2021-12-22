package mvc.bbs.model;

public class BbsDTO {
private int num;//자동 생성
 private String writer;//로그인 아이디
 private String subject;
 private String content;
 private int readcount;//초기값 0
 private String password; //비밀번호 
 private String reg_date;//등록일자
 private String ip;//접속ip는 request에서 구함.
 private int ref;// 답변글 그룹
 private int re_step;// ref내의 순서
 private int re_level;// 들여쓰기
 private int good;
 private int bad;

 //getters/setters
public int getNum() {
	return num;
}
public void setNum(int num) {
	this.num = num;
}
public String getWriter() {
	return writer;
}
public void setWriter(String writer) {
	this.writer = writer;
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

public String getReg_date() {
	return reg_date;
}
public void setReg_date(String reg_date) {
	this.reg_date = reg_date;
}
public int getReadcount() {
	return readcount;
}
public void setReadcount(int readcount) {
	this.readcount = readcount;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getIp() {
	return ip;
}
public void setIp(String ip) {
	this.ip = ip;
}
public int getRef() {
	return ref;
}
public void setRef(int ref) {
	this.ref = ref;
}
public int getRe_step() {
	return re_step;
}
public void setRe_step(int re_step) {
	this.re_step = re_step;
}
public int getRe_level() {
	return re_level;
}
public void setRe_level(int re_level) {
	this.re_level = re_level;
}
public int getGood() {
	return good;
}
public void setGood(int good) {
	this.good = good;
}
public int getBad() {
	return bad;
}
public void setBad(int bad) {
	this.bad = bad;
}
 
 
 
}