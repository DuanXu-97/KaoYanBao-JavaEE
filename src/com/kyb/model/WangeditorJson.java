package com.kyb.model;

import java.io.Serializable;
	
    public class WangeditorJson<T> implements Serializable {
	    /** ������. */
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
		/** ���������. */
	    private String [] data;
	    
	    
	    
	}




