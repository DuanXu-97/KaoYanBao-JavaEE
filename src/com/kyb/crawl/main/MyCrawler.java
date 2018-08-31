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
     * ʹ�����ӳ�ʼ�� URL ����
     *
     * @param seeds ���� URL
     * @return
     */
    private static void initCrawlerWithSeeds(String[] seeds) {
        for (int i = 0; i < seeds.length; i++){
            Links.addUnvisitedUrlQueue(seeds[i]);
        }
    }
 
 
    /**
     * ץȡ����
     *
     * @param seeds
     * @return
     */
    public static List<News> crawling(String[] seeds) {
    	
    	NewsDao nDao = new NewsDao();
    	List<News> NewsList = new ArrayList<News>();
 
        //��ʼ�� URL ����
        initCrawlerWithSeeds(seeds);
        
        //�ȴӴ����ʵ�������ȡ����һ����
        String listPageUrl = (String) Links.removeHeadOfUnVisitedUrlQueue();
        if (listPageUrl == null){
            return null;
        }

        //����URL�õ�page;
        Page listPage = RequestAndResponseTool.sendRequstAndGetResponse(listPageUrl);

        //��page���д��� ����DOM��ĳ����ǩ
        ArrayList<String> detailPageLinks = PageParserTool.getAttrs(listPage,"div[class=blk02] li a","abs:href");
        for(String detailPageLink:detailPageLinks) {
        	System.out.println(detailPageLink);
        	Links.addUnvisitedUrlQueue(detailPageLink);
        }

        //���Ѿ����ʹ������ӷ����ѷ��ʵ������У�
        Links.addVisitedUrlSet(listPageUrl);
 
        //�������������ȡ�� ���˿���Ƶ����ͷ������
        LinkFilter filter = new LinkFilter() {
            public boolean accept(String url) {
                if (url.startsWith("http://edu.sina.com.cn/kaoyan/"))
                    return true;
                else
                    return false;
            }
        };
 
        //ѭ����������ץȡ�����Ӳ�����ץȡ����ҳ������ 1000
        while (!Links.unVisitedUrlQueueIsEmpty()  && Links.getVisitedUrlNum() <= 1000) {
 
            //�ȴӴ����ʵ�������ȡ����һ����
            String visitUrl = (String) Links.removeHeadOfUnVisitedUrlQueue();
            if (visitUrl == null || nDao.isExist(visitUrl)){
                continue;
            }
            
            if(!filter.accept(visitUrl)) {
            	continue;
            }
 
            //����URL�õ�page;
            Page page = RequestAndResponseTool.sendRequstAndGetResponse(visitUrl);
 
            //��ȡ����ҳ�ı���
            Element titleEle = PageParserTool.select(page, "h1[class=main-title]", 0);
            if(titleEle == null) {
            	continue;
            }
            String title = titleEle.text();
            
            //��ȡ����ҳ������
            Elements contentEles = PageParserTool.select(page, "div[id=artibody] p");
            Iterator iterator  = contentEles.iterator();
            String content = "";
            while(iterator.hasNext()) {
                Element element = (Element) iterator.next();
                String partOfContent = element.text();
                content = content +"\n"+ partOfContent;
            }
            
            //��ȡ����ҳ������
            Element dateEle = PageParserTool.select(page, "div[class=date-source] span[class=date]", 0);
            if(dateEle == null) {
            	continue;
            }
            String unparsedDate = dateEle.text();
            
            //���ַ���������Date��
            SimpleDateFormat ft = new SimpleDateFormat ("yyyy��MM��dd�� HH:mm"); 
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
            
            //���Ѿ����ʹ������ӷ����ѷ��ʵ������У�
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
 
 
    //main �������
   /* public static void main(String[] args) {
        MyCrawler crawler = new MyCrawler();
        crawler.crawling(new String[]{"http://edu.sina.com.cn/kaoyan/"});
    }*/
}
