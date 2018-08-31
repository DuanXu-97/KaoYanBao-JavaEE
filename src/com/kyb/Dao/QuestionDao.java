package com.kyb.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.kyb.util.DButil;
import com.sun.org.apache.bcel.internal.generic.RETURN;
import com.sun.scenario.effect.impl.state.LinearConvolveRenderState.PassType;
import com.kyb.model.Question;
import com.kyb.model.Tag;

public class QuestionDao {
	
	private DButil util = DButil.getInstance();
	private String sql=null;
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	/*返回该数据库中所有的错题
	 * 
	 */
	public List<Question> QueryQuestionAll() {    
		conn = util.getConnection(); 
		sql = "select * from question";
		List<Question> list = new ArrayList<Question>();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				Question  Q = new Question();
				Q.setId(rs.getInt("id"));
				Q.setNote(rs.getString("title"));
				Q.setAnswer(rs.getString("answer"));
				Q.setCategory(rs.getString("Category"));
				Q.setNote(rs.getString("note"));
				Q.setCreated_date(rs.getTimestamp("created_date"));
				Q.setModified_date(rs.getTimestamp("modified_date"));	
				list.add(Q);	
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

	public List<Question> QueryQuestionByUserId(int id,int start,int pagesize){
			/*返回爱数据库中某个人的所有错题
	 * 
	 */
		conn = util.getConnection(); 
		sql = "select * from question where UserbelongId=? limit ?,?";
		List<Question> list = new ArrayList<Question>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ps.setInt(2, start);
			ps.setInt(3, pagesize);
			rs = ps.executeQuery();
			while(rs.next()) {
				Question  Q = new Question();
				Q.setId(rs.getInt("id"));
				Q.setTitle(rs.getString("title"));
				Q.setAnswer(rs.getString("answer"));
				Q.setCategory(rs.getString("Category"));
				Q.setNote(rs.getString("note"));
				Q.setCreated_date(rs.getTimestamp("created_date"));
				Q.setModified_date(rs.getTimestamp("modified_date"));	
				list.add(Q);	
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
	
	public List<Question> QueryQuestionByUserId(int id){
		/*返回爱数据库中某个人的所有错题,在题库推荐管理员题目时需要
 * 
 */
	conn = util.getConnection(); 
	sql = "select * from question where UserbelongId =?";
	List<Question> list = new ArrayList<Question>();
	try {
		ps = conn.prepareStatement(sql);
		ps.setInt(1, id);
		rs = ps.executeQuery();
		while(rs.next()) {
			Question  Q = new Question();
			Q.setId(rs.getInt("id"));
			Q.setTitle(rs.getString("title"));
			Q.setAnswer(rs.getString("answer"));
			Q.setCategory(rs.getString("Category"));
			Q.setNote(rs.getString("note"));
			Q.setCreated_date(rs.getTimestamp("created_date"));
			Q.setModified_date(rs.getTimestamp("modified_date"));	
			list.add(Q);	
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
	
	public List<Question> QueryQuestionByCategory(int id, String category,int start,int pagesize) {
		conn = util.getConnection();
		List<Question> list = new ArrayList<Question>();
		sql = "select * from Question where UserbelongId = ? And category = ? limit ?,?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ps.setString(2, category);
			ps.setInt(3, start);
			ps.setInt(4, pagesize);
			rs = ps.executeQuery();
			while(rs.next()) {
				Question  Q = new Question();
				Q.setId(rs.getInt("id"));
				Q.setTitle(rs.getString("title"));
				Q.setAnswer(rs.getString("answer"));
				Q.setCategory(rs.getString("Category"));
				Q.setNote(rs.getString("note"));
				Q.setCreated_date(rs.getTimestamp("created_date"));
				Q.setModified_date(rs.getTimestamp("modified_date"));	
				list.add(Q);	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}			try {
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
		return list;
	}
		
	public int getCount(int id) {
		conn = util.getConnection();
		sql = "select count(*) c from question where UserbelongId=? ";
		int recordCount = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			rs = ps.executeQuery();
			if (rs.next()) {
				recordCount = rs.getInt("c");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return recordCount;
	}
	
	public int getCount(int id,String category) {
		conn = util.getConnection();
		sql = "select count(*) c from question where UserbelongId=? And category =?";
		int recordCount = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1,id);
			ps.setString(2, category);
			rs = ps.executeQuery();
			if (rs.next()) {
				recordCount = rs.getInt("c");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return recordCount;
	}	
	
	public int  AddQuestion(String category,String title,String answer,String note,int UserbelongId) {
		/*添加错题
		 * 
		 */
		conn = util.getConnection(); 
		sql =" INSERT INTO question (id,title,category,answer,note,UserbelongId ) values(null,?,?,?,?,?)";
		int newid=0;
		try {
			ps = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1,title);
			ps.setString(2,category);
			ps.setString(3,answer);
			ps.setString(4,note);
			ps.setInt(5, UserbelongId);
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
	
	public int  DeleteQuestionById(int id) {      //根据问题id删去相应的问题
		conn = util.getConnection();
		sql ="delete from question where id =?";
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
	
	public Map<String, Integer> QueryQuestionTagById(int id){
	  //根据题目的id查找一道题目的标签和相应的评分
    	conn = util.getConnection();
    	sql = "select * from Tag where Question_belongId = ?";
    	Map<String,Integer> map = new HashMap<String,Integer>();
    	try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			while(rs.next())
			{
				map.put(rs.getString("name"), rs.getInt("score"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
	}
    	return map;
}
	
	public List<Question> is_equal_add(List<String> list)  //判断有没有交集，有交集则加入
	{
		List <Question>  qlist = new ArrayList<Question>();
		TagDao tDao = new TagDao();
		Set <String> tag_set = new HashSet<String>(list);
		qlist = this.QueryQuestionAll();
		for(Question q:qlist)
		{
			List<String> taglist = new ArrayList<String>();
			taglist = tDao.QueryTagnameByQuestionId(q.getId());
			Set <String> qSet = new HashSet<String>(taglist);
			Set <String> result = new HashSet<String>();
			result.addAll(qSet);
			result.retainAll(tag_set);
			if(!result.isEmpty()) {		
				qlist.add(q);
			}
		}
		return qlist;
	}
    	
	
}