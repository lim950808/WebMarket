package mvc.bbs.command;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.bbs.model.BbsDAO;
import mvc.bbs.model.BbsDTO;

//페이징 처리
//글 리스트 얻기
public class BbsListAction implements ActionCommand {
	//게시글 페이지당 조회결과 건수 상수 선언
	static final int LISTCOUNT = 10;
	@Override
	public String action(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//등록된 글 목록 가져오기
		//DB억세스 객체 생성
		BbsDAO dao = BbsDAO.getInstance();
		List<BbsDTO> bbsList = new ArrayList<BbsDTO>();
		//게시판 이동시 첫 페이지 설정
		int pageNum=1;
		int limit = LISTCOUNT;//초기값 10
		
		//파라미터로 넘어온 페이지 번호가 있으면 해당 페이지 번호로 변경
		if(request.getParameter("pageNum")!=null)
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
		
		//검색조회 파라미터 얻기
		String items =request.getParameter("items");
		String text = request.getParameter("text");
				
		//DB로 부터 페이지당 갯수 별로 리스트 생성
		//boardList = dao.getBoardList(pageNum, limit);
		bbsList = dao.getBbsList(pageNum, limit, items, text);
		System.out.println("bbsList건수:"+bbsList.size());
		//int total_record = dao.getListCount();
		int total_record = dao.getBbsCount(pageNum, limit, items, text);
		
		//전체 글의 첫번째 번호
		int firstNum=dao.getFirstNum();
		int lastNum=dao.getLastNum();
		
		
		//전체 글 갯수 얻기1
		int total_page;
		
		//페이징처리
		if(total_record%limit==0) { // 예) 485건 -> 한페이지당 5건 출력 => 485=5*97+0, 97페이지
			total_page = total_record/limit;// 정수/정수 => 정수 
			Math.floor(total_page);// 버림
		}else {                    // 예) 487건 -> 한페이지당 5건 출력 => 487=5*97 + 2, 98페이지
			total_page = total_record/limit;//정수 /정수 => 정수
			Math.floor(total_page);
			total_page = total_page +1;// 자투리 건수를 위해 한 페이지 추가
		}
		
		//전체 페이지
		int finalPage = (total_record + (LISTCOUNT - 1))/LISTCOUNT;//103 , total_record=513, (513 +4)/5
		
		//페이지 세그먼트 처리
		int startPage =((pageNum -1)/10)*10 +1;  //1페이지 1, 2페이지 1, 6페이지 1, 11페이지 11, 19페이지11,20페이지 11,21페이지,21 
		int endPage =startPage + 10 -1;//1 + 10 -1=>10, 11+10-1=>20, 21+10-1=>30
		
		//페이지 보정
		if(endPage > finalPage) endPage = finalPage;
		
		
		//list.jsp(view페이지로 결과 전달)
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total_page", total_page);
		request.setAttribute("total_record", total_record);
		request.setAttribute("bbslist", bbsList);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("finalPage",finalPage);
		request.setAttribute("items", items);
		request.setAttribute("text", text);
		//전체 글 중 첫번째, 마지막 글 번호
		request.setAttribute("firstNum", firstNum);
		request.setAttribute("lastNum", lastNum);
		
		//이동할 페이지
		return "./bbs/list.jsp";
	}

}