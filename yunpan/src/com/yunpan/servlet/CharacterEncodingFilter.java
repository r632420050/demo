package com.yunpan.servlet;

import java.io.IOException;


import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import com.yunpan.util.StringUtils;

/**
 * 统一处理乱码拦截器
 * @author Administrator
 * @version 1.0
 */
public class CharacterEncodingFilter implements Filter{

	private FilterConfig config;
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		//1、获取配置的编码 
		String encoding = config.getInitParameter("Encoding");
		
		//2、判断是否为空
		 if(StringUtils.isNotEmpty(encoding)){
	        request.setCharacterEncoding(encoding);
	        response.setCharacterEncoding(encoding);
	        
		 }
		 //3、进入下一个过滤器
		 chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		this.config = config;
		
	}

}
