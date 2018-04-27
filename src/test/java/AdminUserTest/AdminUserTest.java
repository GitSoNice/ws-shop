package AdminUserTest;

import com.ws.shop.entity.AdminEntity;
import com.ws.shop.entity.UserEntity;
import com.ws.shop.service.AdminEntityService;
import com.ws.shop.utils.ActionResult;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

//首先指定jUnit的Runner
@RunWith(SpringJUnit4ClassRunner.class)
//指明配置文件的所在
@ContextConfiguration(locations="classpath*:template-servlet-context.xml")
//指定事务管理器
@Transactional(value="transactionManager")
public class AdminUserTest {

    @Autowired
    AdminEntityService adminservice;

    /**
     * test for CheckAdminUser
     */
    @Test
    public void demo(){
        AdminEntity admin = new AdminEntity();
        admin.setUsername("admin");
        admin.setPassword("admin");
        AdminEntity a=adminservice.checkAdminUser(admin);
        System.out.println(a);
    }

    /**
     * test for SearchUser
     */
    @Test
    public void demo1(){
        UserEntity a=adminservice.SearchUser(1);
        System.out.println(a);
    }

    /**
     * test for SearchAdmin
     */
    @Test
    public void demo2(){
        AdminEntity a=adminservice.SearchAdmin(1);
        System.out.println(a);
    }

    /**
     * test for SearchAdmin
     */
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @Test
    @Rollback(false)
    public void demo3(){
        UserEntity user =new UserEntity();
        user.setUid(1);
        user.setName("gogoggo");
        user.setAddr("上海");
        user.setAge(35);
        user.setEmail("517359874@qq.com");
        user.setPassword("nimalapi");
        user.setPhone("123456789");
        user.setState(1);
        user.setUsername("Alex");
        ActionResult res = adminservice.updateUser(user);
        System.out.println(res.getCode());
    }
}
