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
	 Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "";
		String updateSql = "";
		
		if(bbs.getRef()==0) { //ref가 0이면 신규글 등록
			sql = "insert into bbs(num,writer,subject,content,password,ip,ref,re_step,re_level) "
				+ "values (bbs_seq.nextval,?,?,?,?,?,bbs_seq.currval,?,?)";
		
		}else { //ref가 0이 아니면 답변글(댓글) 등록 (답변글은 글번호가 원글과 같음)
			System.out.println("x");
			//원글 중 댓글이 있으면, 신규 댓글 입력 전 등록하려는 댓글과 같은 ref 그룹의 기존 댓글의 스텝을 1씩 증가 처리
			updateSql = "update bbs set re_step=re_step+1 where ref=? and re_step > ?"; 
			
			//원글에 대한 답변글(댓글) 등록
			sql = "insert into bbs(num,writer,subject,content,password,ip,ref,re_step,re_level) "
					+ "values (bbs_seq.nextval,?,?,?,?,?,?,?,?)";			
		}
		
		try { //신규글 등록 처리
			conn = DBConnectionOracle.getConnection();
			if(bbs.getRef()==0) {
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, bbs.getWriter());
				pstmt.setString(2, bbs.getSubject());
				pstmt.setString(3, bbs.getContent());
				pstmt.setString(4, bbs.getPassword());
				pstmt.setString(5, bbs.getIp());
				//신규 등록 시 : 글번호 = ref, re_step=0, re_level=0
				pstmt.setInt(6, 0); //신규 등록 시 re_step=0
				pstmt.setInt(7, 0); //신규 등록 시 re_level=0
				
				pstmt.executeUpdate();
			}else {
				System.out.println("y");
				
				//기존 댓글 update 처리
				pstmt = conn.prepareStatement(updateSql);
				pstmt.setInt(1,bbs.getRef());
				pstmt.setInt(2,bbs.getRe_step());
				
				//update처리
				pstmt.executeUpdate();
				
				//댓글 입력 처리
				pstmt = conn.prepareStatement(sql);
				System.out.println("sql:"+sql);
				
				pstmt.setString(1, bbs.getWriter());
				pstmt.setString(2, bbs.getSubject());
				pstmt.setString(3, bbs.getContent());
				pstmt.setString(4, bbs.getPassword());
				pstmt.setString(5, bbs.getIp());
				//신규 등록 시 : 글번호=ref, re_step=0, re_level=0
				pstmt.setInt(6, bbs.getRef());
				pstmt.setInt(7, bbs.getRe_step()+1); //댓글 등록 시 re_step = re_step+1
				pstmt.setInt(8, bbs.getRe_level()+1); //댓글 등록 시 re_level = re_level+1
				
				pstmt.executeUpdate();
		}
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
				    + "  from  "
				    + "(select rownum rn, a.* from "
				    + " (select bbs.num num, "
				    + "       bbs.writer writer, "
				    + "       bbs.subject subject, "
				    + "       bbs.content content, "
				    + "       bbs.readcount readcount, "
				    + "       bbs.password password, "
				    + "       bbs.reg_date reg_date, "
				    + "       bbs.ip ip, "
				    + "       bbs.ref ref, "
				    + "       bbs.re_step re_step, "
				    + "       bbs.re_level re_level, "
				    + "       nvl(bbsgoodbad.good,0) good, "
				    + "       nvl(bbsgoodbad.bad,0) bad "
				    + "  from bbs, bbsgoodbad "
				    + " where bbs.num=bbsgoodbad.num(+) "
				    + " order by ref desc, re_step asc)a ) "
				    + " where rn between ? and ? "
				    ;
				
			}else { //검색 조건이 파라미터로 넘어온 경우 
				sql = "select * "
					+ "   from "
					+ "	(select rownum rn, a.* from "
					+ "	  (select  bbs.num num,"
					+ "		       bbs.writer writer,"
					+ "		       bbs.subject subject,"
					+ "		       bbs.content content,"
					+ "		       bbs.readcount readcount,"
					+ "		       bbs.password password,"
					+ "		       bbs.reg_date reg_date,"
					+ "		       bbs.ip ip,"
					+ "		       bbs.ref ref,"
					+ "		       bbs.re_step re_step,"
					+ "		       bbs.re_level re_level,"
					+ "		       nvl(bbsgoodbad.good,0) good,"
					+ "		       nvl(bbsgoodbad.bad,0) bad 	"
					+ "		 from bbs, bbsgoodbad"
					+ "	    where subject like '%'||?||'%'"
					+ "	      and bbs.num = bbsgoodbad.num(+) "
					+ "	    order by ref desc, re_step asc) a) "
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
					//좋아요, 싫어요 추가
					bbs.setGood(rs.getInt(13));
					bbs.setBad(rs.getInt(14));
                   
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

//글 조회수 증가 처리
public void updateBbsReadcount(int num) {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql = "update bbs set readcount=readcount+1 where num=?";
	
	try { //조회수 증가 처리
		conn = DBConnectionOracle.getConnection();	
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num );
			//update처리
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
}//updateBbsReadcount() 끝.
 
 
 //글번호에 해당하는 Bbs정보 얻기
 public BbsDTO getBbsByNum(int num,int pageNum) {
  BbsDTO bbs =null;
  Connection conn=null;
  PreparedStatement pstmt=null;
  ResultSet rs=null;
 
  String sql="select * from bbs where num=?";
 
  System.out.println("sql:"+sql);
  
  //조회수 증가 처리
  // updateBbsReadcount(num);
   
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
 
public int getFirstNum() {
	 int minNum =0;
	 Connection conn=null;
	  PreparedStatement pstmt=null;
	  ResultSet rs=null;
	 
	  String sql="select nvl(min(num),0) from bbs ";	
	try {
		 //1.OracleDB 연결객체 생성
		 conn = DBConnectionOracle.getConnection();
		 pstmt = conn.prepareStatement(sql);
		 rs = pstmt.executeQuery();
		 if(rs.next()) minNum = rs.getInt(1);
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
	return minNum;
}//getFirstNum() 끝.

public int getLastNum() {
	 int maxNum =0;
	 Connection conn=null;
	  PreparedStatement pstmt=null;
	  ResultSet rs=null;
	 
	  String sql="select nvl(max(num),0) from bbs ";	
	try {
		 //1.OracleDB 연결객체 생성
		 conn = DBConnectionOracle.getConnection();
		 pstmt = conn.prepareStatement(sql);
		 rs = pstmt.executeQuery();
		 if(rs.next()) maxNum = rs.getInt(1);
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
	return maxNum;
 }//getLastNum() 끝.

//Bbs 수정 처리
public void updateBbs(BbsDTO bbs) {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String sql = "update bbs set writer=?,subject=?,content=?,ip=? where num=?";			
	
	
	try { //신규글 등록 처리
		conn = DBConnectionOracle.getConnection();
		
			//댓글 입력 처리
			pstmt = conn.prepareStatement(sql);
			System.out.println("sql:"+sql);
			
			pstmt.setString(1, bbs.getWriter());
			pstmt.setString(2, bbs.getSubject());
			pstmt.setString(3, bbs.getContent());
			pstmt.setString(4, bbs.getIp());
            pstmt.setInt(5, bbs.getNum());			
			//update처리
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
 }//updateBbs() 끝.

//Bbs 삭제 처리
public void deleteBbs(int num) {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs=null;
	
	String replyCountSql="select count(*) from bbs where ref=? and re_step >0";
	String sql = "delete from  bbs where num=?";			
	
	try { //삭제 처리
		conn = DBConnectionOracle.getConnection();
		
		System.out.println("sql:"+sql);
			//댓글 존재 여부확인
			pstmt = conn.prepareStatement(replyCountSql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
            int replyCount=0;
			if(rs.next()) replyCount = rs.getInt(1);
			if(replyCount ==0 ) { //댓글이 없는 글들만 삭제
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);			
                pstmt.executeUpdate();
			}
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
}//updateBbs() 끝.

public void insertUpdateBbsGoodBad(BbsGoodBadDTO bbsGoodBad) {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs=null;
	
	String sql = "select count(*) from bbsgoodbad where num=?";//rs.next() =true, 0, > 0
	String insertSql = "insert into bbsgoodbad values(?,?,?)";
	String updateSql = "update bbsgoodbad set good=good+?,bad=bad+? where num=?";
	int count=0;
	try { //신규글 등록 처리
		conn = DBConnectionOracle.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, bbsGoodBad.getNum());
		
		rs = pstmt.executeQuery();
	    if(rs.next()) {
	       count = rs.getInt(1);
	    }
	    rs.close();
	    if(count==0){//입력
	    		pstmt = conn.prepareStatement(insertSql);
	    		pstmt.setInt(1, bbsGoodBad.getNum());
	    		pstmt.setInt(2, bbsGoodBad.getGood());
	    		pstmt.setInt(3, bbsGoodBad.getBad());
	    		pstmt.executeUpdate();
	    }else {//수정
	    		System.out.println("y");
	    		pstmt = conn.prepareStatement(updateSql);
	    		pstmt.setInt(1, bbsGoodBad.getGood());
	    		pstmt.setInt(2, bbsGoodBad.getBad());
	    		pstmt.setInt(3, bbsGoodBad.getNum());
	    		pstmt.executeUpdate();	
	    	}
 }catch(Exception e){
	  System.out.println("에러:"+e);
	  e.printStackTrace();
  }finally {
	  try {
		    if(rs!=null) rs.close();
		    if(pstmt!=null) pstmt.close();
		    if(conn!=null)conn.close();
	  }catch(Exception e) {
		  throw new RuntimeException(e.getMessage());
	  }
   } 
 }//insertUpdateBbsGoodBad() 끝.

public BbsGoodBadDTO getBbsGoodBadByNum(int num) {
	BbsGoodBadDTO goodBad =null;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs=null;
	
	String sql = "select * from bbsgoodbad where num=?";
	System.out.println("z");
	
	try { //신규글 등록 처리
		conn = DBConnectionOracle.getConnection();
		pstmt = conn.prepareStatement(sql);
	    pstmt.setInt(1, num);	
		
		rs = pstmt.executeQuery();
	    if(rs.next()) {
	    	System.out.println("z");
	    	goodBad = new BbsGoodBadDTO();
	    	goodBad.setNum(num);
            goodBad.setGood(rs.getInt(2));
            goodBad.setBad(rs.getInt(3));
	    }
    }catch(Exception e){
	  System.out.println("에러:"+e);
	  e.printStackTrace();
  }finally {
	  try {
		    if(rs!=null) rs.close();
		    if(pstmt!=null) pstmt.close();
		    if(conn!=null)conn.close();
	  }catch(Exception e) {
		  throw new RuntimeException(e.getMessage());
	  }
   } 
	return goodBad;
}//getBbsGoodBadByNum() 끝.


}