package OrdersTest;


import com.ws.shop.service.OrderEntityService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

//首先指定jUnit的Runner
@RunWith(SpringJUnit4ClassRunner.class)
//指明配置文件的所在
@ContextConfiguration(locations="classpath*:template-servlet-context.xml")
//指定事务管理器
@Transactional(value="transactionManager")
public class OrderTest {

    @Autowired
    OrderEntityService orderEntityService;

    /**
     * test for
     */
    @Test
    public void demo(){

    }
}
