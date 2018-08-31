package com.kyb.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DButil {

private static final DButil util = new DButil();
	
	private  DButil() {
		// TODO Auto-generated constructor stub
	}
	
	public static DButil getInstance() {
		return util;
	}
	
	private Connection conn;
	private String url = "jdbc:mysql://localhost:3306/kyb?useUnicode=true&characterEncoding=utf8";
	private String user = "root";
	private String password = "root";
	private String className = "com.mysql.jdbc.Driver";
	

	public Connection getConnection() {
		try {
			Class.forName(className);
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
	
}
