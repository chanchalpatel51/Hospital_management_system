package com.entity;

public class User {
	private int id;
	private String fullname;
	private String email;
	private String password;
	private String photo;
	
	
	public User() {
		super();
		
	}
	
	public User(String fullname, String email, String password, String photo) {
		super();
		this.fullname = fullname;
		this.email = email;
		this.password = password;
		this.photo = photo;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	
}
