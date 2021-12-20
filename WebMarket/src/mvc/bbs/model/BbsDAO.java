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
  
 //BbsList출력 메소드
 public List<BbsDTO> getBbsList(int pageNum, int limit, String items, String text){
	 List<BbsDTO> bbslist = new ArrayList<>();
	  Connection conn=null;
	  PreparedStatement pstmt=null;
	  ResultSet rs=null;
	 
	  String sql="";
	  
		  if((items==null && text==null)||( items.length()==0 || text.length()==0)) {//검색 조건이 파라미터로 넘어오지 않은 경우
				sql = "select * "
				    + " from "
					+ "(select rownum rn, a.* from "
					+ " (select * "
					+ "    from bbs "
					+ "    order by ref desc, re_step asc)a ) "
					+ "where rn between ? and ? ";	
			}else { //검색 조건이 파라미터로 넘어온 경우 
				sql = "select * from "
					+ " (select rownum rn, a.* from "
					+ "  (select * "	
					+ "     from bbs "
					+ "    where "+items+" like '%'||?||'%' " //|| : 결합 연산자
					+ "    order by ref desc, re_step asc) a) "
					+ " where rn between ? and ?";
			 }
			System.out.println("sql:"+sql);
			
			//페이지 번호로 해당 페이지의 시작 글번호와 끝 글번호 구하기
			int start = (pageNum-1)*limit; //예)3페이지 -> (3-1)*10=20, 1페이지 ->0
			int index = start +1; //예)index=21, 1
			int end = index +9; //예)21+9=30, 1+9=10
			
			System.out.println("index:"+index);
			System.out.println("end:"+end);
			
			try {
				//1.OracleDB 연결객체 생성
				conn = DBConnectionOracle.getConnection();
				if((items==null && text==null)||( items.length()==0 || text.length()==0)) {
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, index);
					pstmt.setInt(2, end);
				}else {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, text);
					pstmt.setInt(2, index);
					pstmt.setInt(3, end);
				}
				rs = pstmt.executeQuery();
				while(rs.next()) {
					BbsDTO bbs = new BbsDTO();
					bbs.setNum(rs.getInt(2));
					bbs.setWriter(rs.getString(3));
					bbs.setSubject(rs.getString(4));
					bbs.setContent(rs.getString(5));
					bbs.setReadcount(rs.getInt(6));
					bbs.setPassword(rs.getString(7));
					bbs.setReg_date(rs.getString(8));
					bbs.setIp(rs.getString(9));
					bbs.setRef(rs.getInt(10));
					bbs.setRe_step(rs.getInt(11));
					bbs.setRe_level(rs.getInt(12));
                   
					//리스트에 추가
					bbslist.add(bbs);
				}
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
	return bbslist;   
  }//getBbsList() 끝.

 public int getBbsCount(int pageNum, int limit, String items, String text){
	 int count =0;
	 Connection conn=null;
	  PreparedStatement pstmt=null;
	  ResultSet rs=null;
	 
	  String sql="";
	  
		  if((items==null && text==null)||( items.length()==0 || text.length()==0)) {//검색 조건이 파라미터로 넘어오지 않은 경우
				sql = "select count(*) from bbs ";	
			}else { //검색 조건이 파라미터로 넘어온 경우 
				sql = "select count(*) "
					+ "  from bbs "
					+ " where "+items+" like '%'||?||'%' " ;
			 }
			System.out.println("sql:"+sql);
			
			//페이지 번호로 해당 페이지의 시작 글번호와 끝 글번호 구하기
			int start = (pageNum-1)*limit; //예)3페이지 -> (3-1)*10=20, 1페이지 ->0
			int index = start +1; //예)index=21, 1
			int end = index +9; //예)21+9=30, 1+9=10
			
			try {
				//1.OracleDB 연결객체 생성
				conn = DBConnectionOracle.getConnection();
				if((items==null && text==null)||( items.length()==0 || text.length()==0)) {
					pstmt = conn.prepareStatement(sql);
				}else {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, text);
				}
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
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
	 return count;
 }//getBbsCount() 끝.

 //글번호에 해당하는 Bbs정보 얻기
 public BbsDTO getBbsByNum(int num,int pageNum) {
  BbsDTO bbs =null;
  Connection conn=null;
  PreparedStatement pstmt=null;
  ResultSet rs=null;
 
  String sql="select * from bbs where num=?";
 
  System.out.println("sql:"+sql);

		try {
			//1.OracleDB 연결객체 생성
			conn = DBConnectionOracle.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			bbs = new BbsDTO();
			bbs.setNum(rs.getInt(1));
			bbs.setWriter(rs.getString(2));
			bbs.setSubject(rs.getString(3));
			bbs.setContent(rs.getString(4));
			bbs.setReadcount(rs.getInt(5));
			bbs.setPassword(rs.getString(6));
			bbs.setReg_date(rs.getString(7));
			bbs.setIp(rs.getString(8));
			bbs.setRef(rs.getInt(9));
			bbs.setRe_step(rs.getInt(10));
			bbs.setRe_level(rs.getInt(11));				
			}
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
  return bbs;
 }//getBbsByNum() 끝.
}