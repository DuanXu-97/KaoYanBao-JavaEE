package com.kyb.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kyb.model.User;
import com.kyb.util.DButil;



public class UserDao {
	private DButil util = DButil.getInstance();
	private Connection conn;
	private PreparedStatement ps;
	private PreparedStatement ps2;
	private ResultSet rs;
	private ResultSet rs2;
	private String sql;
	private String sql2;
//	private boolean judge;
	
	//通过用户名字查找password
	public String findUsername(String username){
			String psw=null;;
			conn = util.getConnection();
			sql ="select * from user where username=?";			
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, username);
				rs = ps.executeQuery();
				if(rs==null) {
					return null;
				}
				if(rs.next()) {
					psw=rs.getString("password");
				}
				else {
					psw = null;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				try {
					if(ps!=null)ps.close();
					if(conn!=null)conn.close();
					if(rs!=null)rs.close();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			}		
			return psw;
	}
	
	public boolean is_User_active(String username){
		boolean emm = false;
		conn = util.getConnection();
		sql ="select * from user where username=?";			
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			rs = ps.executeQuery();
			if(rs.next()) {
				emm=rs.getBoolean("is_active");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
				if(rs!=null)rs.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}		
		return emm;
}
	
	
	//通过用户名查找id
	public int  findUserid(String username){
		int  id=-1 ;
		conn = util.getConnection();
		sql = "select * from user where username=?";	
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			rs = ps.executeQuery();
			if(rs==null)
			{
				return -1;
				
			}
			if(rs.next())
			{
				id = rs.getInt("id");
			}
			else {
				id = -1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}	
		//System.out.println("查找了一个用户");
	return id;		
	}	
	//直接查找email是否存在
	public boolean findUseremailexit(String email,String username) {
		boolean emm = false;
		conn = util.getConnection();
		sql ="select * from user where email=? ";  
		sql2 = "select * from user where username =?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			rs2 = ps2.executeQuery();
			if(rs==null&&rs2==null)
			{
				emm = true;
				
			}
			else {
				emm = false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
				if(rs!=null)rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return emm;
	}
	//添加用户	
	public void addUser(String username,String psw,String email)
	{
			conn = util.getConnection();			
			sql="INSERT  INTO user(username,password,email,is_active,avatarPath) VALUES(?,?,?,false,?)";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1,username);
				ps.setString(2,psw);
				ps.setString(3,email);
				ps.setString(4,"user.jpg");
				ps.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				try {
					if(ps!=null)ps.close();
					if(conn!=null)conn.close();
					if(rs!=null)rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
	}
	//通过id查找用户
	public User QueryUserById(int id) {
	conn = util.getConnection();
	String sql = "select * from user where id=?";
	User u = new User();
	try {	
	ps = conn.prepareStatement(sql);
	ps.setInt(1, id);
	rs = ps.executeQuery();
	if (rs.next())
	{
	   u.setUsername(rs.getString("username"));
	   u.setId(rs.getInt("id"));
	   u.setEmail(rs.getString("email"));
	   u.setPassword(rs.getString("password"));
	   u.setIs_active(rs.getBoolean("is_active"));
	   u.setBirthday(rs.getString("birthday"));
	   u.setGender(rs.getString("gender"));
	   u.setMotto(rs.getString("motto"));
	   u.setNickname(rs.getString("nickname"));
	   u.setTargetCollege(rs.getString("targetCollege"));
	   u.setPresentCollege(rs.getString("presentCollege"));
	   u.setAvatarPath(rs.getString("avatarPath"));   
	}
	else {
	   u.setUsername(null);
	   u.setId(1);
	   u.setEmail(null);
	   u.setPassword(null);
	   u.setIs_active(false);
	}
    }catch(SQLException e) {
		e.printStackTrace();
	}finally {
		try {
			if(ps!=null)ps.close();
			if(conn!=null)conn.close();
			if(rs!=null)rs.close();
			} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	 return  u;
	
  }	
	
	public void ActiveUser(String username)
	{
		conn = util.getConnection();
		sql ="update user u set u.is_active=true where u.username = ? ";  
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
    public List<Integer> QueryIdDbUsers(int admin_id,int u_id) { 
    	//查找除自己和管理员之外的其他用户的所有id
    	conn = util.getConnection();
    	sql = "select * from user where id!=? and id=? ";
    	List<Integer> list = new  ArrayList<Integer>();
    	try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, admin_id);
			ps.setInt(2, u_id);
			rs = ps.executeQuery();
			while(rs.next())
			{
				list.add(rs.getInt("id"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return list;
    	
    }
 
public void updateUserpsd(String username,String passward) {
		
		conn = util.getConnection(	);
		sql = "update user set password =?where username=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, passward);
			ps.setString(2, username);
			ps.executeUpdate();
			System.out.println("update success!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(ps!=null) {
					ps.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void updateUserinfo(String username,String nickname,String gender,String birthday,String presentCollege,String targetCollege,String motto) {
		conn = util.getConnection();
		sql = "update user set nickname=? ,gender=?,birthday=?,presentCollege=?,targetCollege=?,motto=? where username =?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, nickname);
			ps.setString(2, gender);
			ps.setString(3, birthday);
			ps.setString(4, presentCollege);
			ps.setString(5, targetCollege);
			ps.setString(6, motto);
			ps.setString(7, username);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(ps!=null) {
					ps.close();
				}
				if(conn!=null) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}			
	}

	public void saveAvatarpath(String avatarPath,String username) {
		conn = util.getConnection();
		sql="update user set avatarPath=? where username =?  ";
		//System.out.println(avatarPath);
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, avatarPath);
			ps.setString(2, username);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
