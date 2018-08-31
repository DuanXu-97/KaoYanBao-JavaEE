package com.kyb.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kyb.model.Page;
import com.kyb.model.Question;
import com.kyb.model.User;
import com.kyb.service.QuestionService;

/**
 * Servlet implementation class QuestionQueryServlet
 */
//@WebServlet("/QuestionQueryServlet")
public class QuestionQueryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuestionQueryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		QuestionService QS = new QuestionService();
		HttpSession  hs = request.getSession();
		User u = (User)hs.getAttribute("Username");
		int pagenum =1;
		int pagesize =1;
		if (request.getParameter("pagenum")!=null)
		{
			pagenum = Integer.parseInt(request.getParameter("pagenum"));
		}
		int start = pagenum * pagesize - pagesize;
		Map<String, Object> map = QS.QuestionQueryByUserId(u.getId(),start, pagesize);
		List<Question> list = (List<Question>)map.get("list");
		int recordCount = (Integer)map.get("count");
		int pageCount = (recordCount-1) / pagesize + 1;
		
		Page page = new Page();
		page.setPagenum(pagenum);
		page.setPagesize(pagesize);
		page.setPageCount(pageCount);
		page.setRecordCount(recordCount);
		request.setAttribute("page", page);
		request.setAttribute("questionList", list);
		request.getRequestDispatcher("questionList.jsp").forward(request, response);
	}

}
