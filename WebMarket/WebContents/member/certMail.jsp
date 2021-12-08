<%@page import="java.text.NumberFormat"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>이메일 인증</title>
<%
	String email=request.getParameter("email").trim();
    String password=request.getParameter("emailPassword").trim();
%>
</head>
<body>    
<%
   //비번문자생성
     int[] arr = {(int)(Math.random()*92)+33,
    		     (int)(Math.random()*92)+33,
    		     (int)(Math.random()*92)+33,
    		     (int)(Math.random()*92)+33,
    		     (int)(Math.random()*92)+33,
    		     (int)(Math.random()*92)+33
               };
   String certString = "";
   for(int i=0;i<arr.length;i++)
	   certString+=(char)(arr[i]);
   //System.out.println(certString);
%>
<%
 Properties p=System.getProperties();
 p.put("mail.smtp.starttls.enable","true");//
 p.put("mail.smtp.host","smtp.naver.com");//stmp서버 주소
 p.put("mail.smtp.auth","true");
 p.put("mail.smtp.port","587");//네이버 포트
 p.put("mail.smtp.port","587");//네이버 포트
 p.put("mail.smtp.ssl.protocols", "TLSv1.2");//시큐어 프로토콜 추가
 /* Caused by: javax.net.ssl.SSLHandshakeException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
 */
 p.put("mail.smtp.ssl.trust","*"); //인증서 전부 신뢰
 
 //session 생성 및 MimeMessage 생성
 Session session2 = Session.getDefaultInstance(p,new javax.mail.Authenticator() {
		String un = email;
		String pw = password;
		protected  PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(un, pw);
		}
	});
	
 //Session session2 =Session.getDefaultInstance(p,auth);
 MimeMessage msg = new MimeMessage(session2);
 try{
	 msg.setSentDate(new Date());//전송시간
	 InternetAddress from = new InternetAddress();
	 from = new InternetAddress(email);//발신자 아이디
	 msg.setFrom(from);//이메일 발신자
	 InternetAddress to = new InternetAddress(email);//수신자
	 msg.setRecipient(Message.RecipientType.TO, to);//수신자
	 msg.setSubject("회원가입인증메일-WebMarket","UTF-8");//이메일 제목
	 msg.setText(certString,"UTF-8");//이메일 내용
     msg.setHeader("content-Type", "text/html");//이메일 헤더
     //전송 처리
     Transport.send(msg,msg.getAllRecipients());
     //out.print("메일전송 성공");
 }catch(Exception e){
	 e.printStackTrace();
 }
%>
<script>opener.newMember.cert.value='<%=certString%>'</script>
<script>window.close();</script>
</body>
</html> 