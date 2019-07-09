<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<%
	//注销session
	session.invalidate();
	//重定向到登录页面
	response.sendRedirect("../login.html");
 %>
