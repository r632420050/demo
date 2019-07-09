<%@page import="com.yunpan.util.StringUtils"%>
<%@page import="com.yunpan.bean.Resource"%>
<%@page import="com.yunpan.dao.ResourceDao"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%

	String ids = request.getParameter("ids");
	if(StringUtils.isNotEmpty(ids)){
		boolean flag = ResourceDao.deleteResources(ids);
		if(flag){
			out.print("success");//request/response.getWriter()
		}else{
			out.print("fail");
		}
	}else{
		out.print("fail");
	}
%>