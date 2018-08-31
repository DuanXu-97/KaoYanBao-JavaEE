package com.kyb.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kyb.model.Tag;
import com.kyb.util.DButil;

public class TagDao {
	private DButil util = DButil.getInstance();
	private String sql=null;
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	public List<Tag> QueryTagByQuestionId(int id)      //根据题目ID查询相对应的tag并返回,此处id是QuestionbelongID
	{
		conn = util.getConnection();
        sql = "select * from tag where Question_belongId =?";
        List<Tag> list = new ArrayList<Tag>();        
        try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rs=ps.executeQuery();
			while(rs.next())
			{
				Tag tag = new Tag();
				tag.setId(rs.getInt("id"));
				tag.setName(rs.getString("name"));
				tag.setScore(rs.getInt("score"));
				list.add(tag);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(conn!=null) conn.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
        return list;
	}
     
	public List<String> QueryTagnameByQuestionId(int id)      //根据题目ID查询相对应的tag并返回,此处id是QuestionbelongID
	{
		conn = util.getConnection();
        sql = "select * from tag where Question_belongId =?";
        List<String> list = new ArrayList<String>();        
        try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rs=ps.executeQuery();
			while(rs.next())
			{
				list.add(rs.getString("name"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(conn!=null) conn.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
        return list;
	}
     
	
	
	
	public Map<String,Integer> QueryTagMapByQuestionId(int id)      //根据题目ID查询相对应的map,这个在推荐题目时需要并返回,此处id是QuestionbelongID
	{
		conn = util.getConnection();
        sql = "select * from tag where Question_belongId =?";
       Map<String, Integer> map = new HashMap<String, Integer>();
        try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rs=ps.executeQuery();
			while(rs.next())
			{
				map.put(rs.getString("name"), rs.getInt("score"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(conn!=null) conn.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
        return map;
	}

	
	public void AddTagByQuestionId(List<String> list,int q_id)      //根据题目的id添加标签。
	{	
            sql ="insert into tag(name,score,Question_belongId) values(?,?,?)";
			try {
				conn = util.getConnection();
				ps =conn.prepareStatement(sql);
				for(String tag:list) {
				ps.setString(1, tag);
				ps.setInt(2, 1);
				ps.setInt(3,q_id);
				ps.executeUpdate();
				}
			}
			catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			try {
				if(rs!=null) rs.close();
				if(conn!=null) conn.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
 
	public void DeleteTagByQuestionId(int q_id)      //根据题目id删除相对应题目的标签
	{
		
		conn = util.getConnection();
	    sql = "delete from tag where Question_belongId= ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, q_id);
			ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally
		{
			try {
				if(conn!=null) conn.close();
				if(ps!=null) ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
		}	
	}
  }

}
