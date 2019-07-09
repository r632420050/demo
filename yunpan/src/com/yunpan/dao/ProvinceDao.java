package com.yunpan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.yunpan.bean.Province;
import com.yunpan.util.ConnectUtils;

/**
 * 
 * Copyright (c) 2019 by EE </br>
 *
 * 类描述： 省份信息查询</br>
 * 类 名： ProvinceDao</br>
 * 创建人： EE</br>
 * 创建时间： 2019年5月20日下午5:06:33</br>
 * 修改备注：</br>
 * @Vsersion:1.0
 */
public class ProvinceDao {
	
	private static final String FIND_PROVINCES = "SELECT * FROM TM_PROVINCE ORDER BY SORT";

	public static List<Province> findProvinces()  {
		Connection conn = null;
		PreparedStatement satement = null;
		ResultSet rs = null;
		List<Province> provinces = null;

		try {
			// 1、获取用户连接
			conn = ConnectUtils.getConnection();
			// 2、初始化数据缓冲块
			satement = conn.prepareStatement(FIND_PROVINCES);
			// 3、执行查询操作
			rs = satement.executeQuery();

			provinces = new ArrayList<Province>();
			// 4、获取参数值
			while (rs.next()) {

				Province province = new Province();
				province.setId(rs.getInt("id"));
				province.setProvince(rs.getString("province"));
				province.setSort(rs.getString("sort"));
				provinces.add(province);
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			ConnectUtils.closeConnection(conn, satement, rs);
		}

		return provinces;

	}
	
	public static void main(String[] args) {
	   List<Province> provinces =	findProvinces();
	   for (Province province : provinces) {
		System.out.println(province.getProvince());
	   }
	}
	
}
