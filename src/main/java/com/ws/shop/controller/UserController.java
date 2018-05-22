package com.ws.shop.controller;

import com.ws.shop.bean.PageInfo;
import com.ws.shop.entity.ProductsEntity;
import com.ws.shop.utils.ActionResult;
import com.ws.shop.utils.MD5;
import com.ws.shop.entity.UserEntity;
import com.ws.shop.service.UserEntityService;
import com.ws.shop.utils.MailUtil;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

/**
 * 用户Controller
 * @Author lqh
 * @Date 2018年4月2日 21:10:10
 */
@Controller
public class UserController {

    private Logger logger = LoggerFactory.getLogger(UserController.class);


    @Autowired
    UserEntityService userEntityService;

    @ModelAttribute(value = "user")
    public UserEntity getUser() {
        return new UserEntity();
    }

    /**
     * 用户退出
     * @param session
     * @param request
     * @return
     */
    @RequestMapping("/quit")
    public String quit(HttpSession session, HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:index";
    }

    /**
     * 用户登录
     * @param user
     * @param checkcode
     * @param session
     * @param map
     * @return
     */
    @RequestMapping(value = "login")
    public String login(@ModelAttribute("user") UserEntity user, String checkcode,String isRememberUsername,String autoLogin,
                        HttpSession session, Map<String, Object> map,HttpServletResponse response) {
        //从session中获取验证码
        String checkCode = (String) session.getAttribute("checkcode");
        //如果验证码不一致，直接返回到登陆的页面
        if (!checkCode.equalsIgnoreCase(checkcode)) {
            map.put("errorCheckCode", "errorCheckCode");
            return "new_login";
        }

        Cookie cookie = new Cookie("username",user.getUsername());
        cookie.setPath("/");
        if(isRememberUsername != null){
            cookie.setMaxAge(Integer.MAX_VALUE);

        }else{
            cookie.setMaxAge(0);
        }
        response.addCookie(cookie);

        //判断是否存在用户
        UserEntity isExistUser = userEntityService.existUser(user.getUsername());
        if (isExistUser == null) {
            map.put("notUser", "notUser");
            return "new_login";
        }
        //判断用户名和密码是否都正确
        String md5Password = MD5.md5(user.getPassword());
        user.setPassword(md5Password);
        UserEntity u = userEntityService.findUserByUsernameAndPassword(user);
        if (u == null) {
            map.put("notPassword", "notPassword");
            return "new_login";
        }
        session.setAttribute("user", u);
        return "redirect:index";
    }

    /**
     * 用户登录界面
     * @return
     */
    @RequestMapping(value = "/userLogin")
    public String userLogin() {
        return "new_login";
    }

    /**
     * 用户注册
     * @param user
     * @param result
     * @param session
     * @param checkcode
     * @param map
     * @return
     */
    @RequestMapping(value = "register", method = RequestMethod.POST)
    public String register(@ModelAttribute("user") @Valid UserEntity user, BindingResult result, HttpSession session,
                           String checkcode, Map<String, Object> map) {

        //如果有错误，直接跳转到注册的页面
        if (result.hasErrors()) {

            //在控制台打印错误的信息
            List<ObjectError> errorList = result.getAllErrors();
            for (ObjectError error : errorList) {
                logger.error(error.getDefaultMessage());
            }

            //返回到注册页面
            return "new_regist";
        }
        //从session中获取验证码
        String checkCode = (String) session.getAttribute("checkcode");

        //如果验证码不一致，直接返回
        if (!checkCode.equalsIgnoreCase(checkcode)) {
            map.put("errorCheckCode", "errorCheckCode");
            return "new_regist";
        }
        String md5Password = MD5.md5(user.getPassword());
        user.setPassword(md5Password);
        userEntityService.register(user);
        map.put("registerSuccess","Success");
        return "msg";
    }

