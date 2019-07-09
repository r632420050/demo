<%@page import="com.yunpan.util.StringUtils"%>
<%@page import="com.yunpan.dao.UserDao"%>
<%@page import="com.yunpan.bean.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	//获取传参
	String account = request.getParameter("account");
	String password = request.getParameter("password");
	String nickname = request.getParameter("nickname");
	String telephone = request.getParameter("telephone");
	String email = request.getParameter("email");
	String m = request.getParameter("male");
	String privince = request.getParameter("province");
	String city = request.getParameter("city");
	String area = request.getParameter("area");
	String description = request.getParameter("remarks");
	String code  = request.getParameter("code");
	String address = privince + city + area;
	
	//用于获取多个参数
	String[] hobby = request.getParameterValues("hobby");
	if( hobby != null){
	    for(String s : hobby){
		   System.out.println("====>"+s);
		}
	}
	Integer male = new Integer(m);

    String validatecode = (String)request.getSession().getAttribute("randcode");
   //session中验证码不为空 同时录入的验证码和后台的一致才能成功
   if(validatecode != null &&  validatecode.equals(code)){
	   //密码加密后保存	
	   String encodePassword =  StringUtils.saltPassword(StringUtils.getSlatString(), password);
	    //用户信息保存
		User user = new User();
		user.setAccount(account);
		user.setPassword(encodePassword);
		user.setUsername(nickname);
		user.setAge(1);
		user.setMale(male);
		user.setEmail(email);
		user.setAddress(address);
		user.setDescription(description);
		user.setTelephone(telephone);
	
		boolean result = UserDao.saveUser(user);
		if (result) {
			out.print("success");
		} else {
			out.print("fail");
		}
   }else{
     out.print("fail");
   }	
%>
