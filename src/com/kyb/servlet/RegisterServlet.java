package com.kyb.servlet;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kyb.Dao.UserDao;
import com.kyb.service.EmailActiveService;
import com.kyb.util.Sha1Util;
import com.sun.xml.internal.ws.spi.db.PropertyAccessor;

import net.sf.json.JSONObject;
import java.io.PrintWriter;
/**
 * Servlet implementation class RegisterServlet
 */
//@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
		response.setContentType("application/json;charset=utf-8");
		String username = request.getParameter("username");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");      //得到表单输入的内容
		String email =request.getParameter("email");
		if(username==null||username.trim().isEmpty())
		{
			PrintWriter writer = response.getWriter();
		    response.setContentType("application/json; charset=utf-8");
			String json="{\"status\":\"success\",\"msg\":\"用户名不能为空\"}";
		    writer.write(json);  
		    writer.flush();  
		    writer.close();
		}
		else if(password1==null||password1.trim().isEmpty()){
			PrintWriter writer = response.getWriter();
		    response.setContentType("application/json; charset=utf-8");
			String json="{\"status\":\"success\",\"msg\":\"密码不能为空\"}";
		    writer.write(json);  
		    writer.flush();  
		    writer.close();
		}
		else if(email==null||email.trim().isEmpty()){
			PrintWriter writer = response.getWriter();
		    response.setContentType("application/json; charset=utf-8");
			String json="{\"status\":\"success\",\"msg\":\"邮箱不能为空\"}";
		    writer.write(json);  
		    writer.flush();  
		    writer.close();
		}
		else if(!password1.equals(password2)) {
			PrintWriter writer = response.getWriter();
		    response.setContentType("application/json; charset=utf-8");
			String json="{\"status\":\"success\",\"msg\":\"两次密码不相同\"}";
		    writer.write(json);  
		    writer.flush();  
		    writer.close();
		}
		else {
		UserDao u = new UserDao();
		EmailActiveService EAS = new EmailActiveService();
        Sha1Util sh1 = new Sha1Util();
        String Sha1Psw =  sh1.getDigestOfString(password1.getBytes()); 
        System.out.println("已加密");
		u.addUser(username,Sha1Psw,email);
		System.out.println("已注册");
		try {
			EAS.send_email_service(email,username);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		PrintWriter writer = response.getWriter();
	    response.setContentType("application/json; charset=utf-8");
		String json="{\"status\":\"success\"}";
	    writer.write(json);  
	    writer.flush();  
	    writer.close();
	 }
	}
}
