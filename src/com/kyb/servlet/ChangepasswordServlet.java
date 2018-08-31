package com.kyb.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.kyb.Dao.UserDao;
import com.kyb.model.User;
import com.kyb.util.Sha1Util;



/**
 * Servlet implementation class ChangepasswordServlet
 */
//@WebServlet("/ChangepasswordServlet")
public class ChangepasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangepasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String ps1 = request.getParameter("previousPassword");
		String ps2 = request.getParameter("newPassword1");

		
		
		HttpSession hs= request.getSession();
		User u = (User)hs.getAttribute("Username");
		String usname = u.getUsername();
        Sha1Util sh1 = new Sha1Util();
		UserDao user = new UserDao();
		String ps3 =user.findUsername(usname);
		ps1 = sh1.getDigestOfString(ps1.getBytes());   //原密码sha1加密
		if(!ps3.equals(ps1)) {
			System.out.println("原密码错误");	
			response.setContentType("application/json; charset=utf-8");
			PrintWriter writer = response.getWriter();
			String json="{\"status\":\"fail\"}";
			writer.write(json);  
			writer.flush();  
		    writer.close();
		}
		else {
	        ps2 =  sh1.getDigestOfString(ps2.getBytes());   //新密码SHA1加密
			user.updateUserpsd(usname, ps2);
			response.setContentType("application/json; charset=utf-8");
			PrintWriter writer = response.getWriter();
			String json="{\"status\":\"success\"}";
			writer.write(json);  
			writer.flush();  
		    writer.close();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
