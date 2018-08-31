package com.kyb.util;
import java.util.List;
import com.kyb.model.WangeditorJson;
	
	
public class WangeditorResultUtil {
	
	    public static  WangeditorJson success(String []object) {
	    	WangeditorJson result = new WangeditorJson();
	        result.setErrno(0);
	        result.setData(object);
	        return result;
	    }
	    public static WangeditorJson success() {
	        return success(null);
	    }
	
}
