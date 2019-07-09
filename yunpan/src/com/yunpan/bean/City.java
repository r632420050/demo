package com.yunpan.bean;

/**
 * 
 * Copyright (c) 2019 by EE </br>
 *
 * 类描述： 城市信息</br>
 * 类 名： City</br>
 * 创建人： EE</br>
 * 创建时间： 2019年5月20日下午4:57:50</br>
 * 修改备注：</br>
 * @Vsersion:1.0
 */
public class City implements java.io.Serializable{


	private static final long serialVersionUID = 1L;
	private Integer id; //城市Id
	private String city; //城市名称
	private Integer provinceId; //省份Id

	
	public City() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public City(Integer id) {
		super();
		this.id = id;
	}


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Integer getProvinceId() {
		return provinceId;
	}

	public void setProvinceId(Integer provinceId) {
		this.provinceId = provinceId;
	}
	
	
}
