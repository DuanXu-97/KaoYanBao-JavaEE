package com.kyb.model;

public class User {
	
	private int id;
	
	private String username;
	
	private String password;
	private String email;
	private String avatarPath;
	private String nickname;
	private String birthday;
	private String motto;
	private String gender;
	private String targetCollege;
	private String presentCollege;
	private boolean is_active;
	
	public boolean isIs_active() {
		return is_active;
	}
	public void setIs_active(boolean is_active) {
		this.is_active = is_active;
	}
	public String getAvatarPath() {
		return avatarPath;
	}
	public void setAvatarPath(String avatarPath) {
		this.avatarPath = avatarPath;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getMotto() {
		return motto;
	}
	public void setMotto(String motto) {
		this.motto = motto;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getTargetCollege() {
		return targetCollege;
	}
	public void setTargetCollege(String targetCollege) {
		this.targetCollege = targetCollege;
	}
	public String getPresentCollege() {
		return presentCollege;
	}
	public void setPresentCollege(String presentCollege) {
		this.presentCollege = presentCollege;
	}

	
	


	public int getId( )
	{
		return id;
	}
	public void  setId(int id )
	{
		this.id = id;
	}
	
	public String getUsername( )
	{
		return username;
	}
	public void setUsername(String name )
	{
		this.username = name;
	}
	public String getPassword( )
	{
		return password;
	}
	public void setPassword(String password)
	{
		this.password=password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email )
	{
		this.email = email;
	}


}
