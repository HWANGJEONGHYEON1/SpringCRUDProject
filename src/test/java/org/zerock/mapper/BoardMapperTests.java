package org.zerock.mapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {

    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Test
    public void selectBoard() {
        mapper.getList().forEach(board -> log.info(board));
    }

    @Test
    public void createBoardInsert() {
        BoardVO board = new BoardVO();
        board.setTitle("새로 작성한 테스트 글");
        board.setContent("새로 작성한 테스트 내용");
        board.setWriter("새로 작성한 테스트 작성자");

        mapper.insert(board);
        log.info(board);
    }

    @Test
    public void createBoardInsertSelectKey(){
        BoardVO board = new BoardVO();

        board.setTitle("새로 작성한 테스트 글 1");
        board.setContent("새로 작성한 테스트 내용 2");
        board.setWriter("새로 작성한 테스트 작성자 3");

        mapper.insertSelectKey(board);
        log.info(board);
    }

    @Test
    public void testRead() {
        BoardVO board = mapper.read(9L);
        log.info(board);
    }

    @Test
    public void testDelete(){

        log.info(" # DELETE COUNT " + mapper.delete(3L));
    }

    @Test
    public void testUpdate() {
        BoardVO board = new BoardVO();
        board.setTitle("카카오 개발자");
        board.setContent("카카오 개발자가 되기 위한 내용");
        board.setWriter("쥬니어 개발자");

        board.setBno(5L);
        int count = mapper.update(board);
        log.info("# update : " + count);
    }

    @Test
    public void testPaging() {
        Criteria cri = new Criteria();
        cri.setPageNum(3);
        cri.setAmount(10);
        List<BoardVO> list = mapper.getListWithPaging(cri);
        list.forEach(board -> log.info(board.getBno()));
    }

    @Test
    public void testSearch(){
        Criteria cri = new Criteria();
        cri.setKeyword("개발자");
        cri.setType("TC");

        List<BoardVO> vo = mapper.getListWithPaging(cri);
        vo.forEach(board -> log.info(board));
    }

}
