package com.yunpan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.yunpan.bean.Area;
import com.yunpan.util.ConnectUtils;

/**
 * 
 * Copyright (c) 2019 by EE </br>
 *
 * 类描述：县市信息查询</br>
 * 类 名： AreaDao</br>
 * 创建人： EE</br>
 * 创建时间： 2019年5月20日下午5:07:04</br>
 * 修改备注：</br>
 * @Vsersion:1.0
 */
public class AreaDao {

	private static final String FINDAREAS_BY_CITYID = "SELECT * FROM TM_AREA WHERE CITY_ID=? ";
	
	
	/**
	 * 
	 * 功能描述: 根据城市Id获取县市地址</br> 
	 * 方法名 : findAreasByCityId</br> 
	 * 创建人： EE</br> 
	 * 创建时间： 2019年5月20日下午5:42:51</br> 
	 * @return List<Area>
	 * @param cityId
	 * @return  
	 * @since 1.0.0
	 */
	public static List<Area> findAreasByCityId(Integer cityId) {
		Connection conn = null;
		PreparedStatement statment = null;
		ResultSet rs = null;
		List<Area> areas = null;

		try {
			//1、获取连接
			conn = ConnectUtils.getConnection();
			//2、实例化缓冲区
			statment = conn.prepareStatement(FINDAREAS_BY_CITYID);
			//3、设置参数
			statment.setInt(1, cityId);
			//4、执行sql语句
			rs = statment.executeQuery();
			areas = new ArrayList<Area>();
			//5、获取结果信息
			while (rs.next()) {
				Area area = new Area();
				area.setId(rs.getInt("id"));
				area.setArea(rs.getString("area"));
				area.setCityId(rs.getInt("city_id"));
				areas.add(area);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectUtils.closeConnection(conn, statment, rs);
		}

		return areas;

	}
	
	public static void main(String[] args) {
		List<Area> areas = findAreasByCityId(110100);
		for (Area area : areas) {
			System.out.println(area.getArea());
		}
	}
}
