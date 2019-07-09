package com.yunpan.bean;

/**
 * 
 * Copyright (c) 2019 by EE </br>
 *
 * 类描述：县、区信息</br>
 * 类 名： Area</br>
 * 创建人： EE</br>
 * 创建时间： 2019年5月20日下午5:00:27</br>
 * 修改备注：</br>
 * @Vsersion:1.0
 */
public class Area implements java.io.Serializable{

	private static long serialVersionUID = 1L;

	private Integer id; // 地区ID
	private String area; // 县区名称
	private Integer cityId; // 城市Id

	
	
	public Area(Integer id) {
		super();
		this.id = id;
	}

	public Area() {
		super();
		// TODO Auto-generated constructor stub
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public static void setSerialversionuid(long serialversionuid) {
		serialVersionUID = serialversionuid;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public Integer getCityId() {
		return cityId;
	}

	public void setCityId(Integer cityId) {
		this.cityId = cityId;
	}

}
