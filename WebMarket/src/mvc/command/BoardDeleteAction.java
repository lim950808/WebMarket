package mvc.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;

public class BoardDeleteAction implements Command{
	@Override
	public String action(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//선택글 삭제 처리
	   	 //파라미터로 넘어온 값 얻기
	   	 int num = Integer.parseInt(request.getParameter("num"));
	   	 int pageNum =Integer.parseInt(request.getParameter("pageNum"));
		 //검색조회 파라미터 얻기
		 String items =request.getParameter("items");
		 String text = request.getParameter("text");
		 
	   	 //DB억세스 객체 생성
	   	 BoardDAO dao = BoardDAO.getInstance();
	   	 dao.deleteBoard(num);
	   	 
			//상세 글정보를 상세 페이지로 전달 위해 request에 세팅
			request.setAttribute("num", num);//글번호-autoBoxing(기본타입-래퍼객체로 자동형변환)
			request.setAttribute("page", pageNum);//페이지 번호
			request.setAttribute("items", items);//검색 타입
			request.setAttribute("text", text);//검색어
		
		return "/BoardListAction.do";
	}

}