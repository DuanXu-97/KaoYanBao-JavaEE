package com.kyb.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.kyb.Dao.QuestionDao;
import com.kyb.Dao.UserDao;
import com.kyb.Dao.UserWeaknessDao;
import com.kyb.model.Question;
import com.kyb.util.Sim_CosUtil;

public class RecommendQuestionService {
	
	public List<Question> recommend_lib_Question(int u_id)
	{
		final int Admin_id =20;  //����Աid
		String category = "���������";
		List<Question> list = new ArrayList<Question>();
		List<Question> recommend_list = new ArrayList<Question>();
		Map<String, Integer> user_map = new HashMap<String, Integer>(); 
		Map<String, Integer> ques_map = new HashMap<String, Integer>();
		QuestionDao QD = new QuestionDao();
		UserWeaknessDao UWD = new UserWeaknessDao();
		Sim_CosUtil SCU = new Sim_CosUtil();
		list = QD.QueryQuestionByUserId(Admin_id);//���Ȼ�ȡ����Ա����Ŀ
		Question question = new Question();
		double simility = 0; //����������
		double threshold_u_q = 0.5 ; 
		//�Ȼ�ȡ�û��ı�����
		int u_c_id =UWD.QueryUserWeaknessCategoryById(u_id,category);		
		user_map = UWD.QueryUserWeaknessTagById(u_c_id);
		//�ٻ�ȡÿ����Ŀ�ı�������м���Ƚ�
		for(Question Q:list)
		{
			System.out.println(Q.getId());
			ques_map = QD.QueryQuestionTagById(Q.getId());
			simility = SCU.sim_cos(user_map, ques_map);
			if(simility>threshold_u_q)
			recommend_list.add(Q);
		}
		return recommend_list;	
	}
    
	public List<Question> recommend_share_Question(int u_id) {
		List<Question> recommend_list = new ArrayList<Question>();
		List<Integer> user_id_list = new ArrayList<Integer>();
		final int Admin_id = 20;
		String category = "���������";
		Map<String, Integer> user1_map = new HashMap<String, Integer>(); 
		Map<String, Integer> user2_map = new HashMap<String, Integer>();
		List<Question> u_question_list = new ArrayList<Question>();
		UserDao  UD = new UserDao();
		UserWeaknessDao UWD = new UserWeaknessDao();
		Sim_CosUtil SCU = new Sim_CosUtil();
		QuestionDao QD = new QuestionDao();
		int u_c_id =UWD.QueryUserWeaknessCategoryById(u_id,category);		
		user1_map = UWD.QueryUserWeaknessTagById(u_c_id);  //���Ȼ�ȡ���û��Լ��ı�����
		user_id_list = UD.QueryIdDbUsers(Admin_id, u_id);
		double simility = 0;
		double threshold_u_u = 0.3;
		for(Integer user_id:user_id_list) {
			u_c_id = UWD.QueryUserWeaknessCategoryById(user_id,category);
			user2_map = UWD.QueryUserWeaknessTagById(u_c_id);   //��ȡ�����û��ı�����
			simility = SCU.sim_cos(user1_map, user2_map);
			if(simility>threshold_u_u)
			{
				//���Ҹ��û���������Ŀ
				u_question_list = QD.QueryQuestionByUserId(user_id);
				recommend_list.addAll(u_question_list);
			}	
		}	
		return recommend_list;
		
	}
	
	public List<Question> recommend_relation_Question(int u_id) 
	{
		List<Question> recommend_list = new ArrayList<Question>();
		Map<List<String>, List<String>> map = new  HashMap<List<String>, List<String>>();
		AprioriService aService = new AprioriService();
		QuestionDao QD = new QuestionDao();
		String category = "���������";
		map = aService.getrule(category, u_id);
		UserWeaknessDao UWD = new UserWeaknessDao();
		for(Map.Entry<List<String>, List<String>> entry:map.entrySet())
		{
			if(UWD.is_have_thistag(entry.getKey(), u_id, category)) //�������û��иñ�����
					{
				      recommend_list.addAll(QD.is_equal_add(entry.getValue()));
					}		
		}
		return recommend_list;
	}


}

