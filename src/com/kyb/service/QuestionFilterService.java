package com.kyb.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kyb.Dao.QuestionDao;
import com.kyb.model.Question;

public class QuestionFilterService {
	
	public Map<String, Object> QuestionSearchByCategory(int id, String category,int start,int pagesize) {
		Map<String, Object> map = new HashMap<String, Object>();
		QuestionDao QD = new QuestionDao();
	    List<Question> list  = new ArrayList<Question>();
	    list = QD.QueryQuestionByCategory(id, category,start,pagesize);
		int recordCount = QD.getCount(id,category);
		map.put("list", list);
		map.put("count", recordCount);
	    return map;
	}

}
