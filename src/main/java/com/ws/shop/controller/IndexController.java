package com.ws.shop.controller;

import com.ws.shop.bean.PageInfo;
import com.ws.shop.entity.ProductsEntity;
import com.ws.shop.service.CategoryEntityService;
import com.ws.shop.service.ProductsEntityService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
public class IndexController {

    private Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    private CategoryEntityService categoryService;

    @Autowired
    private ProductsEntityService productService;

    /**
     * 商品首页
     * @param map
     * @param session
     * @return
     */
    @RequestMapping(value = "/index")
    public String showIndex(Map<String, Object> map, HttpSession session) {
        //把所有的一级分类都存入到session中
        session.setAttribute("cList", categoryService.findCatagorys());

        //把最新的10条商品存放到map集合中
        map.put("nList", productService.findNew());
        //把最热的10条商品添加到map集合中
        map.put("hList", productService.findHot("1"));

        return "index";
    }
}
