package mvc.bbs.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mvc.database.DBConnection;
import mvc.database.DBConnectionOracle;

//싱글톤 
public class BbsDAO {
  //1.자신타입의 static 필드 선언
  private static BbsDAO instance;
  //2.default생성자를 private로 선언
  private BbsDAO() {}
  //3. public 접근제어타입의 getInstance()메소드 선언,getInstance()로만 접근 
  public static BbsDAO getInstance() {
	  if(instance==null) instance = new BbsDAO();
	return instance;
  }
  
  //Mysql의 회원정보 얻기
  public String getLoginNameById(String id) {
	  Connection conn=null;
	  PreparedStatement pstmt=null;
	  ResultSet rs=null;
	  
	  String name=null;
	  String sql="select * from member where id=?";
	  
	  try {
		    //Mysql 접속용 DBConnection객체 
		    conn=DBConnection.getConnection();
		    pstmt=conn.prepareStatement(sql);
		    pstmt.setString(1, id); 
		
		    rs=pstmt.executeQuery();
		    
		    if(rs.next()) {
		    	name=rs.getString("name");//rs.getString(칼럼명)
		    }
		    return name;//값을 db에서 얻어왔으면 name을 리턴, 아니면 null값 그대로 리턴.
	  }catch(Exception e) {
		  System.out.println("에러:"+e);
	  }finally {
		  try {
			    if(rs!=null) rs.close(); if(pstmt!=null) pstmt.close();
			    if(conn!=null)conn.close();
		  }catch(Exception e) {
			  throw new RuntimeException(e.getMessage());
		  }
	  }
	return null;  
  }
  
  // Bbs 등록
 public void insertBbs(BbsDTO bbs){
	 Connection conn=null;
	 PreparedStatement pstmt=null;
	 
	 String sql ="insert into bbs(num,writer,subject,content, password,ip,ref,re_step,re_level) "
			    +" values (bbs_seq.nextval,?,?,?,?,?,bbs_seq.currval,?,?)";
	 try {
		   conn = DBConnectionOracle.getConnection();
		   pstmt =conn.prepareStatement(sql);
		   pstmt.setString(1, bbs.getWriter());
		   pstmt.setString(2, bbs.getSubject());
		   pstmt.setString(3, bbs.getContent());
		   pstmt.setString(4, bbs.getPassword());
		   pstmt.setString(5, bbs.getIp());
		   //신규 등록시 글번호=ref, re_step=0, re_level=0
		   pstmt.setInt(6, 0);//신규등록시 re_step=0,
		   pstmt.setInt(7, 0);//신규등록시 re_level=0
		   
		   pstmt.executeUpdate();
	 }catch(Exception e){
		  System.out.println("에러:"+e);
	  }finally {
		  try {
			    if(pstmt!=null) pstmt.close();
			    if(conn!=null)conn.close();
		  }catch(Exception e) {
			  throw new RuntimeException(e.getMessage());
		  }
	  } 
 }//insertBbs() 끝.
  

}