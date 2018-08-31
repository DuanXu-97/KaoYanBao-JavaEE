package com.kyb.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import com.kyb.util.DButil;

import com.kyb.model.News;

public class NewsDao {
	private DButil util = DButil.getInstance();
	private String sql=null;
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	//返回数据库中所有新闻
	public List<News> QueryNewsAll() { 
		conn = util.getConnection(); 
		sql = "select * from news order by date desc";
		List<News> list = new ArrayList<News>();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				News N = new News();
				N.setId(rs.getInt("id"));
				N.setTitle(rs.getString("title"));
				N.setContent(rs.getString("content"));
				N.setDate(new Date(rs.getTimestamp("date").getTime()));
				N.setUrl(rs.getString("url"));
				
				list.add(N);	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
				rs.close();
				if(ps!=null)
				ps.close();
				if(conn!=null)
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
	
	
	public int AddNews(String title,String content,Date date,String url) {
		//添加新闻
		
		conn = util.getConnection(); 
		sql =" INSERT INTO news (id,title,content,date,url) values(null,?,?,?,?)";
		int newid=0;
		try {
			ps = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1,title);
			ps.setString(2,content);
			ps.setTimestamp(3, new java.sql.Timestamp(date.getTime()));  
			ps.setString(4,url);
			ps.executeUpdate();
		    rs = ps.getGeneratedKeys(); 
		    rs.next();
	        newid =rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if (ps!=null) ps.close();
				if(conn!=null) ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return newid;
	}
	
	public boolean isExist(String url) {
		//根据url判断该新闻是否已经存在
		conn = util.getConnection(); 
		sql = "select * from news where url=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, url);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				return true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
				rs.close();
				if(ps!=null)
				ps.close();
				if(conn!=null)
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return false;
	}
	
	
	public int DeleteNewsById(int id) {   //根据新闻id删去相应的新闻
		conn = util.getConnection();
		sql ="delete from news where id =?";
		int newid=0;
		try {
			ps = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1,id);
			ps.executeUpdate();
		    rs = ps.getGeneratedKeys();  
	        newid =rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if (ps!=null) ps.close();
				if(conn!=null) ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return newid;
	}

}
