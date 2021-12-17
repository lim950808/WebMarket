package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mvc.database.DBConnection;
import mvc.database.DBConnectionOracle;

//싱글톤 
public class BoardDAO {
  //1.자신타입의 static 필드 선언
  private static BoardDAO instance;
  //2.default생성자를 private로 선언
  private BoardDAO() {}
  //3. public 접근제어타입의 getInstance()메소드 선언,getInstance()로만 접근 
  public static BoardDAO getInstance() {
	  if(instance==null) instance = new BoardDAO();
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
  
  //db에 저장하는 메소드
  public void insertBoard(BoardDTO board) {
	  Connection conn=null;
	  PreparedStatement pstmt=null;
	  String sql ="insert into board values(board_seq.nextval,?,?,?,?,?,?,?)";
	  try {
		     //1.Oracle dbconnection 맺기
		     conn =DBConnectionOracle.getConnection();
		     //2. sql 전달객체 생성
		     pstmt = conn.prepareStatement(sql);
		     //3. sql문의 바인딩 변수 세팅
		     pstmt.setString(1, board.getId());
		     pstmt.setString(2, board.getName());
		     pstmt.setString(3, board.getSubject());
		     pstmt.setString(4, board.getContent());
		     pstmt.setString(5, board.getRegist_day());
		     pstmt.setInt(6, board.getHit());
		     pstmt.setString(7,board.getIp());
		     
		     //4. 쿼리 객체 전달 및 실행
		     pstmt.executeUpdate();
	  }catch(Exception e) {
		  System.out.println("에러:"+e.getMessage());
	  }finally {
		  try {
			    if(pstmt!=null) pstmt.close();
			    if(conn!=null)conn.close();
		  }catch(Exception e) {
			  throw new RuntimeException(e.getMessage());
		  }
	  }
  }//insertBoard() 끝.
  
public List<BoardDTO> getBoardList(int pageNum, int limit, String items, String text) {
	List<BoardDTO> boardList = new ArrayList<BoardDTO>();
	
	Connection conn=null;
    PreparedStatement pstmt=null;
    ResultSet rs = null;
    String sql="";
    
    if((items==null && text==null) || (items.length()==0|| text.length()==0)){
        sql="select * from "
           +" (select rownum rn, board.* "
           +"  from board  "
           +"  order by num desc) "
           +" where rn between ? and ? ";	
    }else {
    	sql="select * from "
    	   +" (select rownum rn, board.* "
    	   +"  from board "
    	   +"  where "+items+" like '%?%' "
    	   +"  order by num desc) "
    	   +" where rn between ? and ?";
    }
     System.out.println("sql:"+sql);
     
     
     int start = (pageNum-1)*limit; //예)3페이지 -> (3-1)*10=>20, 1페이지->0
     int index = start +1;//index,//예) 21, 1,
     int end = index +9;//21+9=>30, 1+9=10,
   
    try {
          //1.OracleDB 연결객체 생성
    	 conn = DBConnectionOracle.getConnection();
    	 if((items==null && text==null) || (items.length()==0|| text.length()==0)){
    		 pstmt = conn.prepareCall(sql);
    		 pstmt.setInt(1, index);
    		 pstmt.setInt(2, end);
    	 }else {
    		 pstmt = conn.prepareCall(sql);
    		 pstmt.setString(1, text);
    		 pstmt.setInt(2, index);
    		 pstmt.setInt(3, end);
    	 }
    	 rs = pstmt.executeQuery();
    	 while(rs.next()) {

    		 
    		 
    	 }
    }catch(Exception e) {
		  System.out.println("에러:"+e.getMessage());
	  }finally {
		  try {
			    if(rs!=null) rs.close();
			    if(pstmt!=null) pstmt.close();
			    if(conn!=null)conn.close();
		  }catch(Exception e) {
			  throw new RuntimeException(e.getMessage());
		  }
	  } 
	return boardList;
}//getBoardList()메소드 끝.


public int getListCount(int pageNum, int limit, String items, String text) {

	return 0;
}
}