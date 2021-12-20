package mvc.bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BbsListAction implements ActionCommand {

	@Override
	public String action(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return "./bbs/list.jsp";
	}

}