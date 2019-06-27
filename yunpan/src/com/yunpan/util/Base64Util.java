package com.yunpan.util;

import java.io.UnsupportedEncodingException;
import org.apache.commons.codec.binary.Base64;

public class Base64Util {
	/**
	 * base64编码后的字符串
	 * 
	 * @param xml
	 * @return
	 * @throws UnsupportedEncodingException
	 *             String
	 */
	public static String encodeBase64(String xml) throws UnsupportedEncodingException {
		String encodeString = Base64.encodeBase64String(xml.getBytes("UTF-8"));
		// return new String(enbytes, "UTF-8");
		return encodeString;
	}
	
	
	/**
	 * base64编码后的URL safe安全的字符串
	 * 
	 * @param xml
	 * @return
	 * @throws UnsupportedEncodingException
	 *             String
	 */
	public static String encodeBase64URLSafe(String xml) throws UnsupportedEncodingException {
		String encodeUrlSafeString = Base64.encodeBase64URLSafeString(xml.getBytes("UTF-8"));
		// return new String(enbytes, "UTF-8");
		return encodeUrlSafeString;
	}

	/**
	 * base64解码后的字符串
	 * 
	 * @param data
	 * @return
	 * @throws UnsupportedEncodingException
	 *             String
	 */
	public static String decodeBase64(String data) throws UnsupportedEncodingException {
		byte[] debytes = Base64.decodeBase64(data);
		return new String(debytes, "UTF-8");
		// return new String(debytes, "UTF-8");
	}
	
	
//	public static void main(String[] args) throws UnsupportedEncodingException {
//		String url = "http://http://10.183.125.25:8092";
//		System.out.println("【源码】:"+url);
//		url = encodeBase64(url);
//		System.out.println("【编码】:"+url);
//		url = decodeBase64(url);
//		System.out.println("【解码】:"+url);
//	}
}
