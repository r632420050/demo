package com.yunpan.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.HashMap;
import java.util.Random;

/**
 * 
 * Copyright (c) 2019 by EE </br>
 *
 * 类描述：随机验证码</br>
 * 类 名： RandomValidateCode</br>
 * 创建人： EE</br>
 * 创建时间： 2019年5月23日下午7:40:53</br>
 * 修改备注：</br>
 * @Vsersion:1.0
 */
public class RandomValidateCode {
    //随机数
	private  Random random = new Random();
	//图片宽度
	private int width = 80;
	//图片高度
	private  int height = 40;
	//字体大小
	private  int fontsize = 18;
	//随机字符数量
	private  int stringNumber = 5;
	//干扰线数量
	private  int lineNumber = 50;
	//随机产生的字符串
	private static final String RANDSTRING = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	
	
    /**
     * 
     * 功能描述: 获取字体</br> 
     * 方法名 : getFont</br> 
     * 创建人： EE</br> 
     * 创建时间： 2019年5月23日下午8:53:16</br> 
     * @return Font
     * @return  
     * @since 1.0.0
     */
    private Font getFont(){
        return new Font("Fixedsys",Font.CENTER_BASELINE,fontsize);
    }
    
	/**
	 * 
	 * 功能描述: 获取随机颜色</br> 
	 * 方法名 : getRandomColor</br> 
	 * 创建人： EE</br> 
	 * 创建时间： 2019年5月23日下午8:15:29</br> 
	 * @return Color
	 * @return  
	 * @since 1.0.0
	 */
    private  Color getRandomColor(){
		
		int r = random.nextInt(255);
		int g = random.nextInt(255);
		int b = random.nextInt(255);
		return new Color(r,g,b);
		
	}
    
    /**
     * 
     * 功能描述: 获取用户验证码</br> 
     * 方法名 : getValidateCode</br> 
     * 创建人： EE</br> 
     * 创建时间： 2019年5月23日下午9:42:44</br> 
     * @return HashMap<String,Object>
     * @return  
     * @since 1.0.0
     */
    public static HashMap<String,Object> getValidateCode(){
    	 //验证码处理类
    	 RandomValidateCode randomcode = new RandomValidateCode();
    	 ////BufferedImage类是具有缓冲区的Image类,Image类是用于描述图像信息的类
    	 BufferedImage image = new BufferedImage(randomcode.width,randomcode.height,BufferedImage.TYPE_INT_BGR );
    	 //获取画笔
    	 Graphics g = image.getGraphics();
    	 //设置颜色
	     g.setColor(randomcode.getRandColor(210, 233));
	     //画背景颜色
	     g.fillRect(0, 0, randomcode.width, randomcode.height);
	     //绘制干扰线
	     randomcode.drawLine(g);
	     //绘制随机字符
	     String randcode = randomcode.drawString(g);
	     
	     g.dispose();
	     
	     HashMap<String,Object> map = new HashMap<String, Object>();
	     map.put("image", image);
	     map.put("randcode", randcode);
	     return map;
    }
    
    /**
     * 
     * 功能描述: 根据色彩度设置颜色</br> 
     * 方法名 : getRandColor</br> 
     * 创建人： EE</br> 
     * 创建时间： 2019年5月23日下午9:03:53</br> 
     * @return Color
     * @param fc
     * @param bc
     * @return  
     * @since 1.0.0
     */
    public Color getRandColor(int fc,int bc){
        if(fc > 255)
            fc = 255;
        if(bc > 255)
            bc = 255;
        int r = fc + random.nextInt(bc-fc-16);
        int g = fc + random.nextInt(bc-fc-14);
        int b = fc + random.nextInt(bc-fc-18);
        return new Color(r,g,b);
    }
	
	/**
	 * 
	 * 功能描述: 画干扰线</br> 
	 * 方法名 : drawLine</br> 
	 * 创建人： EE</br> 
	 * 创建时间： 2019年5月23日下午8:24:01</br> 
	 * @return void
	 * @param g  
	 * @since 1.0.0
	 */
    public  void drawLine(Graphics g){
    	
       for (int i = 0; i < lineNumber; i++) {
    	 g.setColor(getRandomColor());	  
    	 int x = random.nextInt(width);
  		 int y = random.nextInt(height);
  		 int x1 = x + random.nextInt(13);
  		 int y1 = y +random.nextInt(15);
  		 if(x1 > width) x1= width;
  	     if(y1 > height) y1= height;
  		 g.drawLine(x, y, x1,y1);
	   }	
		
	}
	
	/**
	 * 
	 * 功能描述: 画字符串</br> 
	 * 方法名 : drawString</br> 
	 * 创建人： EE</br> 
	 * 创建时间： 2019年5月23日下午8:54:51</br> 
	 * @return String
	 * @param g
	 * @return  
	 * @since 1.0.0
	 */
    public  String drawString(Graphics g){
		
		String randomString = "";
		
		int type = random.nextInt(2);
		if(type == 1) {
			for(int i = 0;i < stringNumber;i++){
			   g.setFont(getFont());
			   //g.setColor(getRandColor(110, 133));	
			   g.setColor(new Color(random.nextInt(101),random.nextInt(111),random.nextInt(121)));
			   String rand = getRandomString(random.nextInt(RANDSTRING.length()));
			   g.translate(random.nextInt(3), random.nextInt(3));
			   g.drawString(rand, 5+i*12, 22);
			   randomString = randomString + rand;
			}
		}else{
			int snum = random.nextInt(100);
			int enums = random.nextInt(100);
			
			//x坐标的位移，偏移量
	        int x= new Random().nextInt(3);
	        //设置字体
	        g.setFont(getFont());
			g.setColor(new Color(random.nextInt(101),random.nextInt(111),random.nextInt(121)));
			HashMap<String, String> map = getRandomString(snum,enums);
			String rand =  map.get("randstring");
			randomString = map.get("result");
			g.translate(random.nextInt(3), random.nextInt(3));
			g.drawString(rand,4*x, 22);
				
		 }
		
		return randomString;
	}
    
   
	
	/**
	 * 
	 * 功能描述: 获取随机字符</br> 
	 * 方法名 : getRandomString</br> 
	 * 创建人： EE</br> 
	 * 创建时间： 2019年5月23日下午8:43:54</br> 
	 * @return String
	 * @param num
	 * @return  
	 * @since 1.0.0
	 */
	public  String getRandomString(int num){
		
		return String.valueOf(RANDSTRING.charAt(num));
	}
	
	
	public HashMap<String, String> getRandomString(int snum,int enums){
		String randstring = "";
		Integer result = null;
		int num = random.nextInt(5);
		if (num == 1) {
			randstring = snum + " + " + enums;
			result = snum + enums;
		} else if (num == 2) {
			randstring = snum + " - " + enums;
			result = snum - enums;
		} else if (num == 3) {
			randstring = snum + " × " + enums;
			result = snum * enums;
		} else if (num == 4 &&  enums != 0) {
			randstring = snum + " % " + enums;
			result = snum % enums;
		}else{
			randstring = snum + " + " + enums;
			result = snum + enums;
		}
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("randstring", randstring);
		map.put("result",result.toString());
		
		return map;
	}
	
	

	
}
