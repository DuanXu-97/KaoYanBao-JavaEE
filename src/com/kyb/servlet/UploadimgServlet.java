package com.kyb.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.Base64.Decoder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import com.kyb.Dao.UserDao;
import com.kyb.model.User;

/**
 * Servlet implementation class UploadimgServlet
 */
//@WebServlet("/UploadimgServlet")
public class UploadimgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadimgServlet() {
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
		
		HttpSession hs = request.getSession();
		User u = (User)hs.getAttribute("Username");
		String usname = u.getUsername();
		UserDao uu = new UserDao();
		System.out.println("用户名"+usname);
		String strImg = request.getParameter("img");
		String strIMGG[] = strImg.split(",", 2);
		System.out.println(strIMGG[1]);
		String avatarFilename = usname+".jpg";
		String savePath = this.getServletContext().getRealPath("/");
		String abpath="../";
		System.out.println("savepath"+savePath);
		GenerateImage(strIMGG[1], savePath+avatarFilename);
		u.setAvatarPath(avatarFilename);
		
		hs.setAttribute("Username",u);
		uu.saveAvatarpath(avatarFilename, usname);	
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

	
	public static String GetImageStr(String imgFilePath) {// 将图片文件转化为字节数组字符串，并对其进行Base64编码处理
        byte[] data = null;

        // 读取图片字节数组
        try {
            InputStream in = new FileInputStream(imgFilePath);
            data = new byte[in.available()];
            in.read(data);
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 对字节数组Base64编码
        java.util.Base64.Encoder encoder = Base64.getEncoder();
        return encoder.encodeToString(data);// 返回Base64编码过的字节数组字符串
    }

    public static boolean GenerateImage(String imgStr, String imgFilePath) {// 对字节数组字符串进行Base64解码并生成图片
        if (imgStr == null) // 图 像数据为空
            return false;
        System.out.println("可以继续执行");
        Decoder decoder = Base64.getDecoder();
        try {
            // Base64解码
            byte[] bytes = decoder.decode(imgStr);
            for (int i = 0; i < bytes.length; ++i) {
                if (bytes[i] < 0) {// 调整异常数据
                    bytes[i] += 256;
                }
            }

            // 生成jpeg图片
            File file = new File(imgFilePath);
            if (!file.exists()) {
                file.createNewFile();
            }
            OutputStream out = new FileOutputStream(file);
            System.out.println("输出文件成功！");
            out.write(bytes);
            out.flush();
            out.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
