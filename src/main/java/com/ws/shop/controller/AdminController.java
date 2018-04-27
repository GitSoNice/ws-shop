package com.ws.shop.controller;

import com.ws.shop.bean.PageInfo;
import com.ws.shop.entity.AdminEntity;
import com.ws.shop.entity.UserEntity;
import com.ws.shop.service.AdminEntityService;
import com.ws.shop.service.UserEntityService;
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
 * 管理员controller
 * @Author  lqh
 * @Date 2018年4月2日 21:04:02
 */
@Controller
public class AdminController {

    private Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    AdminEntityService adminEntityService;

    @Autowired
    UserEntityService userEntityService;

    /**
     * 管理员登陆界面
     * @return
     */
    @RequestMapping(value = "/adminlogin.htm")
    public String adminIndex() {
        return "admin/index";
    }

    /**
     * 顶部的界面
     * @return
     */
    @RequestMapping(value="/top")
    public String adminTop() {
        return "admin/top";
    }

    /**
     * 左侧导航栏
     * @return
     */
    @RequestMapping(value="/left")
    public String adminLeft() {
        return "admin/left";
    }

    /**
     * 登陆成功友好页面
     * @return
     */
    @RequestMapping(value="/welcome")
    public String adminWelcome() {
        return "admin/welcome";
    }

    /**
     * 底部
     * @return
     */
    @RequestMapping(value="/bottom")
    public String adminButtom() {
        return "admin/bottom";
    }

    /**
     * 管理员登陆验证
     * @param adminEntity
     * @param session
     * @return
     */
    @RequestMapping(value = "/adminLogin", method = RequestMethod.POST)
    public String adminLogin(AdminEntity adminEntity, HttpSession session) {
        AdminEntity admin = adminEntityService.checkAdminUser(adminEntity);
        logger.info("查找到管理员{}",admin);
        if (null == admin) {
            logger.info("不存在管理员");
            return "admin/index";
        } else {
            session.setAttribute("admin", admin);
        }
        return "admin/home";
    }

    /**
     * 分页查找用户
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/listUser")
    public String listUser(ModelMap map , PageInfo pageInfo,HttpServletRequest request) {
        int page =Integer.parseInt(request.getParameter("page"));
        pageInfo.setPage(page);
        logger.info("开始查找所有用户并进行分页");
        Page<UserEntity> users = userEntityService.SearchUsers(pageInfo);
        map.put("page", users);
        return "admin/user/list";
    }

    /**
     * 通过用户的uid查找用户
     * @param uid
     * @param map
     */
    @ModelAttribute(value = "user")
    public void getUser(@RequestParam(value = "uid", required = false) Integer uid, Map<String, Object> map) {
        if (uid != null) {
            UserEntity user = adminEntityService.SearchUser(uid);
            logger.info("根据uid查找到的用户{}",user);
            map.put("user", user);
        }
    }

    /**
     * 更新用户信息
     * @param user
     * @return
     */
    @RequestMapping(value = "/updateUser")
    public ModelAndView updateUser(@ModelAttribute("user") UserEntity user) {
        logger.info("尝试更新用户{}",user);
        ActionResult res = adminEntityService.updateUser(user);
        if(res.getCode() != 200){
            logger.info("更新用户失败");
        }
        logger.info("更新用户成功");
        ModelAndView model = new ModelAndView();
        model.setViewName("redirect:/listUser?page=0");
        return model;
    }

    /**
     * 更新用户的编辑页面
     * @param uid
     * @param user
     * @param map
     * @return
     */
    @RequestMapping(value = "/editUser/{uid}")
    public String editUser(@PathVariable("uid") Integer uid, @ModelAttribute("user") UserEntity user, Map<String, Object> map) {
        user = adminEntityService.SearchUser(uid);
        logger.info("根据uid查找到的用户{}",user);
        map.put("user", user);
        return "admin/user/edit";
    }
}
