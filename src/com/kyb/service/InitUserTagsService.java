package com.kyb.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kyb.Dao.UserWeaknessDao;

public class InitUserTagsService {

	//��ʼ���û���ǩ
	public void InitUserTags(int u_id,Map<Integer, List<String>> map)
	{   
		int c_id;
		List<String> list = new ArrayList<String>();
		UserWeaknessDao UWD  = new UserWeaknessDao();
		for(Map.Entry<Integer,List<String>> entry:map.entrySet()) {
			c_id = entry.getKey();
			list = entry.getValue();
			UWD.InitUserTags(c_id, u_id, list);   //���ú��������û�������ͱ�����ǩ
		}
		
	}
}
