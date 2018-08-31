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
import com.kyb.util.Sha1Util;

/**
 * Servlet implementation class LoginServlet
 */
//@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String username = request.getParameter("username");
		String password = request.getParameter("password");	
//		String svc =(String) request.getSession().getAttribute("sessionverify");
		//
		UserDao u=new UserDao();
		String psw = u.findUsername(username);
        Sha1Util sh1 = new Sha1Util();
        password =  sh1.getDigestOfString(password.getBytes()); 
		int userid= u.findUserid(username);
		User uu = u.QueryUserById(userid);
		String[] Sessionid= new String[]{request.getParameter("userid"),request.getParameter("passwd")};//id被转化成了字符串
		if(psw==null)
		{
			PrintWriter writer = response.getWriter();
		    response.setContentType("application/json; charset=utf-8");
			String json="{\"status\":\"fail\",\"msg\":\"抱歉，没有这个用户\"}";
		    writer.write(json);  
		    writer.flush();  
		    writer.close();
		}
		else if(!psw.equals(password)) {
			PrintWriter writer = response.getWriter();
		    response.setContentType("application/json; charset=utf-8");
			String json="{\"status\":\"fail\",\"msg\":\"抱歉，密码错误\"}";
		    writer.write(json);  
		    writer.flush();  
		    writer.close();
		}
		else if(psw.equals(password)) {
			if(u.is_User_active(username)==true) {
			this.setSession(request,uu,Sessionid[0]);
			PrintWriter writer = response.getWriter();
		    response.setContentType("application/json; charset=utf-8");
			String json="{\"status\":\"success\",\"url\":\"index.jsp\"}";
		    writer.write(json);  
		    writer.flush();  
		    writer.close();
			}
			else
			{
				PrintWriter writer = response.getWriter();
			    response.setContentType("application/json; charset=utf-8");
				String json="{\"status\":\"fail\",\"msg\":\"User is not activated\"}";
			    writer.write(json);  
			    writer.flush();  
			    writer.close();
			}
		    
		}
   }

    public void setSession(HttpServletRequest req,User uu,String sessionid)
    {
    	HttpSession  hs = req.getSession(true);
    	String id=hs.getId();
		hs.setMaxInactiveInterval(12*60);
		hs.setAttribute("Username",uu);
		hs.setAttribute("id",sessionid);
		hs.setAttribute("pass","user");
    }
    
 }
