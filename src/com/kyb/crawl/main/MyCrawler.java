package com.kyb.crawl.main;

import com.kyb.crawl.link.LinkFilter;
import com.kyb.crawl.link.Links;
import com.kyb.crawl.page.Page;
import com.kyb.crawl.page.PageParserTool;
import com.kyb.crawl.page.RequestAndResponseTool;
import com.kyb.crawl.util.FileTool;

import org.eclipse.jdt.internal.compiler.ast.FalseLiteral;
import org.jsoup.select.Elements;
import org.jsoup.nodes.Element;

import java.util.*;
import java.text.*;

import com.kyb.Dao.NewsDao;
import com.kyb.model.News;

public class MyCrawler {
	 /**
     * 使用种子初始化 URL 队列
     *
     * @param seeds 种子 URL
     * @return
     */
    private static void initCrawlerWithSeeds(String[] seeds) {
        for (int i = 0; i < seeds.length; i++){
            Links.addUnvisitedUrlQueue(seeds[i]);
        }
    }
 
 
    /**
     * 抓取过程
     *
     * @param seeds
     * @return
     */
    public static List<News> crawling(String[] seeds) {
    	
    	NewsDao nDao = new NewsDao();
    	List<News> NewsList = new ArrayList<News>();
 
        //初始化 URL 队列
        initCrawlerWithSeeds(seeds);
        
        //先从待访问的序列中取出第一个；
        String listPageUrl = (String) Links.removeHeadOfUnVisitedUrlQueue();
        if (listPageUrl == null){
            return null;
        }

        //根据URL得到page;
        Page listPage = RequestAndResponseTool.sendRequstAndGetResponse(listPageUrl);

        //对page进行处理： 访问DOM的某个标签
        ArrayList<String> detailPageLinks = PageParserTool.getAttrs(listPage,"div[class=blk02] li a","abs:href");
        for(String detailPageLink:detailPageLinks) {
        	System.out.println(detailPageLink);
        	Links.addUnvisitedUrlQueue(detailPageLink);
        }

        //将已经访问过的链接放入已访问的链接中；
        Links.addVisitedUrlSet(listPageUrl);
 
        //定义过滤器，提取以 新浪考研频道开头的链接
        LinkFilter filter = new LinkFilter() {
            public boolean accept(String url) {
                if (url.startsWith("http://edu.sina.com.cn/kaoyan/"))
                    return true;
                else
                    return false;
            }
        };
 
        //循环条件：待抓取的链接不空且抓取的网页不多于 1000
        while (!Links.unVisitedUrlQueueIsEmpty()  && Links.getVisitedUrlNum() <= 1000) {
 
            //先从待访问的序列中取出第一个；
            String visitUrl = (String) Links.removeHeadOfUnVisitedUrlQueue();
            if (visitUrl == null || nDao.isExist(visitUrl)){
                continue;
            }
            
            if(!filter.accept(visitUrl)) {
            	continue;
            }
 
            //根据URL得到page;
            Page page = RequestAndResponseTool.sendRequstAndGetResponse(visitUrl);
 
            //获取详情页的标题
            Element titleEle = PageParserTool.select(page, "h1[class=main-title]", 0);
            if(titleEle == null) {
            	continue;
            }
            String title = titleEle.text();
            
            //获取详情页的内容
            Elements contentEles = PageParserTool.select(page, "div[id=artibody] p");
            Iterator iterator  = contentEles.iterator();
            String content = "";
            while(iterator.hasNext()) {
                Element element = (Element) iterator.next();
                String partOfContent = element.text();
                content = content +"\n"+ partOfContent;
            }
            
            //获取详情页的日期
            Element dateEle = PageParserTool.select(page, "div[class=date-source] span[class=date]", 0);
            if(dateEle == null) {
            	continue;
            }
            String unparsedDate = dateEle.text();
            
            //将字符串解析成Date类
            SimpleDateFormat ft = new SimpleDateFormat ("yyyy年MM月dd日 HH:mm"); 
            String input = unparsedDate ; 
            Date date = new Date();
            try {
            	date = ft.parse(input); 
            } catch (ParseException e) { 
                System.out.println("Unparseable using " + ft); 
            }
            
            System.out.println(title);
            System.out.println(content);
            System.out.println(date);
            
            //将已经访问过的链接放入已访问的链接中；
            Links.addVisitedUrlSet(visitUrl);
            
            News news = new News();
            news.setTitle(title);
            news.setContent(content);
            news.setDate(date);
            news.setUrl(visitUrl);
            
            NewsList.add(news);
 
        }
		return NewsList;
    }
 
 
    //main 方法入口
   /* public static void main(String[] args) {
        MyCrawler crawler = new MyCrawler();
        crawler.crawling(new String[]{"http://edu.sina.com.cn/kaoyan/"});
    }*/
}
