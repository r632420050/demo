<%@page import="org.apache.struts2.json.JSONUtil"%>
<%@page import="com.yunpan.bean.Resource"%>
<%@page import="com.yunpan.util.StringUtils"%>
<%@page import="com.yunpan.dao.ResourceDao"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//获取分类	
	String t = request.getParameter("type");

	Integer type = null;
	if(StringUtils.isNotEmpty(t)){
	 type = new Integer(t);	
	}
	  List<Resource> resources = ResourceDao.findResources(type);
	  out.print(JSONUtil.serialize(resources));
	
	

%>