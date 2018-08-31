package com.kyb.crawl.main;

import java.util.Timer;
import java.util.TimerTask;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.kyb.model.News;
import com.kyb.Dao.NewsDao;


public class MyTimerTask implements ServletContextListener{
	private Timer timer;
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		if(timer!=null) timer.cancel();
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		timer = new Timer();
		timer.schedule(new TimerTask() {
			 
			@Override
			public void run() {
				work();
			}
		}, 1000, 24*60*60*1000);// һ���ִ�У�ÿ��ִ��һ�Ρ�
		System.out.println("pachong");
	}
	
	private void work() {
		NewsDao nDao = new NewsDao();
		//��ʱ����
		List<News> NewsList = MyCrawler.crawling(new String[]{"http://edu.sina.com.cn/kaoyan/"});
		//����Dao
		for(News news:NewsList) {
			nDao.AddNews(news.getTitle(),news.getContent(),news.getDate(),news.getUrl());
		}
	}

}
