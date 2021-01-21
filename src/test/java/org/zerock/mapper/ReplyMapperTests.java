package org.zerock.mapper;


import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import java.util.List;
import java.util.stream.IntStream;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

    private Long[] bnoArr = {458750L, 458749L, 458748L, 458747L, 458746L};

    @Setter(onMethod_ = @Autowired)
    private ReplyMapper mapper;

    @Test
    public void testMapper() {
        log.info(mapper);
    }

    @Test
    public void testInsert() {
        IntStream.rangeClosed(1,10).forEach(i -> {
            ReplyVO vo = new ReplyVO();

            vo.setBno(bnoArr[i % 5]);
            vo.setReply("댓글 테스트 " + i);
            vo.setReplyer("replyer " + i);
            mapper.insert(vo);
        });
    }

    @Test
    public void testGet(){

        Long rno = 124L;

        ReplyVO vo = mapper.read(rno);

        log.info(vo);
    }

    @Test
    public void testDelete() {
        Long targetRno = 121L;
        mapper.delete(targetRno);
    }

    @Test
    public void testUpdate(){
        Long targetRno = 122L;

        ReplyVO vo = mapper.read(targetRno);

        vo.setReply("Update Reply");

        int count = mapper.update(vo);
        log.info("Update Count " + count);
    }

    @Test
    public void teetList() {
        Criteria cri = new Criteria();

        List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
        replies.forEach(reply -> log.info(reply));
    }

    @Test
    public void teetList2() {
        Criteria cri = new Criteria(2, 10);

        List<ReplyVO> replies = mapper.getListWithPaging(cri, 458761L);
        replies.forEach(reply -> log.info(reply));
    }
}
