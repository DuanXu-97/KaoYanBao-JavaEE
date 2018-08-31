package com.kyb.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kyb.Dao.QuestionDao;
import com.kyb.Dao.TagDao;

/**
 * Servlet implementation class DeleteQuestionServlet
 */
//@WebServlet("/DeleteQuestionServlet")
public class DeleteQuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteQuestionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
       	 int  QuestionId = Integer.parseInt(request.getParameter("id"));
       	 QuestionDao  QD = new QuestionDao();
       	 TagDao  TD = new TagDao();
       	 TD.DeleteTagByQuestionId(QuestionId);  //根据题目id先删除标签
       	 int newid = QD.DeleteQuestionById(QuestionId);   //再根据题目id删除题目   	 
  	     PrintWriter writer = response.getWriter();
  	     response.setContentType("application/json; charset=utf-8");
  	     String json="{\"status\":\"success\"}";
  	     writer.write(json);  
  	     writer.close();			 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
