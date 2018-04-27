package com.ws.shop.controller;

import com.ws.shop.bean.Cart;
import com.ws.shop.bean.CartItem;
import com.ws.shop.entity.*;
import com.ws.shop.service.PacketEntityService;
import com.ws.shop.service.ProductsEntityService;
import com.ws.shop.service.TicketEntityService;
import com.ws.shop.service.UserEntityService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.security.krb5.internal.Ticket;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Map;

/**
 * 购物车controller
 * @author LQH
 * @date 2018年4月14日 20:56:58
 */
@Controller
public class CartController {

    @Autowired
    ProductsEntityService productsEntityService;

    @Autowired
    UserEntityService userEntityService;

    @Autowired
    PacketEntityService packetEntityService;

    @Autowired
    TicketEntityService ticketEntityService;

    /**
     * 从主页进入购物车
     * @param session
     * @param map
     * @return
     */
    @RequestMapping("/myCart")
    public String Cart(HttpSession session,ModelMap map) {
        UserEntity user =(UserEntity)session.getAttribute("user");
        if (user == null) {
            map.put("notLogin", "notLogin");
            return "msg";
        }
        return "cart";
    }

    /**
     * 清空购物车
     * @param session
     * @return
     */
    @RequestMapping(value = "/clearCart")
    public String clearCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        cart.clearCart();
        return "cart";
    }

    /**
     * 删除购物车中的商品
     * @param pid
     * @param session
     * @return
     */
    @RequestMapping(value = "/removeCart/{pid}")
    public String removeCart(@PathVariable("pid") Integer pid, HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");
        cart.removeCart(pid);
        return "cart";
    }

    /**
     * 进行优惠后的价格
     * @param total
     * @param session
     * @return
     */
    @RequestMapping(value = "/ChangeTotal/{total}", method = RequestMethod.POST)
    @ResponseBody
    public String changeCart(@PathVariable("total") float total, HttpSession session) {
        //获得购物车对象
        Cart cart = (Cart) session.getAttribute("cart");
        cart.setTotal(total);
        session.setAttribute("cart", cart);
        return null;
    }

    /**
     * 将商品添加到购物车
     * @param pid
     * @param count
     * @param session
     * @param map
     * @return
     */
    @RequestMapping(value = "/addCart")
    public String addCart(Integer pid, Integer count, HttpSession session, Map<String, Object> map) {

        ProductsEntity product = productsEntityService.findByPid(pid);
        CategorySecondEntity categorySecond = product.getCategorySecond();
        CategoryEntity category = categorySecond.getCategory();

        Date privilege = category.getPrivilegeTime();
        String privilegeTime = StringUtils.substring(privilege.toString(),0,10);
        map.put("privilegeTime", privilegeTime);

        TicketEntity ticket = category.getTicket();
        map.put("ticket", ticket);
        map.put("count", count);
        Float finalPrice = Float.valueOf(((String) session.getAttribute("price")).replace(",", ""));

        CartItem cartItem = new CartItem();
        cartItem.setCount(count);
        cartItem.setProduct(product);
        cartItem.setPrice(finalPrice);

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        cart.addCart(cartItem);
        return "cart";
    }

}