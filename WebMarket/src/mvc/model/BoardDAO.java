package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import mvc.database.DBConnection;

//싱글톤
public class BoardDAO {
	//1. 자신타입의 static 필드 선언
	private static BoardDAO instance;
	//2. default생성자를 private로 선언
	private BoardDAO() {}
	//3. public 접근제어 타입의 getInstance()메소드 선언, getInstance()로만 접근
	public static BoardDAO getInstance() {
		if(instance == null) instance = new BoardDAO();
		return instance;
	}
	
	public String getLoginNameById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String name = null;
		String sql = "select * from member where id = ?";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			
			if(rs.next()) {
				name = rs.getString("name"); //rs.getString(칼럼명)
			}
			return name; //값을 db에서 얻어 왔으면 name을 리턴, 아니면 null값 그래도 리턴.
		}catch(Exception e) {
			System.out.println("에러: " + e);
		}finally {
			try {
				if(rs != null) rs.close(); 
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		return null;
	}
	public void insertBoard(BoardDTO board) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String name = null;
		String sql = "insert into board(id, name, subject, content, regist_day, hit, ip) values(?, ?, ?, ?, ?, ?, ?)";
		
		try {
			//db연결
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			//값 설정
			pstmt.setString(1, board.getId());
			pstmt.setString(2, board.getName());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent());
			pstmt.setString(5, board.getRegist_day());
			pstmt.setInt(6, board.getHit());
			pstmt.setString(7, board.getIp());
			//db저장처리
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("에러: " + e);
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
	} //insertBoard() 메소드 끝.
	
	//board테이블의 레코드 가져오기
	public List<BoardDTO> getBoardList(int pageNum, int limit) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String name = null;
		String sql = "select * from board order by num desc"; //최근 등록글이 먼저 나오도록 처리
		
		int total_record = getListCount();
		int start = (pageNum - 1) * limit; //예)1페이지 -> start=0; 4페이지 -> start=(4-1)*5 => 15
		int index = start + 1; //index = 1, index = 15 + 1 => 31
		//[1]1,2,3,4,5 - [2]6,7,8,9,10 - [3]11,12,13,14,15 - [4]16,17,18,19,20
		
		//게시글 리스트 객체 생성
		ArrayList<BoardDTO> list = new ArrayList<>();
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			rs = pstmt.executeQuery();
			while(rs.absolute(index)) {
				//게시글 객체 생성
				BoardDTO board = new BoardDTO();
				//조회된 레코드로부터 속성값 설정
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
				
				//리스트에 추가하기
				list.add(board);
				
				//현재 페이지에 나타날 범위 내이면 index 증가
				if(index<(start + limit) && index<=total_record) index++;
				else
					break;
			}
			return list;
		}catch(Exception e) {
			System.out.println("에러: " + e);
		}finally {
			try {
				if(rs != null) rs.close(); 
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		return null;
	}
	
	//전체 게시글 건수 거져오기
	public int getListCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//게시글 전체 건수 변수
		int x = 0;
		
		String sql = "select count(*) from board";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) x = rs.getInt(1);
		}catch(Exception e) {
			System.out.println("에러: " + e);
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				if(rs != null) rs.close();
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		return x;
	} //getListCount() 끝.
	
	//글 번호에 해당하는 글 정보 얻기 메소드
	public BoardDTO getBoardByNum(int num, int pageNum) {
		BoardDTO board = new BoardDTO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from board where num = ?"; //글 번호에 해당하는 글 정보 얻기
		
		try {
			
		}catch(Exception e) {
			System.out.println("에러: " + e); //e.toString() 자동 호출
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				if(rs != null) rs.close();
			}catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		return board;
	} //getBoardByNum() 끝.
}
