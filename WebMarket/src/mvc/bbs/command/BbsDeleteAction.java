package mvc.bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.bbs.model.BbsDAO;

public class BbsDeleteAction implements ActionCommand {

	@Override
	public String action(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum=request.getParameter("pageNum");
		String items=request.getParameter("items");
		String text = request.getParameter("text");
		int num = Integer.parseInt(request.getParameter("num"));
		 
			//글 삭제 처리
			BbsDAO dao = BbsDAO.getInstance();
			dao.deleteBbs(num);
	
	   request.setAttribute("pageNum",request.getParameter("pageNum"));
	   request.setAttribute("items",request.getParameter("items"));
	   request.setAttribute("text",request.getParameter("text"));
	
		return "/BbsListAction.go";
	}
}