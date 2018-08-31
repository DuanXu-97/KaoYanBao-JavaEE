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
		System.out.println("�û���"+usname);
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

	
	public static String GetImageStr(String imgFilePath) {// ��ͼƬ�ļ�ת��Ϊ�ֽ������ַ��������������Base64���봦��
        byte[] data = null;

        // ��ȡͼƬ�ֽ�����
        try {
            InputStream in = new FileInputStream(imgFilePath);
            data = new byte[in.available()];
            in.read(data);
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        // ���ֽ�����Base64����
        java.util.Base64.Encoder encoder = Base64.getEncoder();
        return encoder.encodeToString(data);// ����Base64��������ֽ������ַ���
    }

    public static boolean GenerateImage(String imgStr, String imgFilePath) {// ���ֽ������ַ�������Base64���벢����ͼƬ
        if (imgStr == null) // ͼ ������Ϊ��
            return false;
        System.out.println("���Լ���ִ��");
        Decoder decoder = Base64.getDecoder();
        try {
            // Base64����
            byte[] bytes = decoder.decode(imgStr);
            for (int i = 0; i < bytes.length; ++i) {
                if (bytes[i] < 0) {// �����쳣����
                    bytes[i] += 256;
                }
            }

            // ����jpegͼƬ
            File file = new File(imgFilePath);
            if (!file.exists()) {
                file.createNewFile();
            }
            OutputStream out = new FileOutputStream(file);
            System.out.println("����ļ��ɹ���");
            out.write(bytes);
            out.flush();
            out.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
