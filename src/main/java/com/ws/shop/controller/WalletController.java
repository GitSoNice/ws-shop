package com.ws.shop.controller;

import com.ws.shop.entity.UserEntity;
import com.ws.shop.entity.WalletEntity;
import com.ws.shop.service.WalletEntityService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * 钱包Controller
 * @Author lqh
 * @Date 2018年4月2日 21:10:10
 */
@Controller
public class WalletController {

    private Logger logger = LoggerFactory.getLogger(WalletController.class);


    @Autowired
    WalletEntityService walletEntityService;


    @RequestMapping("findWalletByUid")
    public String findWallet(ModelMap modelMap, HttpSession session){
        UserEntity user = (UserEntity) session.getAttribute("user");
        if(user == null){
            logger.info("还未登陆!");
            return "login";
        }
        WalletEntity walletEntity = walletEntityService.findByUid(user.getUid());
        modelMap.put("userinfo",user);
        modelMap.put("wallet",walletEntity);
        return "userinfo/wallet";
    }


}
