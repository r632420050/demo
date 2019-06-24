package com.yunpan.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * 数据库连接工具类
 * @author Administrator
 * @version 1.0
 */
public class ConnectUtils {

	//用户名
	private static String user = null;
	//密码
	private static String password = null;
	//请求的url
	private static String url = null;
	//请求的驱动包
	private static String driver = null;
	
	
	static{
		Properties prop = new Properties();
		try {
			//装载文件
			prop.load(ConnectUtils.class.getClassLoader().getResourceAsStream("db.properties"));
			user = prop.getProperty("user");
			password = prop.getProperty("password");
			url = prop.getProperty("url");
			driver = prop.getProperty("driver");
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 获取数据库连接
	 * @return
	 */
	public static Connection getConnection(){
	Connection conn = null;
	   try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
		} catch (Exception e) {

			e.printStackTrace();
		}	
       return conn;		
	}
	
	/**
	 * 关闭连接
	 * @param conn
	 * @param stmt
	 * @param rs
	 */
	public static void closeConnection(Connection conn, Statement stmt ,ResultSet rs){
		
		if(rs != null){
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(stmt != null){
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(conn != null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
	}
	
	public static void main(String[] args) {
		System.out.println(getConnection());
	}
	
}
