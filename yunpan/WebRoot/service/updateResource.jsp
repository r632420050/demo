<%@page import="com.yunpan.util.StringUtils"%>
<%@page import="com.yunpan.bean.Resource"%>
<%@page import="com.yunpan.dao.ResourceDao"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%

	String id = request.getParameter("id");
    String name = request.getParameter("name");
	if(StringUtils.isNotEmpty(id) || StringUtils.isNotEmpty(name)){
		boolean flag = ResourceDao.updateResource(new Integer(id),name);
		if(flag){
			out.print("success");
		}else{
			out.print("fail");
		}
	}else{
		out.print("fail");
	}
%>