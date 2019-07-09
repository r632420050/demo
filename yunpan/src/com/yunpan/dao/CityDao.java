package com.yunpan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.yunpan.bean.City;
import com.yunpan.util.ConnectUtils;

/**
 * 
 * Copyright (c) 2019 by EE </br>
 *
 * 类描述：城市信息查询</br>
 * 类 名： CityDao</br>
 * 创建人： EE</br>
 * 创建时间： 2019年5月20日下午5:06:50</br>
 * 修改备注：</br>
 * @Vsersion:1.0
 */
public class CityDao {

	private static final String FINDCITYS_BY_PROVINCEID = "SELECT * FROM TM_CITY WHERE PROVINCE_ID=? ";
	
	/**
	 * 
	 * 功能描述: 根据省份Id查询城市信息</br> 
	 * 方法名 : findCitysByProvinceId</br> 
	 * 创建人： EE</br> 
	 * 创建时间： 2019年5月20日下午5:30:12</br> 
	 * @return List<City>
	 * @param provinceId 省份Id
	 * @return  
	 * @since 1.0.0
	 */
	public static List<City> findCitysByProvinceId(Integer provinceId) {
		Connection conn = null;
		PreparedStatement statment = null;
		ResultSet rs = null;
		List<City> citys = null;

		try {
			//1、获取连接
			conn = ConnectUtils.getConnection();
			//2、实例化缓冲区
			statment = conn.prepareStatement(FINDCITYS_BY_PROVINCEID);
			//3、设置参数
			statment.setInt(1, provinceId);
			//4、执行sql语句
			rs = statment.executeQuery();
			citys = new ArrayList<City>();
			//5、获取结果信息
			while (rs.next()) {
				City city = new City();
				city.setId(rs.getInt("id"));
				city.setCity(rs.getString("city"));
				city.setProvinceId(rs.getInt("province_id"));
				citys.add(city);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectUtils.closeConnection(conn, statment, rs);
		}

		return citys;

	}
	
	public static void main(String[] args) {
		List<City> citys = findCitysByProvinceId(130000);
		for (City city : citys) {
			System.out.println(city.getCity());
		}
	}
}
