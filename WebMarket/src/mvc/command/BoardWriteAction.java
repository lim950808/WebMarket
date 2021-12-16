package mvc.command;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

public class BoardWriteAction implements Command{
	@Override
	public String action(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//새로운 글 등록하기
			//DB저장 객체 생성
			BoardDAO dao = BoardDAO.getInstance();
			//request로 부터 파라미터 이름에 해당하는 값 얻기
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			
			//등록일자 정보 생성
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
			String regist_day = formatter.format(new Date());
			String ip = request.getRemoteAddr();
			
			//insertBoard()메소드에 넘길 객체 생성 후, 속성에 값 설정
			BoardDTO board = new BoardDTO();
			board.setId(id);
			board.setName(name);
			board.setSubject(subject);
			board.setContent(content);
			board.setRegist_day(regist_day);
			board.setHit(0);
			board.setIp(ip);
			
			//DAO에서 DB에 저장하기 위해 메소드 호출
			dao.insertBoard(board);

		return "/BoardListAction.do";
	}
}