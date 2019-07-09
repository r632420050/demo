<%@page import="org.apache.struts2.json.JSONUtil"%>
<%@page import="com.yunpan.util.StringUtils"%>
<%@page import="com.yunpan.dao.*"%>
<%@ page import="com.yunpan.bean.*" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
	 String provinceId = request.getParameter("provinceId");
	 if(StringUtils.isNotEmpty(provinceId)){
	 	List<City> citys = CityDao.findCitysByProvinceId(new Integer(provinceId));
        //JSONUtil.serialize(citys) 将集合对象转换成json格式---List---JsonArr字符串[{},{},{}]
        if(citys != null){
         out.print(JSONUtil.serialize(citys));
         }else{
          out.print("fail");
         }
	 }else{
	    out.print("fail");
	 }

%>
