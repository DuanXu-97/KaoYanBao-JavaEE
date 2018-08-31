package com.kyb.crawl.page;

import com.kyb.crawl.util.CharsetDetector;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import java.io.UnsupportedEncodingException;

public class Page {
	private byte[] content ;
    private String html ;  //ÍøÒ³Ô´Âë×Ö·û´®
    private Document doc  ;//ÍøÒ³DomÎÄµµ
    private String charset ;//×Ö·û±àÂë
    private String url ;//urlÂ·¾¶
    private String contentType ;// ÄÚÈİÀàĞÍ


    public Page(byte[] content , String url , String contentType){
        this.content = content ;
        this.url = url ;
        this.contentType = contentType ;
    }

    public String getCharset() {
        return charset;
    }
    public String getUrl(){return url ;}
    public String getContentType(){ return contentType ;}
    public byte[] getContent(){ return content ;}

    /**
     * ·µ»ØÍøÒ³µÄÔ´Âë×Ö·û´®
     *
     * @return ÍøÒ³µÄÔ´Âë×Ö·û´®
     */
    public String getHtml() {
        if (html != null) {
            return html;
        }
        if (content == null) {
            return null;
        }
        if(charset==null){
            charset = CharsetDetector.guessEncoding(content); // ¸ù¾İÄÚÈİÀ´²Â²â ×Ö·û±àÂë
        }
        try {
            this.html = new String(content, charset);
            return html;
        } catch (UnsupportedEncodingException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    /*
    *  µÃµ½ÎÄµµ
    * */
    public Document getDoc(){
        if (doc != null) {
            return doc;
        }
        try {
            this.doc = Jsoup.parse(getHtml(), url);
            return doc;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
}
