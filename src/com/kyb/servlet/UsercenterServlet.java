package com.kyb.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kyb.Dao.UserDao;
import com.kyb.model.User;

/**
 * Servlet implementation class UsercenterServlet
 */
//@WebServlet("/UsercenterServlet")
public class UsercenterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsercenterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	//	response.getWriter().append("Served at: ").append(request.getContextPath());
		
	//	System.out.println("test connnection");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String nickname= request.getParameter("nickname");
		String gender= request.getParameter("gender");
		String presentCollege = request.getParameter("presentCollege");        
        String targetCollege= request.getParameter("targetCollege");
        String motto = request.getParameter("motto");
		String birthday = request.getParameter("birthday");
		
		HttpSession hs = request.getSession();
		User u = (User)hs.getAttribute("Username");
		String usname = u.getUsername();
		u.setBirthday(birthday);
		u.setGender(gender);
		u.setMotto(motto);
		u.setNickname(nickname);
		u.setPresentCollege(presentCollege);
		u.setTargetCollege(targetCollege);   //更新6项信息将其session更新
		hs.setAttribute("Username",u);
		UserDao user = new UserDao();
		user.updateUserinfo(usname, nickname, gender, birthday, presentCollege, targetCollege, motto);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter writer = response.getWriter();
		String json="{\"status\":\"success\"}";
		writer.write(json);  
		writer.flush();  
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
