package mvc.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//게시글 페이지당 조회결과 건수 상수 선언
	static final int LISTCOUNT = 5;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}

	/* ~~.do로 요청하는 모든 request는 BoardController가 제일먼저 처리  */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
	   String requestURL = request.getRequestURL().toString();	
       String requestURI = request.getRequestURI();
       String contextPath = request.getContextPath();
       String command = requestURI.substring(contextPath.length());
       String queryString 
         = request.getQueryString()==null?"":request.getQueryString();//get방식일때 쿼리스트링 얻기
       
       System.out.println("requestURL:" + requestURL);
       System.out.println("requestURI:" + requestURI);
       System.out.println("contextPath:" + contextPath);
       System.out.println("command:" + command);
       System.out.println("queryString:" + queryString);
       
       //응답으로 생성되는 객체의 문서타입 설정
       response.setContentType("text/html;charset=utf-8");
       response.setCharacterEncoding("utf-8");
       
       //URI 코멘드 요청에 따른 로직 분기 처리 후, 응답(view)페이지로 이동 처리
       if(command.equals("/BoardListAction.do")) {//등록된 게시글 목록 페이지 출력 요청
           //게시글 리스트 얻기 메소드
           RequestDispatcher rd = request.getRequestDispatcher("./board/list.jsp");
           rd.forward(request, response);
       }else if(command.equals("/BoardWriteForm.do")) {//새 게시글 등록 페이지 요청     
    	   //로그인 후 게시글 등록 페이지로 이동했는지, 로그인한 작성자 이름 얻기
           RequestDispatcher rd = request.getRequestDispatcher("./board/writeForm.jsp");
           rd.forward(request, response);
       }else if(command.equals("/BoardWriteAction.do")) {//새 게시글 등록 프로세스 페이지    
    	   //DB에 신규등록 게시글 저장
           RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");//게시글 등록후 게시글 리스트로 이동
           rd.forward(request, response);
       }else if(command.equals("/BoardViewAction.do")) {//게시글 상세보기 요청
    	   //게시글 리스트에서 글 번호에 해당하는 게시글 정보를 DB에서 얻기
           RequestDispatcher rd = request.getRequestDispatcher("./BoardView.do");//상세페이지 보기 요청
           rd.forward(request, response);
       }else if(command.equals("/BoardView.do")) {//상세페이지 용청
    	   //게시글 리스트에서 글 번호에 해당하는 게시글 정보를 DB에서 얻기
    	   //조회수 증가처리 hit = hit + 1
           RequestDispatcher rd = request.getRequestDispatcher("/board/view.jsp");
           rd.forward(request, response);
       }else if(command.equals("/BoardUpdateAction.do")) {//게시글 수정 처리 요청    	     
           RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");//게시글 리스트페이지로 이동
           //수정된 내용을 파라미터로 받아서 DB에 수정처리
           rd.forward(request, response);
       }else if(command.equals("/BoardDeleteAction.do")) {//게시글 삭제요청   	
    	   //삭제할 글 번호를 파라미터로 받아서 DB에서 삭제처리
           RequestDispatcher rd = request.getRequestDispatcher("/BoardListAction.do");//게시글 리스트로 이동
           rd.forward(request, response);
       }

	}
}