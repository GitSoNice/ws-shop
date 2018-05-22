package com.ws.shop.controller;

import com.ws.shop.bean.Cart;
import com.ws.shop.bean.CartItem;
import com.ws.shop.bean.PageInfo;
import com.ws.shop.entity.*;
import com.ws.shop.service.OrderEntityService;
import com.ws.shop.service.ProductsEntityService;
import com.ws.shop.service.WalletEntityService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * 订单类controller
 * @Author lqh
 * @Date 2018年4月2日 21:04:53
 */
@Controller
public class OrderController {

    private Logger logger = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private OrderEntityService orderEntityService;

    @Autowired
    WalletEntityService walletEntityService;

    @Autowired
    ProductsEntityService productsEntityService;

    /**
     * 分页查询所有订单
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/listOrder")
    public String listOrder(ModelMap map , PageInfo pageInfo, HttpServletRequest request) {
        int page =Integer.parseInt(request.getParameter("opage"));
        pageInfo.setPage(page);
        Page<OrdersEntity> ordersEntity = orderEntityService.SearchOrders(pageInfo);
        map.put("page", ordersEntity);
        return "admin/order/list";
    }

    /**
     * 删除订单
     * @param oid
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteOrder/{oid}")
    public ModelAndView deleteProduct(@PathVariable("oid") Integer oid, HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.getAttribute("admin");
        OrdersEntity order = orderEntityService.findByOid(oid);
        if(session ==null){
            logger.info("未登录为管理员");
            ModelAndView modelAndView = new ModelAndView("redirect:/adminlogin.htm" );
        }
        orderEntityService.deleteOrder(order,1);
        ModelAndView modelAndView = new ModelAndView("redirect:/listOrder?opage=0");
        return modelAndView;
    }

    /**
     * 查找订单项
     * @param oid
     * @param map
     * @param response
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/findOrderItem/{oid}/{time}")
    public String findOrderItem(@PathVariable("oid") Integer oid, Map<String, Object> map,
                                HttpServletResponse response) throws IOException {
        OrdersEntity order = orderEntityService.findByOid(oid);
        logger.info("找到order{}",order);
        Set<OrderItemEntity> orderItem = order.getOrderItems();
        map.put("orderItems", orderItem);
        return "admin/order/orderItem";
    }

    /**
     * 更新订单状态
     * @param oid
     * @return
     */
    @RequestMapping(value = "/updateStateOrder/{oid}")
    public ModelAndView updateStateOrder(@PathVariable("oid") Integer oid) {
        ModelAndView modelAndView = new ModelAndView("redirect:/listOrder?opage=0");
        OrdersEntity order = orderEntityService.findByOid(oid);
        order.setState(3);
        orderEntityService.update(order);
        return modelAndView;
    }

    /**
     * 根据oid查找订单
     * @param oid
     * @param map
     * @return
     */
    @RequestMapping(value="findByOid/{oid}")
    public String findByOid(@PathVariable("oid")Integer oid,ModelMap map) {

        OrdersEntity order = orderEntityService.findByOid(oid);
        map.put("order", order);
        return "new_order";
    }

    @RequestMapping(value="findOrderByUid")
    public String findByUid(ModelMap map ,HttpSession session, PageInfo pageInfo, HttpServletRequest request){
        UserEntity user =(UserEntity)session.getAttribute("user");
        if (user == null) {
            map.put("notLogin", "notLogin");
            return "msg";
        }
        int page =Integer.parseInt(request.getParameter("uopage"));
        pageInfo.setPage(page);
        Page<OrdersEntity> ordersEntity = orderEntityService.findByUid(user.getUid(),pageInfo);
        map.put("page", ordersEntity);
        return "new_orderList";
    }

    /**
     * 确认订单
     * @param session
     * @param map
     * @return
     */
    @RequestMapping(value = "/saveOrder")
    public String saveOrder(HttpSession session, ModelMap map) {
        //判断用户是否登陆,
        UserEntity user = (UserEntity) session.getAttribute("user");
        if (user == null) {
            map.put("notLogin", "noLogin");
            return "msg";
        }
        Cart cart = (Cart) session.getAttribute("cart");
        logger.info("cart{}",cart.getTotal());
        if (cart == null) {
            return "redirect:myCart";
        }
        OrdersEntity order = new OrdersEntity();
        order.setTotal(cart.getTotal());
        // 1:未付款. 2.已经付款，没有发货 3.发货，没有确认发货 4.交易完成
        order.setState(1);
        // 设置订单时间
        order.setOrdertime(new Date());
        // 设置订单关联的客户:
        order.setUser(user);
        // 设置订单项集合:
        Set<OrderItemEntity> sets = new HashSet<OrderItemEntity>();
        for (CartItem cartItem : cart.getCartItems()) {
            // 订单项的信息从购物项获得的.
            OrderItemEntity orderItem = new OrderItemEntity();
            orderItem.setCount(cartItem.getCount());
            orderItem.setSubtotal(cartItem.getSubtotal());
            orderItem.setProduct(cartItem.getProduct());
            //双向关联时在多的一方设置一的一方的属性
            orderItem.setOrders(order);
            //把orderItem对象添加到集合中
            sets.add(orderItem);
        }
        //双向关联时在一的一方设置多的一方的属性
        order.setOrderItems(sets);
        orderEntityService.saveOrders(order);
        //清除购物车
        cart.clearCart();
        map.put("order", order);
        return "new_order";
    }

