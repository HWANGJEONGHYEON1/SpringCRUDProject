package org.zerock.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {
    private int replyCnt;
    private List<ReplyVO> list;
}
