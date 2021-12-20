package mvc.bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;

public class BbsWriteForm implements ActionCommand {
	@Override
	public String action(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
		 //로그인 후 게시글 등록 페이지로 이동했는지, 로그인 한 작성자 이름 얻기
	       requestLoginName(request); 
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