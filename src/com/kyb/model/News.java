package com.kyb.model;

import java.util.Date;
import java.text.*;

public class News {
	private int id;
	private String title;
	private String Content;
	private Date date;
	private String url;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public Date getDate() {
		return date;
	}
	public String getDateString() {
		SimpleDateFormat ft = new SimpleDateFormat ("yyyyÄêMMÔÂddÈÕ HH:mm");
		return ft.format(date);
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
	

}