    /**
     * 使用ajax判断用户是否存在
     * @param userName
     * @param response
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/checkUser/{userName}", method = RequestMethod.POST)
    @ResponseBody
    public String existUser(@PathVariable("userName") String userName, HttpServletResponse response)
            throws IOException {

        System.out.println(userName);
        response.setContentType("text/html;charset=UTF-8");
        if (userEntityService.existUser(userName) != null) {

            // 用户名存在
            response.getWriter().println("1");
        } else {

            // 可以使用用户名
            response.getWriter().println("0");
        }
        return null;
    }

    /**
     * 用户注册
     * @return
     */
    @RequestMapping("userRegister")
    public String register() {
        return "new_regist";
    }

    /**
     * 登陆时忘记密码，跳转到修改密码页面
     * @return
     */
    @RequestMapping("forgetPassword")
    public String forgetPassword() {
        return "new_forgetpassword";
    }

    /**
     * 登录前通过旧密码，修改密码操作
     * @param user
     * @param session
     * @param map
     * @return
     */
    @RequestMapping(value = "beReset", method = RequestMethod.POST)
    public String beResetPassword(UserEntity user,HttpSession session,@RequestParam String repassword, ModelMap map){
        String md5Password = MD5.md5(user.getPassword());
        user.setPassword(md5Password);
        UserEntity u = userEntityService.findUserByUsernameAndPassword(user);
        if(u != null){
            String md5RePassword = MD5.md5(repassword);
            u.setPassword(md5RePassword);
            ActionResult res = userEntityService.update(u);
            if(res.getCode() == 200){
                map.put("resetsuccess","success");
                return "new_login";
            }
        }
        map.put("resetfailed","failed");
        return "new_forgetpassword";
    }

    /**
     * 登录前通过发送邮件，修改密码操作
     * @param user
     * @param session
     * @param map
     * @return
     */
    @RequestMapping(value = "beSendEmail", method = RequestMethod.POST)
    public String beSendMail(UserEntity user,HttpSession session,ModelMap map){
        UserEntity u = userEntityService.existUser(user.getUsername());
        if(u == null){
            map.put("noExistUser","false");
            return "new_forgetPassword";
        }
        String randomPassword = RandomStringUtils.randomAlphabetic(8);
        String md5Password = MD5.md5(randomPassword);
        if(!user.getEmail().equals(u.getEmail())){
            logger.info("邮箱不正确，不能进行密码修改");
            map.put("emailFalse","false");
            return "new_forgetpassword";
        }
        u.setPassword(md5Password);
        ActionResult res = userEntityService.update(u);
        if(res.getCode() == 200) {
            try {
                logger.info("开始发送邮件：");
                MailUtil.testSendEmail(u.getEmail(), randomPassword, u.getUsername());
                map.put("sendEmail", "success");
                return "new_login";
            } catch (Exception e) {
                logger.info("发送邮件失败{}", e);
                map.put("sendEmail", "failed");
                return "new_forgetpassword";
            }
        }
        map.put("sendEmail", "failed");
        return "new_forgetpassword";
    }

