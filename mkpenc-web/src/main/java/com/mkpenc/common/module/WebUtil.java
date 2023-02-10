package com.mkpenc.common.module;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.regex.Matcher;
import java.util.regex.Pattern;



public class WebUtil {
    public static String webEncoding(String browser, String name) throws IOException {
        String encodedFilename = "";
        if (browser.equals("MSIE")) {
            encodedFilename = URLEncoder.encode(name, "utf-8").replaceAll("\\+", "%20");
        } else if (browser.equals("Trident")) { // IE11 문자열 깨짐 방지
            encodedFilename = URLEncoder.encode(name, "utf-8").replaceAll("\\+", "%20");
        } else if (browser.equals("Firefox")) {
            //encodedFilename = new String(fileName.getBytes("utf-8"), "8859_1");
            encodedFilename = URLEncoder.encode(name, "utf-8").replaceAll("\\+", "%20");
        } else if (browser.equals("Opera")) {
            encodedFilename = new String(name.getBytes("utf-8"), "8859_1");
        } else if (browser.equals("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < name.length(); i++) {
                char c = name.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "utf-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedFilename = sb.toString();
        } else {
            throw new IOException("Not supported browser");
        }


        return encodedFilename;
    }

    public static String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
            return "Trident";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }

        return "Firefox";
    }

    public static String xssFilterReplace(String value){
        value = StringUtil.replaceAllIgnoreCase(value, "script", "scrlpt");
        value = StringUtil.replaceAllIgnoreCase(value, "embed", "embed");
        return value;
    }


    public static String setContentsCss(String contents, String act){
        if(act.equals("add")){
            String css = "<link type=\"text/css\" href=\"/resources/css/import.css\" rel=\"stylesheet\" property=\"stylesheet\" />";
            contents = css + contents;
        }else if(act.equals("remove")){
            Matcher mat;
            Pattern style = Pattern.compile("<link[^>]*type=[\"']?([^>\"']+)[\"']?[^>]*>", Pattern.DOTALL);
            mat = style.matcher(contents);
            contents = mat.replaceAll("");
        }

        return contents;
    }

    public static Document getHtml(String domain, String uri){
        try {
            Document doc = Jsoup.parse(new URL(domain + uri).openConnection().getInputStream(), "UTF-8", domain);

            Elements elems = doc.select("[src]");
            for( Element elem : elems){
                if( !elem.attr("src").equals(elem.attr("abs:src")) ){
                    elem.attr("src", elem.attr("abs:src"));
                }
            }

            elems = doc.select("[href]");
            for( Element elem : elems ){
                if( !elem.attr("href").equals(elem.attr("abs:href")) ){
                    elem.attr("href", elem.attr("abs:href"));
                }
            }
            return doc;
        } catch (Exception e) {
            System.out.println(domain+ uri + " 외부 URL 읽기 오류");
            e.printStackTrace();
        }

        return Jsoup.parse("<html></html>");
    }
}