    /**
     * 支付订单
     * @param oid
     * @param addr
     * @param name
     * @param phone
     * @param total
     * @param session
     * @param map
     * @return
     */
    @RequestMapping(value = "/payOrder")
    public String payOrder(Integer oid, String addr, String name, String phone, PageInfo pageInfo, String total, HttpSession session,
                           ModelMap map) {
        //根据oid查找订单
        OrdersEntity order = orderEntityService.findByOid(oid);
        order.setAddr(addr);
        order.setName(name);
        order.setPhone(phone);
        orderEntityService.update(order);

        //获得用户
        UserEntity user = order.getUser();
        //获得钱包
        WalletEntity wallet = walletEntityService.findByUid(user.getUid());
        Float money = wallet.getMoney();
        Float fee = Float.parseFloat(total);

        pageInfo.setPage(0);
        Page<OrdersEntity> ordersEntity = orderEntityService.findByUid(user.getUid(),pageInfo);
        map.put("page", ordersEntity);
        //如果钱包余额大于消费金额，更新商品库存
        if (money >= fee) {

            for (OrderItemEntity orderItem : order.getOrderItems()) {
                Integer pid = orderItem.getProduct().getPid();
                Integer inventory = orderItem.getProduct().getInventory();
                ProductsEntity product = orderItem.getProduct();
                product.setInventory(inventory - orderItem.getCount());
                productsEntityService.updateProduct(product);
            }

            //钱包余额扣除消费金额，并更新
            wallet.setMoney(money - fee);
            walletEntityService.updateWallet(wallet);

            // 根据oid查看订单，并将状态改为已付款
            OrdersEntity afterOrder = orderEntityService.findByOid(oid);
            afterOrder.setState(2);
            orderEntityService.saveOrders(afterOrder);
            map.put("paymentSuccess", "success");
            return "new_orderList";
        }
        map.put("paymentFalse", "false");
        return "new_orderList";
    }

    /**
     * 修改为确认订单状态
     * @param oid
     * @return
     */
    @RequestMapping(value = "updateState/{oid}")
    public ModelAndView updateState(@PathVariable("oid") Integer oid) {
        OrdersEntity order = orderEntityService.findByOid(oid);
        order.setState(4);
        orderEntityService.saveOrders(order);
        ModelAndView model = new ModelAndView("redirect:/findOrderByUid?uopage=0");
        return model;
    }

    /**
     * 根据商品id，商品名字，二级分类查找商品并分页
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/findByOidAndUid")
    public String findByOidAndUid(ModelMap map , PageInfo pageInfo,HttpServletRequest request) throws UnsupportedEncodingException {
        String strOid = request.getParameter("oid");
        int page =Integer.parseInt(request.getParameter("oupage"));
        String strUid = request.getParameter("uid");
        Integer oid =null ;
        Integer uid =null ;
        pageInfo.setPage(page);
        if(StringUtils.isBlank(strOid)&&StringUtils.isBlank(strUid)){
            Page<OrdersEntity> ordersEntity = orderEntityService.SearchOrders(pageInfo);
            map.put("page", ordersEntity);
            return "admin/order/list";
        }
        if(StringUtils.isNotBlank(strOid)&&StringUtils.isNotBlank(strUid)){
            oid = Integer.parseInt(strOid);
            uid = Integer.parseInt(strUid);
            logger.info("开始查找根据订单编号和用户编号查找订单并进行分页");
            Page<OrdersEntity> orders = orderEntityService.findByOidAndUid(oid,uid,pageInfo);
            map.put("page", orders);
            map.put("oid",oid);
            map.put("uid",uid);
            return "admin/order/list";
        }
        if(StringUtils.isNotBlank(strUid)){
            logger.info("开始查找根据用户编号查找订单并进行分页");
            uid = Integer.parseInt(strUid);
            Page<OrdersEntity> orders = orderEntityService.adminFindByUid(uid,pageInfo);
            map.put("page", orders);
        }
        if(StringUtils.isNotBlank(strOid)){
            logger.info("开始查找根据订单编号查找订单并进行分页");
            oid = Integer.parseInt(strOid);
            Page<OrdersEntity> orders = orderEntityService.adminFindByOid(oid,pageInfo);
            map.put("page", orders);
        }
        map.put("oid",oid);
        map.put("uid",uid);
        return "admin/order/list";
    }

}
