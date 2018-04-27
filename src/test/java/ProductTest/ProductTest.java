package ProductTest;


import com.ws.shop.bean.PageInfo;
import com.ws.shop.service.ProductsEntityService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

//首先指定jUnit的Runner
@RunWith(SpringJUnit4ClassRunner.class)
//指明配置文件的所在
@ContextConfiguration(locations="classpath*:template-servlet-context.xml")
//指定事务管理器
@Transactional(value="transactionManager")
public class ProductTest {

    @Autowired
    ProductsEntityService productsEntityService;

    /**
     * test for
     */
    @Test
    public void demo(ModelMap modelMap, PageInfo pageInfo){
        Page page=productsEntityService.findByCid(1, pageInfo);
        modelMap.put("page",page);

    }
}
