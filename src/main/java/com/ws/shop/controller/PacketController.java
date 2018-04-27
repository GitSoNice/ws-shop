package com.ws.shop.controller;

import com.ws.shop.bean.PageInfo;
import com.ws.shop.entity.PacketEntity;
import com.ws.shop.entity.TicketEntity;
import com.ws.shop.entity.UserEntity;
import com.ws.shop.service.PacketEntityService;
import com.ws.shop.service.TicketEntityService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 卡包Controller
 * @Author lqh
 * @Date 2018年4月2日 21:10:10
 */
@Controller
public class PacketController {

    private Logger logger = LoggerFactory.getLogger(PacketController.class);


    @Autowired
    PacketEntityService packetEntityService;

    @Autowired
    TicketEntityService ticketEntityService;


    @RequestMapping("findPacketByUid")
    public String findPacket(ModelMap modelMap, HttpSession session, PageInfo pageInfo, HttpServletRequest request){
        UserEntity user = (UserEntity) session.getAttribute("user");
        if(user == null){
            logger.info("还未登陆!");
            return "login";
        }
        int page =Integer.parseInt(request.getParameter("ppage"));
        pageInfo.setPage(page);
        PacketEntity packetEntity = packetEntityService.findByUid(user.getUid());
        Page<TicketEntity> tickets =ticketEntityService.findByPacid(packetEntity.getPacid(),pageInfo);
        modelMap.put("page",tickets);
        modelMap.put("userinfo",user);
        modelMap.put("packet",packetEntity);
        return "userinfo/packet";
    }


}
