package com.ws.shop.controller;

import com.ws.shop.bean.PageInfo;
import com.ws.shop.entity.CategoryEntity;
import com.ws.shop.entity.CategorySecondEntity;
import com.ws.shop.entity.ProductsEntity;
import com.ws.shop.entity.UserEntity;
import com.ws.shop.service.AdminEntityService;
import com.ws.shop.service.CategorySecondEntityService;
import com.ws.shop.service.ProductsEntityService;
import com.ws.shop.utils.ActionResult;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 商品类controller
 * @Author lqh
 * @Date 2018年4月2日 21:05:14
 */
@Controller
public class ProductsController {

    private Logger logger = LoggerFactory.getLogger(ProductsController.class);

    @Autowired
    ProductsEntityService productsEntityService;

    @Autowired
    AdminEntityService adminEntityService;

    @Autowired
    CategorySecondEntityService categorySecondEntityService;

    /**
     * 分页查询所有商品
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/listProduct")
    public String listProduct(ModelMap map , PageInfo pageInfo, HttpServletRequest request) {
        int page =Integer.parseInt(request.getParameter("propage"));
        pageInfo.setPage(page);
        Page<ProductsEntity> products = productsEntityService.SearchProducts(pageInfo);
        map.put("page", products);
        return "admin/product/list";
    }

    /**
     * 根据pid修改商品
     * @param pid
     * @return
     */
    @RequestMapping(value = "/editProduct/{pid}")
    public ModelAndView editProduct(@PathVariable("pid") Integer pid) {
        ModelAndView modelAndView = new ModelAndView("admin/product/edit");
        List<CategorySecondEntity> categorySeconds = categorySecondEntityService.findAllCategorySecond();
        modelAndView.addObject("categorySeconds", categorySeconds);
        ProductsEntity product = productsEntityService.findByPid(pid);
        logger.info("通过pid查找到的商品{}",product);
        modelAndView.addObject("product", product);
        return modelAndView;
    }

    /**
     * 更新商品
     * @param product
     * @param upload
     * @param request
     * @param csid
     * @return
     */
    @RequestMapping(value = "/updateProduct")
    public ModelAndView updateProduct(@ModelAttribute("product") ProductsEntity product
            , @RequestParam("upload") CommonsMultipartFile upload, HttpServletRequest request, Integer csid) {
        ServletContext servletContext = request.getSession().getServletContext();
        ProductsEntity oldProduct = productsEntityService.findByPid(product.getPid());
        logger.info("通过pid查找商品{}",oldProduct);
        //开始截取图片名称
        int begin = oldProduct.getImage().lastIndexOf("/");
        String filename = oldProduct.getImage().substring(begin + 1, oldProduct.getImage().length());
        logger.info("截取到的图片名称{}",filename);

        //获取上传的图片名称
        String uploadFilename = upload.getOriginalFilename();
        logger.info("上传的图片名称{}",uploadFilename);

        if (filename != uploadFilename && !"".equals(uploadFilename)) {
            //文件保存路径
            String path = servletContext.getRealPath("/products/3");
            try {
                FileUtils.writeByteArrayToFile(new File(path, uploadFilename), upload.getBytes());
            } catch (IOException e) {
                e.printStackTrace();
            }
            product.setImage("products/3/" + uploadFilename);
            product.setPdate(new Date());
            path = request.getSession().getServletContext().getRealPath("/" + oldProduct.getImage());
            File file = new File(path);
            file.delete();
        } else {
            product.setPdate(new Date());
        }

        if (csid != null) {
            CategorySecondEntity categorySecond = categorySecondEntityService.findCategorySecond(csid);
            product.setCategorySecond(categorySecond);
            product.setCid(categorySecond.getCategory().getCid());
        }
        ActionResult res = productsEntityService.updateProduct(product);
        if (res.getCode() != 200){
            logger.info("更新失败");
        }

        ModelAndView modelAndView = new ModelAndView("redirect:/listProduct?propage=0");
        return modelAndView;
    }


    /**
     * 删除商品
     * @param pid
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteProduct/{pid}")
    public ModelAndView deleteProduct(@PathVariable("pid") Integer pid, HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.getAttribute("admin");
        //获取该商品的对象
        ProductsEntity product = productsEntityService.findByPid(pid);
        //获取文件保存目录
        String path = request.getSession().getServletContext().getRealPath("/" + product.getImage());
        File file = new File(path);
        // 删除商品服务器上的图片:
        file.delete();
        //删除商品在数据库中的记录
        if(session == null){
            ModelAndView modelAndView = new ModelAndView("redirect:/adminlogin.html");
            return modelAndView;
        }

        productsEntityService.deleteProduct(product,1);
        ModelAndView modelAndView = new ModelAndView("redirect:/listProduct?propage=0");
        return modelAndView;
    }

    /**
     * 添加商品编辑页面
     * @return
     */
    @RequestMapping(value = "/gotoAddProduct")
    public ModelAndView gotoAddProduct() {
        ModelAndView modelAndView = new ModelAndView("admin/product/add");
        //查询所有二级分类的集合
        List<CategorySecondEntity> categorySeconds = categorySecondEntityService.findAllCategorySecond();
        modelAndView.addObject("categorySeconds", categorySeconds);
        return modelAndView;
    }

