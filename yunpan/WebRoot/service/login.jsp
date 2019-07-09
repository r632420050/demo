<%@page import="com.yunpan.bean.User"%>
<%@page import="com.yunpan.dao.UserDao"%>
<%@page import="com.yunpan.util.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<%
	//用户名
	String account = request.getParameter("account");
	//密码
	String password = request.getParameter("password");
	//判断是否为空
	if(StringUtils.isNotEmpty(account)||StringUtils.isNotEmpty(password)){
	
		User user =	UserDao.getUserByAccount(account);
		if(user != null){
		  //进行加密	
		  String encodePassword =	StringUtils.saltPassword(StringUtils.getSlatString(), password);
		  //与数据库中密码进行对比
		  if(user.getPassword().equals(encodePassword)){
		  
		    //设置session
		  	session.setAttribute("user",user); 
		  	out.print("success");
		  	
		  }else{
		  	out.print("fail");
		  }
		}else{
			out.print("fail");
		}

				
	}else{
		out.print("success");
	}
 %>
