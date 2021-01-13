package org.zerock.persistence;

import lombok.Setter;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

import static org.junit.Assert.fail;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSourceTest {

    @Setter(onMethod_ = @Autowired)
    private DataSource ds;

    @Test
    public void testConnection() {
        try(Connection con = ds.getConnection()){
            log.info(con);
        } catch (SQLException e){
            fail(e.getMessage());
        }
    }
}
