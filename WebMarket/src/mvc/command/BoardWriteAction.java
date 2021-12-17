package mvc.command;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

public class BoardWriteAction implements Command{
	@Override
	public String action(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//새로운 글 등록하기
			//DB저장 객체 생성
			BoardDAO dao = BoardDAO.getInstance();
			
			//upload처리
		     String filename="";
		     String realFolder = "c:\\upload\\board";//웹 어플리케이션상의 절대 경로
		     int maxSize = 10 * 1024 * 1024;//5mb - 전송될 파일의 최대 크기
		     String encType = "utf-8";
		     
		     //MultipartRequest객체 생성
		     MultipartRequest multi 
		      = new MultipartRequest(request,
		    		                 realFolder,
		    		                 maxSize, 
		    		                 encType, 
		    		                 new DefaultFileRenamePolicy());
		     
			//request로 부터 파라미터 이름에 해당하는 값 얻기
			String id = multi.getParameter("id");
			String name = multi.getParameter("name");
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			
			//전송된 파일정보 얻기
			Enumeration files = multi.getFileNames();
			String fname =(String)files.nextElement();
			String fileName = multi.getFilesystemName(fname);//전송되어서 서버로 넘어온파일명
			   
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
			board.setAttachFile(fileName);
			
			//DAO에서 DB에 저장하기 위해 메소드 호출
			dao.insertBoard(board);

		return "/BoardListAction.do";
	}
}