    /**
     * 登陆后修改密码页面
     * @return
     */
    @RequestMapping("toRetPassword")
    public String toResetPassword(HttpSession session,ModelMap map,HttpServletRequest request) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        if(request.getParameter("resetfailed") != null){
            String reset =request.getParameter("resetfailed");
            if(reset.equals("failed")){
                map.put("resetfailed","failed");
            }
        }
        if(request.getParameter("emailFalse") != null){
            String reset =request.getParameter("emailFalse");
            if(reset.equals("false")){
                map.put("emailFalse","false");
            }
        }
        if(request.getParameter("sendEmail") != null){
            String reset =request.getParameter("sendEmail");
            if(reset.equals("failed")){
                map.put("sendEmail","failed");
            }
        }
        if(user != null){
            map.put("userinfo",user);
            return "userinfo/new_resetpassword";
        }
        return "new_login";
    }

    /**
     * 登录后通过旧密码，修改密码操作
     * @param user
     * @param session
     * @param map
     * @return
     */
    @RequestMapping(value = "reset", method = RequestMethod.POST)
    public String resetPassword(UserEntity user,HttpSession session,@RequestParam String repassword, ModelMap map){
        UserEntity userEntity = (UserEntity) session.getAttribute("user");
        String md5Password = MD5.md5(user.getPassword());
        userEntity.setPassword(md5Password);
        UserEntity u = userEntityService.findUserByUsernameAndPassword(userEntity);
        if(u != null){
            String md5RePassword = MD5.md5(repassword);
            userEntity.setPassword(md5RePassword);
            ActionResult res = userEntityService.update(userEntity);
            if(res.getCode() == 200){
                session.invalidate();
                map.put("resetsuccess","success");
                return "new_login";
            }
        }
        map.put("resetfailed","failed");
        return "redirect:toRetPassword";
    }

    /**
     * 登录后通过发送邮件，修改密码操作
     * @param user
     * @param session
     * @param map
     * @return
     */
    @RequestMapping(value = "sendEmail", method = RequestMethod.POST)
    public String sendeMail(UserEntity user,HttpSession session,ModelMap map){
        UserEntity userEntity = (UserEntity) session.getAttribute("user");
        String randomPassword = RandomStringUtils.randomAlphabetic(8);
        String md5Password = MD5.md5(randomPassword);
        if(!user.getEmail().equals(userEntity.getEmail())){
            logger.info("邮箱不正确，不能进行密码修改");
            map.put("emailFalse","false");
            return "redirect:toRetPassword";
        }
        userEntity.setPassword(md5Password);
        ActionResult res = userEntityService.update(userEntity);
        if(res.getCode() == 200){
            session.invalidate();
        }
        try {
            logger.info("开始发送邮件：");
            MailUtil.testSendEmail(userEntity.getEmail(),randomPassword,userEntity.getUsername());
            map.put("sendEmail","success");
            return "new_login";
        } catch (Exception e) {
            logger.info("发送邮件失败{}",e);
            map.put("sendEmail","failed");
            return "redirect:toRetPassword";
        }
    }

    /**
     * 个人信息
     * @param map
     * @param session
     * @return
     */
    @RequestMapping("finduserInfo")
    public String userInfo(ModelMap map,HttpSession session,HttpServletRequest request){
        if(request.getParameter("updateSuccess") != null){
            String res = request.getParameter("updateSuccess");
            if(res.equals("success")){
                map.put("updateSuccess","success");
            }else{
                map.put("updateSuccess","falied");
            }
        }
        UserEntity user = (UserEntity) session.getAttribute("user");
        if(user != null){
            map.put("userinfo",user);
            return "userinfo/new_userinfo";
        }
        return "new_login";
    }

    /**
     * 修改个人信息
     * @param userEntity
     * @param map
     * @param session
     * @return
     */
    @RequestMapping("/updateUserInfo")
    public String updateUserInfo(UserEntity userEntity,ModelMap map, HttpSession session){
            logger.info("待修改数据{}",userEntity);
            ActionResult res = userEntityService.update(userEntity);
            if(res.getCode() == 200){
                session.setAttribute("user",userEntity);
                map.put("updateSuccess","success");
                return "redirect:finduserInfo";
            }
            map.put("updateSuccess","failed");
            return "redirect:finduserInfo";
        }

    /**
     * 根据用户名查找用户并分页
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/findByUserName")
    public String findByUserName(ModelMap map , PageInfo pageInfo, HttpServletRequest request) throws UnsupportedEncodingException {
        String username = request.getParameter("username");
        int page =Integer.parseInt(request.getParameter("uupage"));
        pageInfo.setPage(page);
        logger.info("开始查找根据用户名查找用户并进行分页");
        Page<UserEntity> users = userEntityService.findByUserName(username,pageInfo);
        map.put("page", users);
        map.put("username",username);
        return "admin/user/list";
    }

    /**
     * 根据用户名查找用户并分页
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/findByUserName1")
    public String findByUserName1(ModelMap map , PageInfo pageInfo, HttpServletRequest request) throws UnsupportedEncodingException {
        String username = request.getParameter("username");
        username = new String(username.getBytes("ISO8859-1"), "UTF-8");
        int page =Integer.parseInt(request.getParameter("uupage"));
        pageInfo.setPage(page);
        logger.info("开始查找根据用户名查找用户并进行分页");
        Page<UserEntity> users = userEntityService.findByUserName(username,pageInfo);
        map.put("page", users);
        map.put("username",username);
        return "admin/user/list";
    }
}
