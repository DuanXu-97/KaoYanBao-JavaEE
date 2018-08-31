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
		}, 1000, 24*60*60*1000);// 一秒后执行，每天执行一次。
		System.out.println("pachong");
	}
	
	private void work() {
		NewsDao nDao = new NewsDao();
		//定时任务
		List<News> NewsList = MyCrawler.crawling(new String[]{"http://edu.sina.com.cn/kaoyan/"});
		//调用Dao
		for(News news:NewsList) {
			nDao.AddNews(news.getTitle(),news.getContent(),news.getDate(),news.getUrl());
		}
	}

}
