<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="com.yunpan.util.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
       //清除页面缓存 
	   response.setContentType("image/jpeg");//设置相应类型,告诉浏览器输出的内容为图片
       response.setHeader("Pragma", "No-cache");//设置响应头信息，告诉浏览器不要缓存此内容
       response.setHeader("Cache-Control", "no-cache"); //设置不缓存
       response.setDateHeader("Expire", 0);
       
       //获取验证码
       HashMap<String,Object> map =  RandomValidateCode.getValidateCode();
       //获取验证码字符串
       String  randcode = (String)map.get("randcode");
       //获取验证码图片
       BufferedImage image = (BufferedImage)map.get("image"); 
       //放入session 中
       request.getSession().setAttribute("randcode", randcode);
       try {
       	ServletOutputStream output = response.getOutputStream();
       	//图片水印，文字水印，图片裁剪，验证码
           ImageIO.write(image, "JPEG", output);//将内存中的图片通过流动形式输出到客户端
           output.flush();  
           output.close();  
           output=null;  
           response.flushBuffer();  
           out.clear();  
           out = pageContext.pushBody();  
       } catch (Exception e) {
       
       }	
       
 %>