    /**
     * 保存商品
     * @param product
     * @param upload
     * @param request
     * @param csid
     * @return
     */
    @RequestMapping(value = "/addProduct", method = RequestMethod.POST)
    public ModelAndView addProduct(@ModelAttribute("product") ProductsEntity product,
                                   @RequestParam("upload") CommonsMultipartFile upload, HttpServletRequest request,
                                   Integer csid) {
        //获取文件保存目录
        ServletContext servletContext = request.getSession().getServletContext();
        String path = servletContext.getRealPath("/products/3");
        //获取文件的名称
        String filename = upload.getOriginalFilename();
        try {
            FileUtils.writeByteArrayToFile(new File(path, filename), upload.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
        //设置文件的路径
        product.setImage("products/3/" + filename);
        //设置上传的时间
        product.setPdate(new Date());
        //该商品所属的二级分类
        CategorySecondEntity categorySecond = categorySecondEntityService.findCategorySecond(csid);
        product.setCategorySecond(categorySecond);
        //根据二级分类查找一级分类
        product.setCid(categorySecond.getCategory().getCid());
        //保存商品
        productsEntityService.saveProduct(product);
        ModelAndView modelAndView = new ModelAndView("redirect:/listProduct?propage=0");
        return modelAndView;
    }

    /**
     * 根据二级分类分页显示商品
     * @param csid
     * @param map
     * @return
     */
    @RequestMapping(value = "findByCsid/{csid}")
    public String findByCsid(@PathVariable("csid") Integer csid ,ModelMap map , PageInfo pageInfo,HttpServletRequest request) {
        int page =Integer.parseInt(request.getParameter("cspage"));
        pageInfo.setPage(page);
        logger.info("开始查找根据二级分类查找商品并进行分页");
        Page<ProductsEntity> products = productsEntityService.findByCsid(csid,pageInfo);
        map.put("page", products);
        map.put("csid", csid);
        return "new_productList";
    }

    /**
     * 根据cid查询商品
     * @param cid
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/findByCid/{cid}")
    public String findByCid(@PathVariable("cid") Integer cid ,ModelMap map , PageInfo pageInfo,HttpServletRequest request) {

        int page =Integer.parseInt(request.getParameter("cpage"));
        pageInfo.setPage(page);
        logger.info("开始查找根据一级分类查找商品并进行分页");
        Page<ProductsEntity> products = productsEntityService.findByCid(cid,pageInfo);
        map.put("page", products);
        map.put("cid", cid);
        return "new_productList";
    }

    /**
     * 根据pname模糊搜索
     * @param name
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/findByName")
    public String findByName(@RequestParam("proname")String name, ModelMap map , PageInfo pageInfo,HttpServletRequest request) {
        int page =Integer.parseInt(request.getParameter("npage"));
        pageInfo.setPage(page);
        logger.info("开始查找根据名字查找商品并进行分页");
        Page<ProductsEntity> products = productsEntityService.findByName(name,pageInfo);
        map.put("page", products);
        map.put("name",name);
        return "new_productList";
    }

    /**
     * 根据商品的pid查询商品
     * @param pid
     * @param map
     * @return
     */
    @RequestMapping(value = "findByPid/{pid}", method = RequestMethod.GET)
    public String findByPid(@PathVariable("pid") Integer pid, Map<String, Object> map) {

        ProductsEntity products = productsEntityService.findByPid(pid);
        map.put("product", products);

        CategorySecondEntity categorySecond = products.getCategorySecond();

        CategoryEntity category = categorySecond.getCategory();

        Date privilege = category.getPrivilegeTime();
        String privilegeTime = StringUtils.substring(privilege.toString(),0, 10);
        map.put("privilegeTime", privilegeTime);
        return "new_product";
    }

    /**
     * 根据pname模糊搜索
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/findByName1")
    public String findByName1(ModelMap map , PageInfo pageInfo,HttpServletRequest request) throws UnsupportedEncodingException {
        String proname = request.getParameter("proname");
        proname = new String(proname.getBytes("ISO8859-1"), "UTF-8");
        int page =Integer.parseInt(request.getParameter("npage"));
        pageInfo.setPage(page);
        logger.info("开始查找根据名字查找商品并进行分页");
        Page<ProductsEntity> products = productsEntityService.findByName(proname,pageInfo);
        map.put("page", products);
        map.put("name",proname);
        return "new_productList";
    }


    /**
     * 根据商品id，商品名字，二级分类查找商品并分页
     * @param map
     * @param pageInfo
     * @param request
     * @return
     */
    @RequestMapping(value = "/findByPidAndPnameAndCsname")
    public String findByPidAndPnameAndCsname(ModelMap map , PageInfo pageInfo,HttpServletRequest request) throws UnsupportedEncodingException {
        String pname = request.getParameter("pname");
        String csname = request.getParameter("csname");
        int page =Integer.parseInt(request.getParameter("ppcpage"));
        String strPid = request.getParameter("pid");
        Integer pid =null ;
        if(StringUtils.isNotBlank(strPid)){
             pid = Integer.parseInt(strPid);
        }

        pageInfo.setPage(page);
        logger.info("开始查找根据名字查找商品并进行分页");
        Page<ProductsEntity> products = productsEntityService.findByPidAndPnameAndCsname(pid,pname,csname,pageInfo);
        map.put("page", products);
        return "admin/product/list";
    }
}
