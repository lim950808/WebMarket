package mvc.bbs.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ActionCommand {
	public String action(HttpServletRequest request, 
			 HttpServletResponse response) throws Exception;
}