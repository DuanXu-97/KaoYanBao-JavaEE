package com.kyb.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.kyb.util.DButil;
import com.mysql.jdbc.Statement;

public class UserWeaknessDao {
	
	private DButil util = DButil.getInstance();
	private String sql=null;
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private ResultSet rs1 = null;
	
	private String sql1=null;
	private PreparedStatement ps1 = null;
	private String sql2=null;
	private PreparedStatement ps2 = null;
	
	
	public Map<String, Integer> QueryUserWeaknessTagById(int c_id)
	{   
		Map<String, Integer>  map =new HashMap<String, Integer>(); 
		conn = util.getConnection();
		sql = "select * from userweaknesstag where category_belong_id = ? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, c_id);
			rs =ps.executeQuery();
			while(rs.next())   
			{
				map.put(rs.getString("name"), rs.getInt("score"));//循环将查询到的用户的薄弱点添加进入map中
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map;	
	}
	
	public List<String> QueryUserWeaknessTagListById(int c_id)
	
	{  
		List<String>  list = new ArrayList<String>();
		conn = util.getConnection();
		sql = "select * from userweaknesstag where category_belong_id = ? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, c_id);
			rs =ps.executeQuery();
			while(rs.next())   
			{
				list.add(rs.getString("name"));//循环将查询到的用户的薄弱点添加进入map中
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;	
	}
		
	public int QueryUserWeaknessCategoryById(int u_id,String category)
	{
		conn = util.getConnection();
		System.out.println(category);
		sql = "select * from userweaknesscategory where user_belong_id = ?  AND name = ? ";
		int c_id = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, u_id);
			ps.setString(2, category);
			rs = ps.executeQuery();
			if(rs.next())
			{
				c_id = rs.getInt("id");
			}
			System.out.println("查询完成");
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
		return c_id;
		
	}
    
    public List<Set<String>> getRecord(String category,int u_id){
    	//返回该学科，该数据库中其他用户的薄弱项集
    	UserDao UD = new UserDao();
    	UserWeaknessDao UWD = new UserWeaknessDao();
    	List<Set<String>>  record_list = new ArrayList<Set<String>>();
    	Set<String> templist = new HashSet<String>();
    	int admin_id = 20;
    	int u_c_id;
    	List<Integer> list = new ArrayList<Integer>();
    	list = UD.QueryIdDbUsers(admin_id, u_id);  //返回除管理员和当前用户之外的所有其他用户的id
    	for(Integer user_id:list)
    	{
    		u_c_id = UWD.QueryUserWeaknessCategoryById(user_id, category);
    		templist = new HashSet<String>(QueryUserWeaknessTagListById(u_c_id));
    		record_list.add(templist);
    	}
    	return record_list;
    }
    
    public void InitUserTags(int c_id,int u_id,List<String> list)
    {
    	conn = util.getConnection();
    	String category= null;
    	sql = "INSERT INTO userweaknesscategory(name,user_belong_id) values(?,?)";
    	sql1 = "select * from  commonweaknesscategory where id = ?";
    	sql2 = "INSERT INTO userweaknesstag(name,score,category_belong_id) values(?,?,?)";
    	int new_gen_id=0;
    	try {
    		ps1 = conn.prepareStatement(sql1);
    		ps1.setInt(1,c_id);
    		rs1 = ps1.executeQuery();
    		if(rs1.next()) {
    		    category =rs1.getString("name");
    		}
			ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
			ps.setString(1,category);
			ps.setInt(2,u_id);
		    ps.executeUpdate();           //在用户标签处创建一个用户标签
            rs = ps.getGeneratedKeys();
            if(rs.next()) {	
            	new_gen_id = rs.getInt(1);
            }
		    ps2 = conn.prepareStatement(sql2);
		    if(list.size()!=0) {
		    for(String tagname:list) {
		    	ps2.setString(1, tagname);
		    	ps2.setInt(2, 1);
		    	ps2.setInt(3,new_gen_id);	
		    	ps2.executeUpdate();
		    	}        //循环插入用户的标签
		    }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
				rs.close();
				if(rs1!=null)
					rs1.close();
				if(ps!=null)
				ps.close();
				if(ps1!=null)
					ps1.close();
				if(ps2!=null)
					ps2.close();
				if(conn!=null)
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
    	
    }

    public boolean is_have_thistag(List<String> list,int u_id,String category)
    {
		conn = util.getConnection();
		List<String > taglist = new ArrayList<String>();
		Set result = new HashSet(list);
		int c_id = this.QueryUserWeaknessCategoryById(u_id,category);  //获取用户薄弱标签
		taglist = this.QueryUserWeaknessTagListById(c_id);
		Set tagresult = new HashSet(taglist);
		if(tagresult.containsAll(result))
		{
			return true;
		}
		else 
			return false;
    }

}
