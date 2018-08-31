package com.kyb.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kyb.model.User;
import com.kyb.service.InitUserTagsService;


/**
 * Servlet implementation class InitUserTagsServlet
 */
//@WebServlet("/InitUserTagsServlet")
public class InitUserTagsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InitUserTagsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Map<Integer, List<String>> map = new HashMap<Integer, List<String>>();
		InitUserTagsService IUTS  = new InitUserTagsService();
		HttpSession hs = request.getSession();
		int u_id = ((User)hs.getAttribute("Username")).getId();
		int length = Integer.parseInt(request.getParameter("length"));
		for(int i=0;i<length;i++) {
			int id = Integer.parseInt(request.getParameter(String.format("userInitialTags[%d][course_id]",i)));
			String tags = request.getParameter(String.format("userInitialTags[%d][initialTags]",i));
			if(!tags.equals("")) {
			int index = tags.indexOf('_');
			tags= tags.substring(index+1);
			String [ ] tagArray = tags.split("_");
			List<String> taglist = Arrays.asList(tagArray);  //将一个字符数组转换为list类型
			map.put(id,taglist);
		     }
		}
		IUTS.InitUserTags(u_id, map);
		PrintWriter writer = response.getWriter();
	    response.setContentType("application/json; charset=utf-8");
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
