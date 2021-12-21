package mvc.bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;

public class BbsReplyForm implements ActionCommand {
	@Override
	public String action(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 후 게시글 등록 페이지로 이동했는지, 로그인 한 작성자 이름 얻기
	      requestLoginName(request);
	    
	    request.setAttribute("pageNum",request.getParameter("pageNum"));
	    request.setAttribute("items",request.getParameter("items"));
	    request.setAttribute("text",request.getParameter("text"));
	    request.setAttribute("num",request.getParameter("num"));
	    request.setAttribute("ref",request.getParameter("ref"));
	    request.setAttribute("re_step",request.getParameter("re_step"));
	    request.setAttribute("re_level",request.getParameter("re_level"));
	    
		return "./bbs/writeForm.jsp";
	}
	//인증된 사용자명 얻기
			private void requestLoginName(HttpServletRequest request) {
		        //파라미터로 넘어온 request의 id에 해당하는 값 얻기
				String id = request.getParameter("id");
				
				//DB에서 id에 해당하는 name정보 얻기
				BoardDAO dao = BoardDAO.getInstance();
				String name = dao.getLoginNameById(id);//id에 해당하는 name 얻기메소드
				
				request.setAttribute("writer", name);
			}
}