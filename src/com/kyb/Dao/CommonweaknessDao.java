package com.kyb.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kyb.model.Commontags;
import com.kyb.model.Course;
import com.kyb.util.DButil;

public class CommonweaknessDao {
	
	private DButil util = DButil.getInstance();
	private String sql=null;
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	public List<Course> QueryCourseAll() {    //返回公共标签中的所有科目标签
		conn = util.getConnection();
		sql = "select * from commonweaknesscategory ";		
		List<Course> list = new ArrayList<Course>();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next())
			{  
				Course course = new Course();
				course.setId(rs.getInt("id"));
				course.setName(rs.getString("name"));
				list.add(course);
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

	public List<Commontags> QueryCommontagsByCid(int c_id){       //返回该科目的所有公共标签
		conn = util.getConnection();
		sql = "select * from commonweaknesstag where category_belong_id = ?";	
		List<Commontags> list = new ArrayList<Commontags>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, c_id);
			rs = ps.executeQuery();
			while(rs.next()) {
				Commontags commontags = new Commontags();
				commontags.setId(rs.getInt("id"));
				commontags.setName(rs.getString("name"));
				list.add(commontags);
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
}
