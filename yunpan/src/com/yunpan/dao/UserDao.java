package com.yunpan.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.yunpan.bean.User;
import com.yunpan.util.ConnectUtils;




/**
 * 
 * Copyright (c) 2019 by EE 
 *
 * <p>类描述： TODO(这里用一句话描述这个类的作用)</p>
 * <p>类 名： UserDao</p>
 * <p>创建人： EE</p>
 * <p>创建时间： 2019年4月23日下午4:18:20 </p>
 * <p>修改备注：</p>
 * @Vsersion:1.0
 */
public class UserDao {
	
   private static final	String finduser_by_account_password_sql = "select * from  tm_user where account=? and password = ?";
   private static final	String finduser_by_account_sql = "select * from  tm_user where account=?";
   private static final String SAVE_USER_SQL = "insert into tm_user(account, password,username,headerpic, age, birthday,address,email,male,telephone,description) values(?,?,?,?,?,?,?,?,?,?,?)";

   

   
   /**
    * 
    *<p>功能描述: TODO(这里用一句话描述这个方法的作用)</p>
    *<p>方法名 : getUserByAccountPassword</p>
    *<p>返回类型：User</p> 
    *<p>创建人： EE</p>
    *<p>创建时间： 2019年4月23日下午4:15:18</p>
    * @return User
    * @param account
    * @param password  
    * @since 1.0.0
    */
   
	public static User getUserByAccountPassword(String account, String password){
     User user = null;
     
     Connection conn = null;
     PreparedStatement statement = null;    
     ResultSet rs = null;
     try{
    	//1、获取连接
    	 conn = ConnectUtils.getConnection();	 
    	//2、获取处理块\缓冲块
    	 statement = conn.prepareStatement(finduser_by_account_password_sql);
    	//设置参数
    	 statement.setString(1, account);
    	 statement.setString(2, password);
    	 //4、执行sql
    	 statement.execute();
	     //5、获取结果集
	     rs = statement.getResultSet();
	     //6、获取用户信息
	     if(rs.next()){
	       user = getUserByResultSet(rs);
	     }
     }catch(Exception e){
    	 e.printStackTrace();
     }finally{
    	 ConnectUtils.closeConnection(conn,statement,rs);
     }
     return user;		 		 
	}
	
	

	/**
	 * 
	 * <p>功能描述: 根据账号查找用户信息</p>
	 * <p>方法名 : getUserByAccount</p>
	 * <p>创建人： EE</p>
	 * <p>创建时间： 2019年4月23日下午4:19:00</p>
	 * @return User
	 * @param account
	 * @since 1.0.0
	 */
	public static User getUserByAccount(String account){
     User user = null;
     
     Connection conn = null;
     PreparedStatement statement = null;    
     ResultSet rs = null;
     try{

    	//1、获取连接
    	 conn = ConnectUtils.getConnection();	 
    	//2、获取处理块\缓冲块
    	 statement = conn.prepareStatement(finduser_by_account_sql);
    	//3.设置参数
    	 statement.setString(1, account);
    	 //4、执行sql
    	 statement.execute();
	     //5、获取结果集
	     rs = statement.getResultSet();
	     //6、获取用户信息
	     if(rs.next()){
		       user = getUserByResultSet(rs);
		     }
	    	 
     }catch(Exception e){
    	 e.printStackTrace();
     }finally{
    	//7、关闭连接
    	 ConnectUtils.closeConnection(conn,statement,rs);
     }
     return user;		 		 
	}	
	
	/**
	 * 
	 * 功能描述: 报错用户信息</br> 
	 * 方法名 : saveUser</br> 
	 * 创建人： EE</br> 
	 * 创建时间： 2019年5月22日下午10:21:38</br> 
	 * @return boolean
	 * @param user
	 * @return  
	 * @since 1.0.0
	 */
	public static boolean saveUser(User user) {
		Connection conn = null;
		PreparedStatement statement = null;

		try {
			// 1、获取链接资源
			conn = ConnectUtils.getConnection();
			// 2、实例化缓冲块
			statement = conn.prepareStatement(SAVE_USER_SQL);
			// 3、设置参数
			statement.setString(1, user.getAccount());
			statement.setString(2, user.getPassword());
			statement.setString(3, user.getUsername());
			statement.setString(4, user.getHeaderpic());
			statement.setInt(5, user.getAge());
			//statement.setDate(6, new Date(user.getBirthday().getTime()));
			statement.setDate(6, null);
			statement.setString(7, user.getAddress());
			statement.setString(8, user.getEmail());
			statement.setInt(9, user.getMale());
			statement.setString(10, user.getTelephone());
			statement.setString(11, user.getDescription());
            //4、执行sql
			int count = statement.executeUpdate();
            //5、返回结果
			return count > 0 ? true : false;

		} catch (Exception e) {
			e.printStackTrace();
			return false;			
		} finally {
            //6、关闭连接
			ConnectUtils.closeConnection(conn, statement, null);
		}

	}

	


	
	/**
	 * 
	 * <p>功能描述: 根据查询结果集获取用户信息</p>
	 * <p>方法名 : getUserByResultSet</p>
	 * <p>创建人： EE</p>
	 * <p>创建时间： 2019年4月23日下午4:19:26</p>
	 * @return User
	 * @param rs
	 * @return
	 * @throws SQLException  
	 * @since 1.0.0
	 */
	public static User getUserByResultSet(ResultSet rs) throws SQLException{
		

			 User user = new User();
			 user.setId(rs.getInt("id"));
	    	 user.setAccount(rs.getString("account"));
	    	 user.setPassword(rs.getString("password"));
	    	 user.setUsername(rs.getString("username"));
	    	 user.setHeaderpic(rs.getString("headerpic"));
	    	 user.setAge(rs.getInt("age"));
	    	 user.setMale(rs.getInt("male"));
	    	 user.setCreatetime(rs.getTimestamp("createtime"));
	    	 user.setEmail(rs.getString("email"));
	    	 user.setAddress(rs.getString("address"));
	    	 user.setDescription(rs.getString("description"));
	    	 user.setTelephone(rs.getString("telephone"));
	    	 user.setBirthday(rs.getDate("birthday"));

		return user;
	}
	
	public static void main(String[] args) {
		//User user = getUserByAccountPassword("shanchen","123456");
//		User user = getUserByAccount("shanchen");
//		System.out.println(user.getPassword());
		
		
		 User user = new User();
		
    	 user.setAccount("test");
    	 user.setPassword("test");
    	 user.setUsername("test");
    	 user.setHeaderpic("test");
    	 user.setAge(1);
    	 user.setMale(1);
    	 user.setEmail("email");
    	 user.setAddress("address");
    	 user.setDescription("description");
    	 user.setTelephone("telephone");
    	 user.setBirthday(new Date(new java.util.Date().getTime()));
    	 
    	 boolean result =  saveUser(user);
    	 System.out.println(result);
		
	}
}
