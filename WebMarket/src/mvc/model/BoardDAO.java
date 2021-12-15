package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mvc.database.DBConnection;

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
  
  public String getLoginNameById(String id) {
	  Connection conn=null;
	  PreparedStatement pstmt=null;
	  ResultSet rs=null;
	  
	  String name=null;
	  String sql="select * from member where id=?";
	  
	  try {
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
	  
	  String name=null;
	  String sql = "insert into board(id, name, subject, content, regist_day, hit, ip) "
	  		     + " values(?,?,?,?,?,?,?)";
	  
	  try {
		    //db연결
		    conn=DBConnection.getConnection();
		    pstmt=conn.prepareStatement(sql);
		    //값 설정
		    pstmt.setString(1,board.getId());
		    pstmt.setString(2, board.getName());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent());
			pstmt.setString(5, board.getRegist_day());
			pstmt.setInt(6, board.getHit());
			pstmt.setString(7, board.getIp());
			//db저장처리
			pstmt.executeUpdate();		  
	  }catch(Exception e) {
		  System.out.println("에러:"+e);
	  }finally {
		  try {
                if(pstmt!=null) pstmt.close();
			    if(conn!=null)conn.close();
		  }catch(Exception e) {
			  throw new RuntimeException(e.getMessage());
		  }
	  }
  }//insertBoard()메소드 끝.
  
  //board테이블의 레코드 가져오기
  public List<BoardDTO> getBoardList(int pageNum, int limit, String items, String text){
	  Connection conn=null;
	  PreparedStatement pstmt=null;
	  ResultSet rs = null;
	  
	  String sql="";
	
	  if((items==null && text==null)||( items.length()==0 || text.length()==0))//검색 조건이 파라미터로 넘어오지 않은 경우
	   sql ="select * from board order by num desc";
	  else//검색 조건이 파라미터로 넘어온 경우
	   sql = "select * from board where "+items+" like '%"+text+"%' order by num desc";
	  
	  System.out.println("sql:"+sql);
	  
	  //전체 레코드 건수 구하기
	  int total_record = getListCount(items,text);
	  
	  int start  = (pageNum-1)*limit;// 예)1페이지-> start=0; 4페이지 -> start=(4-1)*5=>15
	  int index = start +1;//index = 1, index = 15+1 => 16
	  System.out.println("index:"+index);
	  //[1]1,2,3,4,5   [2]6,7,8,9,10, [3]11,12,13,14,15, [4]16,17,18,19,20
	  
	  //게시글 리스트 객체 생성
	  ArrayList<BoardDTO> list = new ArrayList<>();
	  
	  try {
		    conn = DBConnection.getConnection();
		    pstmt = conn.prepareStatement(sql,
		    		                      ResultSet.TYPE_SCROLL_INSENSITIVE, 
		    		                      ResultSet.CONCUR_UPDATABLE);
		    rs = pstmt.executeQuery();
		    while(rs.absolute(index)) {
		    	//게시글 객체 생성
		    	BoardDTO board = new BoardDTO();
		    	//조회된 레코드로부터 속성값 설정
		    	board.setNum(rs.getInt("num"));
		    	System.out.println("글번호:"+rs.getInt("num"));
		    	board.setId(rs.getString("id"));
		    	board.setName(rs.getString("name"));
		    	board.setSubject(rs.getString("subject"));
		    	board.setContent(rs.getString("content"));
		    	board.setRegist_day(rs.getString("regist_day"));
		    	board.setHit(rs.getInt("hit"));
		    	board.setIp(rs.getString("ip"));
		    	
		    	//리스트에 추가하기
		    	list.add(board);
		    	
		    	//현재 페이지에 나타날범위 내이면 index증가
		    	if(index<(start + limit) && index <=total_record) index++;
		    	else
		    		break;	
		    }
		    return list;
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
  }//getBoardList()메소드 끝.
  
 //전체 게시글 건 수 가져오기 
 public int getListCount(String items, String text) {
	 Connection conn=null;
	 PreparedStatement pstmt=null;
	 ResultSet rs = null;
	 
	 //게시글 전체 건수 변수 
	 int x =0;
	 
	 String sql;
	 if((items==null && text==null)||( items.length()==0 || text.length()==0))//검색 조건이 파라미터로 넘어오지 않은 경우
	   sql = "select count(*) from board ";
     else//검색 조건이 파라미터로 넘어온 경우
	   sql = "select count(*) from board where "+items+" like '%"+text+"%' ";
	 System.out.println("getListcount_SQL:"+sql);
	 
	 try {
		    conn=DBConnection.getConnection();
		    pstmt=conn.prepareStatement(sql);
		    rs=pstmt.executeQuery();
		    
		    if(rs.next()) x=rs.getInt(1);
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
	return x;
}//getListCount() 끝.
  
 //글 번호에 해당하는 글 정보 얻기 메소드
 public BoardDTO  getBoardByNum(int num,int pageNum){
	 BoardDTO board = new BoardDTO();
	 Connection conn=null;
	 PreparedStatement pstmt=null;
	 ResultSet rs = null;
	  
	 String sql = "select * from board where num=?";//글 번호에 해당하는 글 정보 얻기
 
	 try {
		    conn=DBConnection.getConnection();
		    pstmt=conn.prepareStatement(sql);
		    pstmt.setInt(1, num);
		    rs=pstmt.executeQuery();
		    
		    if(rs.next()) {
		    	board.setNum(rs.getInt(1));
		    	board.setId(rs.getString(2));
		    	board.setName(rs.getString(3));
		    	board.setSubject(rs.getString(4));
		    	board.setContent(rs.getString(5));
		    	board.setRegist_day(rs.getString(6));
		    	board.setHit(rs.getInt(7));
		    	board.setIp(rs.getString(8));
		    }
	 }catch(Exception e) {
		 System.out.println("에러:"+e);// e.toString() 자동 호출
	 }finally {
		  try {
			    if(rs!=null) rs.close(); if(pstmt!=null) pstmt.close();
			    if(conn!=null)conn.close();
		  }catch(Exception e) {
			  throw new RuntimeException(e.getMessage());
		  }
	  }
	return board; 
 }//getBoardByNum() 끝.
 
 //글 내용 수정 처리
public void updateBoard(BoardDTO board) {
	  Connection conn=null;
	  PreparedStatement pstmt=null;
	  
	  String sql = "update board set id=?,name=?,subject=?,content=?,regist_day=?,ip=? where num=?";
	  
	  try {
		    //db연결
		    conn=DBConnection.getConnection();
		    pstmt=conn.prepareStatement(sql);
		    //값 설정
		    pstmt.setString(1, board.getId());
		    pstmt.setString(2, board.getName());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent());
			pstmt.setString(5, board.getRegist_day());
			pstmt.setString(6, board.getIp());
			pstmt.setInt(7, board.getNum());
			
			//db저장처리
			pstmt.executeUpdate();		  
	  }catch(Exception e) {
		  System.out.println("에러:"+e);
	  }finally {
		  try {
               if(pstmt!=null) pstmt.close();
			    if(conn!=null)conn.close();
		  }catch(Exception e) {
			  throw new RuntimeException(e.getMessage());
		  }
	  }
}//updateBoard()끝.

//조회수 증가
public void updateHit(int num) {
 Connection conn=null;
 PreparedStatement pstmt=null;
 
 String sql="update board set hit=hit+1 where num=?";
 try {
	   conn=DBConnection.getConnection();
	   pstmt = conn.prepareStatement(sql);
	   pstmt.setInt(1, num);
	   pstmt.executeUpdate();
 }catch(Exception e) {
	 System.out.println("에러:"+e);
 }finally {
	  try {
          if(pstmt!=null) pstmt.close();
		    if(conn!=null)conn.close();
	  }catch(Exception e) {
		  throw new RuntimeException(e.getMessage());
	  }
  }
}//updateHit() 끝.

public void deleteBoard(int num){
	Connection conn=null;
	PreparedStatement pstmt=null;
	String sql="delete from board where num=?";
 try {
	    conn=DBConnection.getConnection();
	    conn.setAutoCommit(false);//수동 transaction처리
	    pstmt = conn.prepareStatement(sql);
	    pstmt.setInt(1, num);
	    pstmt.executeUpdate();
	    conn.commit();//commit 처리
} catch (Exception e) {
	 try {
		conn.rollback(); //rollback 처리
	} catch (SQLException e1) {
		e1.printStackTrace();
	}
	 System.out.println("에러:"+e);
}finally {
	  try {
		   conn.setAutoCommit(true);//자동 transaction으로 처리
         if(pstmt!=null) pstmt.close();
		    if(conn!=null)conn.close();
	  }catch(Exception e) {
		  throw new RuntimeException(e.getMessage());
	  }
 }
	
}//deleteBoard()끝.
  
  
  
  
}