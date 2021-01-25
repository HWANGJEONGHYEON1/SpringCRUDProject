package org.zerock.service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

import static org.junit.Assert.assertNotNull;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardServiceTest {

    @Setter(onMethod_ = @Autowired)
    private BoardService service;

    @Test
    public void testExsist() {
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testRegister() {
        BoardVO boardVO = new BoardVO();
        boardVO.setTitle("새로 작성한 글");
        boardVO.setContent("새로 작성한 내용");
        boardVO.setWriter("새로 작성한 작성자");

        service.register(boardVO);
    }


    @Test
    public void testGet() {
        log.info(service.get(10000000000000L));
    }

    @Test
    public void testModify() {
        BoardVO board = new BoardVO();
        board.setBno(3L);
        board.setTitle("new bie title");
        board.setContent("new bie content");
        board.setWriter("new bie");

        log.info(service.modify(board));
    }

    @Test
    public void testDelete() {
        log.info(service.remove(3L));
    }

    @Test
    public void testListPaging() throws Exception {
    }


}
