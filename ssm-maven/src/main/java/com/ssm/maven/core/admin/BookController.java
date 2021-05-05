package com.ssm.maven.core.admin;

import com.ssm.maven.core.entity.Book;
import com.ssm.maven.core.entity.PageBean;
import com.ssm.maven.core.entity.User;
import com.ssm.maven.core.service.BookService;
import com.ssm.maven.core.util.MD5Util;
import com.ssm.maven.core.util.ResponseUtil;
import com.ssm.maven.core.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 1034683568@qq.com
 * @project_name ssm-maven
 * @date 2017-3-1
 */
@Controller
@RequestMapping("/book")
public class BookController {
    @Resource
    private BookService bookService;
    private static final long serialVersionUID = 1L;
    private static final Logger log = Logger.getLogger(BookController.class);// 日志文件

    /**
     * 娣诲姞鎴栦慨鏀圭鐞嗗憳
     *
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/update")
    public String save(Book book, HttpServletResponse response) throws Exception {
        int resultTotal = 0;
        String comment = book.getSupply();
        book.setSupply(comment);
        resultTotal = bookService.updateBook(book);
        
        JSONObject result = new JSONObject();
        if (resultTotal > 0) {
            result.put("success", true);
        } else {
            result.put("success", false);
        }
        log.info("request: book/update , book: " + book.toString());
        ResponseUtil.write(response, result);
        return null;
    }
    
    
    
    @RequestMapping("/listAll")
    public String listAll(
            @RequestParam(value = "page", required = false) String page,
            @RequestParam(value = "rows", required = false) String rows,
            @RequestParam(value = "success", required = false) String success,
            Book book, HttpServletResponse response) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        if (page != null && rows != null) {
            PageBean pageBean = new PageBean(Integer.parseInt(page),
                    Integer.parseInt(rows));
            map.put("start", pageBean.getStart());
            map.put("size", pageBean.getPageSize());
        }
        List<Book> bookList = null;
        Long total = 0L;
        if (book.getAuthor() != null &&
                !"".equals(book.getAuthor())) {
            map.put("author", StringUtil.formatLike(book.getAuthor()));
        }
        if (book.getTitle() != null &&
                !"".equals(book.getTitle())) {
            map.put("title", StringUtil.formatLike(book.getTitle()));
        }
        if (book.getIsbn() != null &&
                !"".equals(book.getIsbn())) {
            map.put("isbn", book.getIsbn() + "");
        }
        if (book.getPublisher() != null &&
                !"".equals(book.getPublisher())) {
            map.put("publisher", book.getPublisher() + "");
        }
        bookList = bookService.findBooks(map);
        total = bookService.getTotalBooks(map);
        JSONObject result = new JSONObject();
        JSONArray jsonArray = JSONArray.fromObject(bookList);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);
        log.info("request: book/listAll , map: " + map.toString());
        return null;
    }

}
