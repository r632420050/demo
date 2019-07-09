package com.yunpan.bean;

/**
 * 
 * Copyright (c) 2019 by EE </br>
 *
 * 类描述： 省份信息</br> 
 * 类 名： Province</br> 
 * 创建人： EE</br> 
 * 创建时间： 2019年5月20日下午4:55:06</br>
 * 修改备注：</br>
 * 
 * @Vsersion:1.0
 */
public class Province implements java.io.Serializable{



	private static final long serialVersionUID = 1L;
	// 省份Id
	private Integer id;
	// 省份名称
	private String province;
	// 排序
	private String sort;

	
	public Province(){
		
		
	}
	
	
	public Province(Integer id) {
		super();
		this.id = id;
	}


	/**
	 * @return the id
	 */
	public Integer getId() {
		return id;
	}

	/**
	 * @param id
	 *            要设置的 id
	 */
	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @return the province
	 */
	public String getProvince() {
		return province;
	}

	/**
	 * @param province
	 *            要设置的 province
	 */
	public void setProvince(String province) {
		this.province = province;
	}

	/**
	 * @return the sort
	 */
	public String getSort() {
		return sort;
	}

	/**
	 * @param sort
	 *            要设置的 sort
	 */
	public void setSort(String sort) {
		this.sort = sort;
	}

}
