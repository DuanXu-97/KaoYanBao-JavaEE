package com.kyb.servlet;

import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kyb.Dao.QuestionDao;
import com.kyb.Dao.TagDao;
import com.kyb.model.*;
/**
 * Servlet implementation class AddQuestionServlet
 */
//@WebServlet("/AddQuestionServlet")
public class AddQuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddQuestionServlet() {
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
		
	   request.setCharacterEncoding("utf-8");
	   response.setContentType("text/html;charset=utf-8");
	   String  category = request.getParameter("category");
	   String tags = request.getParameter("tags");
	   int index = tags.indexOf('_');
	   tags= tags.substring(index+1);
	   String [ ] tagArray = tags.split("_");
	   List<String> taglist = Arrays.asList(tagArray);  //讲一个字符数组转换为list类型
	   for (String s : taglist) {
		   System.out.println(s);
		
	}
	   String title = request.getParameter("title");
	   String note = request.getParameter("note");
	   String answer  = request.getParameter("answer");
	   HttpSession   session   =   request.getSession();
	   User u = (User)session.getAttribute("Username");
	   int UserId,QuestionId;
	   UserId=u.getId();
	   System.out.println(UserId);
	   QuestionDao QD = new QuestionDao();
	   TagDao TD = new TagDao();
	   QuestionId= QD.AddQuestion(category,title,answer,note,UserId); //首先添加相应的题目
	   
	   System.out.println("创建题目之后的题目的id为"+QuestionId);
	  
	   TD.AddTagByQuestionId(taglist,QuestionId);   //其次添加相应的标签
	   PrintWriter writer = response.getWriter();
	   response.setContentType("application/json; charset=utf-8");
	   String json="{\"status\":\"success\"}";
	   writer.write(json);  
	   writer.close();		
	}

	private int AddQuestion(String category, String title, String answer, String note, int userId) {
		// TODO Auto-generated method stub
		return 0;
	}

}
