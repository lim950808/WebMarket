package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import mvc.database.DBConnection;
import mvc.database.DBConnectionOracle;

public class MemberDao {
	  private static MemberDao instance;
	  private MemberDao() {}
	  public static MemberDao getInstance() {
		  if(instance==null) instance = new MemberDao();
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
			    	name=rs.getString("name");
			    }
			    return name;
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
	  
	  public void insertMember(MemberDao member) {
		  Connection conn=null;
		  PreparedStatement pstmt=null;
		  String sql ="insert into member values(?,?,?,?)";
		  try {
			     conn =DBConnectionOracle.getConnection();
			     pstmt = conn.prepareStatement(sql);
			     pstmt.setString(1, member.getId());
			     pstmt.setString(2, member.getPassword());
			     pstmt.setString(3, member.getName());
			     pstmt.setString(4, member.getReg_day());
			     
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
	  }
	
}
