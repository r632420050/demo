<%@page import="org.apache.struts2.json.JSONUtil"%>
<%@page import="com.yunpan.bean.Area"%>
<%@page import="com.yunpan.dao.*"%>
<%@page import="com.yunpan.util.StringUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<%
  //获取城市Id
  String id  = request.getParameter("cityId");
  //判断id是否为空
  if(StringUtils.isNotEmpty(id)){
    Integer cityId = new  Integer(id);
    //根据城市Id查询县区信息
    List<Area> areas = AreaDao.findAreasByCityId(cityId);
    if(areas != null){
      //通过json工具类讲List集合转换为json字符串
      out.print(JSONUtil.serialize(areas));
    }else{
     out.print("fail");
    }
    
  }else{
    out.print("fail");
  }
 %>
