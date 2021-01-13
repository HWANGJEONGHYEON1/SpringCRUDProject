package org.zerock.persistence;

import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringRunner;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@Log4j
public class JDBCTests {
    static{
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    @Test
    public void testConnection(){

        try(Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:49161:XE",
                "system",
                "123")){
            log.info(con);

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
