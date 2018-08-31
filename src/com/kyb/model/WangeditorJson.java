package com.kyb.model;

import java.io.Serializable;
	
    public class WangeditorJson<T> implements Serializable {
	    /** 错误码. */
	    private Integer errno;
	    public Integer getErrno() {
			return errno;
		}
		public void setErrno(Integer errno) {
			this.errno = errno;
		}
		public String[] getData() {
			return data;
		}
		public void setData(String[] data) {
			this.data = data;
		}
		/** 具体的内容. */
	    private String [] data;
	    
	    
	    
	}




