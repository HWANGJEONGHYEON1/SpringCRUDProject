package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;
import org.zerock.domain.BoardVO;

import java.util.List;

public interface BoardMapper {

    //@Select("Select * from tbl_board where bno > 0")
    public List<BoardVO> getList();
    
}
