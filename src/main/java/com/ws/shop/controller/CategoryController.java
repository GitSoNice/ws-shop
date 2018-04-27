package com.ws.shop.controller;

import com.ws.shop.bean.PageInfo;
import com.ws.shop.entity.CategoryEntity;
import com.ws.shop.service.AdminEntityService;
import com.ws.shop.service.CategoryEntityService;
import com.ws.shop.utils.ActionResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 一级分类Controller
 * @Author lqh
 * @Date 2018年4月2日 21:04:15
 */
@Controller
public class CategoryController {

    private Logger logger = LoggerFactory.getLogger(CategoryController.class);

    @Autowired
    CategoryEntityService categoryEntityService;

    @Autowired
    AdminEntityService adminEntityService;

    /**
     * 分页查询一级分类
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/listCategory")
    public String listCategory(ModelMap map , PageInfo pageInfo, HttpServletRequest request) {
        int page =Integer.parseInt(request.getParameter("catepage"));
        pageInfo.setPage(page);
        Page<CategoryEntity> categorys = categoryEntityService.SearchCategorys(pageInfo);
        map.put("page", categorys);
        return "admin/category/list";
    }

    /**
     * 通过cid查找一级分类
     * @param cid
     * @param map
     */
    @ModelAttribute(value = "category")
    public void getCategory(@RequestParam(value = "cid", required = false) Integer cid, Map<String, Object> map) {
        if (cid != null) {
            CategoryEntity category = categoryEntityService.findCategory(cid);
            logger.info("根据cid查找到的一级分类{}",category);
            map.put("category", category);
        }
    }

    /**
     * 更新一级分类的编辑界面
     * @param cid
     * @return
     */
    @RequestMapping(value = "/gotoEditCategory/{cid}")
    public String gotoEditCategory(@PathVariable("cid") Integer cid,@ModelAttribute("category") CategoryEntity categoryEntity,Map<String, Object> map) {
            categoryEntity = categoryEntityService.findCategory(cid);
            logger.info("根据cid查找到的一级分类{}",categoryEntity);
            map.put("category", categoryEntity);
            return "admin/category/edit";
    }

    /**
     * 更新一级分类
     * @param category
     * @return
     */
    @RequestMapping(value = "/updateCategory")
    public ModelAndView updateCategory(@ModelAttribute("category") CategoryEntity category) {
        logger.info("尝试更新一级分类{}",category);
        ActionResult res =categoryEntityService.updateCategory(category);
        if(res.getCode()!=200){
            logger.error("更新一级分类失败");
        }
        logger.info("更新一级分类成功");
        ModelAndView model = new ModelAndView();
        model.setViewName("redirect:/listCategory?catepage=0");
        return model;
    }

    /**
     * 删除一级分类
     * @param cid
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteCategory/{cid}")
    public ModelAndView deleteCategory(@PathVariable("cid") Integer cid,HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.getAttribute("admin");
        CategoryEntity categoryEntity = categoryEntityService.findCategory(cid);
        if(session ==null){
            logger.info("没有登陆为管理员");
            ModelAndView modelAndView = new ModelAndView("redirect:/adminlogin.htm" );
        }
        logger.info("尝试删除一级分类{}",categoryEntity);
        categoryEntityService.deleteCategory(categoryEntity,1);
        ModelAndView modelAndView = new ModelAndView("redirect:/listCategory?catepage=0" );
        return modelAndView;
    }

    /**
     * 添加一级分类的编辑页面
     * @return
     */
    @RequestMapping(value = "/gotoAddCategory")
    public ModelAndView gotoAddProduct() {
        ModelAndView modelAndView = new ModelAndView("admin/category/add");
        return modelAndView;
    }

    /**
     * 保存一级分类
     * @param category
     * @return
     */
    @RequestMapping(value = "/addCategory", method = RequestMethod.POST)
    public ModelAndView addProduct(@ModelAttribute("category") CategoryEntity category) {
        logger.info("尝试保存一级分类{}",category);
        categoryEntityService.addCategory(category);
        ModelAndView modelAndView = new ModelAndView("redirect:listCategory?catepage=0");
        return modelAndView;
    }


}

