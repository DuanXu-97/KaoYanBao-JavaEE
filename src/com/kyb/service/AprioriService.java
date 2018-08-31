package com.kyb.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.kyb.Dao.UserWeaknessDao;
import com.kyb.util.AprioriUtil;

public class AprioriService {
	
	public  Map<List<String>, List<String>> getrule(String category,int u_id) {
	UserWeaknessDao UWD =new UserWeaknessDao();
	List<Set<String>> Event1=new ArrayList<Set<String>>();
	Map<List<String>, List<String>>  map = new HashMap<List<String>,List<String>>();
	List<String>  list1 = new ArrayList<String>();
	List<String>  list2 = new ArrayList<String>();
	Event1 = UWD.getRecord(category, u_id);    //������Event1
	AprioriUtil AU =new AprioriUtil(Event1,100,0.9);  //��ʼ��Apriori����С���ŶȺ���С֧�ֶ�
	map = AU.runApriori();        //���ɹ�������
	for(Map.Entry<List<String>,List<String>> entry:map.entrySet())
	{
		list1 = entry.getKey();
		list2 = entry.getValue();
		System.out.println("�����������£�");
		for(String item:list1)
		{
			System.out.print(item);
			System.out.print(',');
		}
		System.out.print("->");
		for(String item:list2)
		{
			System.out.print(item);
			System.out.print(',');
		}
	}
	return map;
}

}