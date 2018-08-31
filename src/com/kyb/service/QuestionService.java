package com.kyb.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kyb.Dao.QuestionDao;
import com.kyb.model.Question;

public class QuestionService {

	private QuestionDao QD = new QuestionDao();
	
	public Map<String, Object> QuestionQueryByUserId(int id,int start, int pagesize) {
		Map<String, Object> map = new HashMap<String, Object>();
		//查询当前页的记录
		List<Question> list = QD.QueryQuestionByUserId(id,start, pagesize);
		//查询总记录
		int recordCount = QD.getCount(id);
		map.put("list", list);
		map.put("count", recordCount);
		return map;
	}
	
}
