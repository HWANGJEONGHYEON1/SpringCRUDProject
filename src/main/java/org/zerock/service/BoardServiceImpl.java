package org.zerock.service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import java.util.List;

@Log4j
@Service

public class BoardServiceImpl implements BoardService{

    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Setter(onMethod_ = @Autowired)
    private BoardAttachMapper attachMapper;

    @Transactional
    @Override
    public void register(BoardVO board) {
        log.info(" #Service , register " + board);
        mapper.insertSelectKey(board);

        if(board.getAttachList() == null || board.getAttachList().size() <= 0){
            return;
        }
        log.info("# getbno : " + board.getBno());
        board.getAttachList().forEach(attach -> {
            attach.setBno(board.getBno());
            log.info(attach);
            attachMapper.insert(attach);
        });
    }

    @Override
    public BoardVO get(Long bno) {
        log.info(" #Service, bno : " + bno);
        return mapper.read(bno);
    }

    @Override
    public boolean modify(BoardVO board) {
        log.info(" #Service, modify : " + board);
        return mapper.update(board) == 1;
    }

    @Transactional
    @Override
    public boolean remove(Long bno) {
        log.info(" #Service, remove");
        attachMapper.deleteAll(bno);
        return mapper.delete(bno) == 1;
    }

    @Override
    public List<BoardVO> getList(Criteria cri) {
//        log.info(" #Service, getList ");
//        return mapper.getList();
        log.info("# service, getList with criteria : " + cri );
        return mapper.getListWithPaging(cri);
    }

    @Override
    public int getTotal(Criteria cri) {
        log.info(" Service, getTotalCount " + cri);
        return mapper.getTotalCount(cri);
    }

    @Override
    public List<BoardAttachVO> getAttachList(Long bno) {
        log.info(" boardService, get Attach list by bno" + bno);
        return attachMapper.findByBno(bno);
    }


}
