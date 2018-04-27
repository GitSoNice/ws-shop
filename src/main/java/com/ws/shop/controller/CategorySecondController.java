package com.ws.shop.controller;

import com.ws.shop.bean.PageInfo;
import com.ws.shop.entity.CategoryEntity;
import com.ws.shop.entity.CategorySecondEntity;
import com.ws.shop.service.CategoryEntityService;
import com.ws.shop.service.CategorySecondEntityService;
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
import java.util.List;
import java.util.Map;

/**
 * 二级分类的controller
 * @Author lqh
 * @Date 2018年4月2日 21:04:24
 */
@Controller
public class CategorySecondController {

    private Logger logger = LoggerFactory.getLogger(CategorySecondController.class);

    @Autowired
    CategorySecondEntityService categorySecondEntityService;

    @Autowired
    CategoryEntityService categoryEntityService;

    /**
     * 更新二级分类
     * @param csid
     * @param csname
     * @param cid
     * @return
     */
    @RequestMapping(value = "/updateCategorySecond", method = RequestMethod.POST)
    public ModelAndView updateCategorySecond(@RequestParam("csid") Integer csid, @RequestParam("csname") String csname,
                                             @RequestParam("cid") Integer cid) {
        CategoryEntity category = categoryEntityService.findCategory(cid);
        logger.info("查找到的一级分类{}",category);
        CategorySecondEntity categorySecond = categorySecondEntityService.findCategorySecond(csid);
        if(categorySecond == null){
            logger.error("二级分类不存在");
            return null;
        }
        categorySecond.setCategory(category);
        categorySecond.setCsname(csname);
        logger.info("尝试更新二级分类{}",categorySecond);
        ActionResult res = categorySecondEntityService.updateCategorySecond(categorySecond);
        if(res.getCode() != 200){
            logger.error("更新二级分类失败");
        }
        logger.info("更新二级分类成功");
        ModelAndView modelAndView = new ModelAndView("redirect:/listCategorySecond?catespage=0");
        return modelAndView;
    }

    /**
     *添加编辑页面
     * @return
     */
    @RequestMapping(value = "/gotoAddCategorySecond")
    public ModelAndView gotoAddCategorySecond(Map<String, Object> map) {
        List<CategoryEntity> categorys = categoryEntityService.findCatagorys();
        map.put("categorys", categorys);
        ModelAndView modelAndView = new ModelAndView("admin/categorysecond/add");
        return modelAndView;
    }

    /**
     * 删除二级分类
     * @param csid
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteCategorySecond/{csid}")
    public ModelAndView deleteCategorySecond(@PathVariable("csid") Integer csid,HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.getAttribute("admin");
        CategorySecondEntity categorySecondEntity = categorySecondEntityService.findCategorySecond(csid);

        if(session ==null){
            logger.info("未登录为管理员");
            ModelAndView modelAndView = new ModelAndView("redirect:/adminlogin.htm" );
        }
        categorySecondEntityService.deleteCategorySecond(categorySecondEntity,1);
        ModelAndView modelAndView = new ModelAndView("redirect:/listCategorySecond?catespage=0");
        return modelAndView;
    }

    /**
     * 新增二级分类
     * @param csname
     * @param cid
     * @return
     */
    @RequestMapping(value = "/addCategorySecond")
    public ModelAndView addCategorySecond(@RequestParam("csname") String csname, @RequestParam("cid") Integer cid) {
        CategoryEntity category = categoryEntityService.findCategory(cid);
        logger.info("查找到一级分类{}",category);
        CategorySecondEntity categorySecond = new CategorySecondEntity();
        categorySecond.setCategory(category);
        categorySecond.setCsname(csname);
        logger.info("尝试新增二级分类{}",categorySecond);
        categorySecondEntityService.addCategorySecond(categorySecond);
        ModelAndView modelAndView = new ModelAndView("redirect:listCategorySecond?catespage=0");
        return modelAndView;
    }

    /**
     * 编辑页面
     * @param cid
     * @param categorySecondEntity
     * @param map
     * @return
     */
    @RequestMapping(value = "/gotoEditCategorySecond/{cid}")
    public String gotoEditCategory(@PathVariable("cid") Integer cid, @ModelAttribute("categorySecond") CategorySecondEntity categorySecondEntity, Map<String, Object> map) {
        categorySecondEntity = categorySecondEntityService.findCategorySecond(cid);
        map.put("categorySecond", categorySecondEntity);
        List<CategoryEntity> categorys = categoryEntityService.findCatagorys();
        map.put("categorys", categorys);
        return "admin/categorysecond/edit";
    }

    /**
     * 分页查找二级分类
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/listCategorySecond")
    public String listCategory(ModelMap map , PageInfo pageInfo, HttpServletRequest request) {
        int page =Integer.parseInt(request.getParameter("catespage"));
        pageInfo.setPage(page);
        Page<CategorySecondEntity> categorySecondEntity = categorySecondEntityService.SearchCategorySeconds(pageInfo);
        map.put("page", categorySecondEntity);
        return "admin/categorysecond/list";
    }
}
