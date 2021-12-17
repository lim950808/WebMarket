package mvc.database;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConnectionOracle {
 public static Connection getConnection() throws SQLException,ClassNotFoundException{
	 Connection conn=null;
	 
	 Context init;
	try {
		init = new InitialContext();
	    DataSource ds = 
	     (DataSource)init.lookup("java:comp/env/jdbc/webmarketOracle");
	      conn=ds.getConnection();
	}catch(Exception e) {
		System.out.println(e.getMessage());
	}
	 return conn;
 }
	/*
	 * public static void main(String[] args) throws ClassNotFoundException,
	 * SQLException { if(DBConnection.getConnection()!=null)
	 * System.out.println("연결 성공!"); else System.out.println("연결 실패!"); }
	 */

}