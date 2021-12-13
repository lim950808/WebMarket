package mvc.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getConnection() throws SQLException, ClassNotFoundException {
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/WebMarketDB";
		String user = "director";
		String password = "director";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);
		
		return conn;
		
	}
	/*
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		if(DBConnection.getConnection() != null)
			System.out.println("연결 성공!");
		else
			System.out.println("연결 실패!");
	}
	*/
}
