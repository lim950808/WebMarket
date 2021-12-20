package mvc.bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.bbs.model.BbsDAO;
import mvc.bbs.model.BbsDTO;

public class BbsWriteAction implements ActionCommand {

	@Override
	public String action(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String writer =request.getParameter("writer");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String reg_date =request.getParameter("reg_date");
		String password =request.getParameter("password");
		String ip = request.getRemoteAddr();
		
		BbsDTO bbs = new BbsDTO();
		bbs.setWriter(writer);
		bbs.setSubject(subject);
		bbs.setContent(content);
		bbs.setPassword(password);
		bbs.setIp(ip);
		
		//글 등록 처리
		BbsDAO dao = BbsDAO.getInstance();
		dao.insertBbs(bbs);
		
		//글 등록 후 리스트로 이동처리
		return "/BbsListAction.go";
	}

}