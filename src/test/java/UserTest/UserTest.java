package UserTest;

import com.ws.shop.entity.UserEntity;
import com.ws.shop.service.UserEntityService;
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
public class UserTest {

    @Autowired
    UserEntityService userEntityService;

    /**
     * test for existUser
     */
    @Test
    public void demo(){
        UserEntity userEntity =userEntityService.existUser("Alex");
        System.out.println(userEntity);
    }

    /**
     * test for findUserByUsernameAndPassword
     */
    @Test
    public void demo1(){
        UserEntity user = new UserEntity();
        user.setUsername("Alex");
        user.setPassword("nimalapi");
        UserEntity userEntity =userEntityService.findUserByUsernameAndPassword(user);
        System.out.println(userEntity);
    }

    /**
     * test for findByUid
     */
    @Test
    public void demo2(){
        UserEntity userEntity =userEntityService.findByUid(1);
        System.out.println(userEntity);
    }

    /**
     * test for update
     */
    @Test
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @Rollback(false)
    public void demo3(){
        UserEntity user =new UserEntity();
        user=userEntityService.findByUid(1);
        user.setPassword("111222333");
        user.setUsername("qazwsx");
        ActionResult res=userEntityService.update(user);
        System.out.println(res.getCode());
    }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @Test
    @Rollback(false)
    public void demo4(){
        UserEntity user =new UserEntity();
        user.setName("bobo");
        user.setAddr("杭州");
        user.setAge(18);
        user.setEmail("672623681@qq.com");
        user.setPassword("!QAZ2wsx");
        user.setPhone("114");
        user.setUsername("666");
        ActionResult res =userEntityService.register(user);
        System.out.println(res.getCode());
    }
}
