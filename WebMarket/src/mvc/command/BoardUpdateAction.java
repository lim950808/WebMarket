package mvc.command;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

public class BoardUpdateAction implements Command{
	@Override
	public String action(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//글 수정 처리
		 //파라미터로 넘어온 값 얻기
		 int num = Integer.parseInt(request.getParameter("num"));
		 int pageNum =Integer.parseInt(request.getParameter("pageNum"));
		 //검색조회 파라미터 얻기
		 String items =request.getParameter("items");
		 String text = request.getParameter("text");
		 
		 //DB억세스 객체 생성
		 BoardDAO dao = BoardDAO.getInstance();
		 
		 //BoardDTO객체 생성
		 BoardDTO board = new BoardDTO();
		 board.setId(request.getParameter("id"));
		 board.setNum(num);
		 board.setName(request.getParameter("name"));
		 board.setSubject(request.getParameter("subject"));
		 board.setContent(request.getParameter("content"));
		 
		 //등록(수정)일자 변경
		 SimpleDateFormat formatter =new SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		 String regist_day = formatter.format(new Date());
		 
		 board.setRegist_day(regist_day);
		 board.setIp(request.getRemoteAddr());
		
		 //수정 메소드 호출
		 dao.updateBoard(board);
		 
			//상세 글정보를 상세 페이지로 전달 위해 request에 세팅
			request.setAttribute("num", num);//글번호-autoBoxing(기본타입-래퍼객체로 자동형변환)
			request.setAttribute("page", pageNum);//페이지 번호
			request.setAttribute("board", board);//글 정보
			request.setAttribute("items", items);//검색 타입
			request.setAttribute("text", text);//검색어
		
		return "/BoardListAction.do";
	}

}