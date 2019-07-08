package com.yunpan.bean;

import java.util.Date;

/**
 * 
 * 用户bean User<BR>
 * 创建人:潭州学院-keke <BR>
 * 时间：2014年11月27日-下午10:57:32 <BR>
 * 
 * @version 1.0.0
 * 
 */
public class User implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	// 主键id
	private Integer id;
	// 用户账号
	private String account;
	// 用户昵称
	private String username;
	// 用户密码
	private String password;
	// 创建时间
	private Date createtime;
	// 更新时间
	private Date updatetime;
	// 删除状态 0未删除1删除
	private Integer isDelete;
	//头像
	private String headerpic; 
	//年龄
	private Integer age; 
	//生日
	private Date birthday; 
	//地址
	private String address; 
	//邮箱
	private String email; 
	//性别  1 男  2 女
	private Integer male; 
	//电话
	private String telephone; 
	//描述
	private String description;

	public User() {

	}

	public User(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public String getHeaderpic() {
		return headerpic;
	}

	public void setHeaderpic(String headerpic) {
		this.headerpic = headerpic;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getMale() {
		return male;
	}

	public void setMale(Integer male) {
		this.male = male;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	

}
