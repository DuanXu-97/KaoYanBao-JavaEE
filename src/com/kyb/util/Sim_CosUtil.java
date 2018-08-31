package com.kyb.util;

import java.util.HashMap;
import java.util.Map;

public class Sim_CosUtil {
	
	public double sim_cos(Map<String,Integer> weakness_user,Map<String,Integer> weakness_ques)
	{
        Map<String, Integer> sim = new HashMap<String,Integer>(); 
		for(Map.Entry<String,Integer> entry:weakness_user.entrySet() ) {
			if(weakness_ques.containsKey(entry.getKey()))
			{
				
				sim.put(entry.getKey(), 1);
			}
		}
		if(sim.size()==0)
			return 0;
		double pSum =0;
		for(Map.Entry<String,Integer> entry:sim.entrySet())
		{
			String item = entry.getKey();
			pSum += weakness_ques.get(item)*weakness_user.get(item);
		}
	    double sum1Sq =0;
		for(Map.Entry<String,Integer> entry:weakness_user.entrySet())
		{
			String item = entry.getKey();
			sum1Sq +=  Math.pow(weakness_user.get(item), 2);
		}
		double sum2Sq =0;
		for(Map.Entry<String,Integer> entry:weakness_ques.entrySet())
		{   
			System.out.println(entry.getKey());
			String item = entry.getKey();
			sum2Sq +=  Math.pow(weakness_ques.get(item), 2);
		}
//		System.out.println("psum="+pSum);	
//		System.out.println("sum1sq="+sum1Sq);
//		System.out.println("sum2sq="+sum2Sq);
		double mul = Math.sqrt(sum1Sq*sum2Sq);
//		System.out.println("mul="+mul);
		if(mul ==0)
			return 0;
		double simility = pSum/mul;
//		System.out.println("simility="+simility);
		return simility;
	}

}
