package org.sample.controller;

import lombok.extern.log4j.Log4j;
import org.sample.domain.TicketVO;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.sample.domain.SampleVO;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@RestController
@Log4j
@RequestMapping("/sample")
public class SampleController {

    @GetMapping(value = "/getText", produces = "text/plains; charset=utf-8")
    public String getText() {

        log.info("MIME TYPE " + MediaType.TEXT_PLAIN_VALUE);
        return "안녕하세요";
    }

    @GetMapping(value = "/getSample", produces = {
            MediaType.APPLICATION_JSON_UTF8_VALUE,
            MediaType.APPLICATION_XML_VALUE
    })
    public SampleVO getSample() {
        return new SampleVO(112, "스타 ", "로드");
    }

    @GetMapping(value = "/getSample2")
    public SampleVO getSample2() {
        return new SampleVO(113, "로켓", "라쿤");
    }

    @GetMapping(value = "/getList")
    public List<SampleVO> getList() {
        return IntStream.range(1, 10).mapToObj(i -> new SampleVO(i, i + " First", i + " Liast")).collect(Collectors.toList());
    }

    @GetMapping("/product/{cat}/{pid}")
    public String[] getPath(
            @PathVariable("cat") String cat, @PathVariable("pid") String pid
    ){
        return new String[] { "category : " + cat , " productId " + pid};
    }

    @PostMapping("/ticket")
    public TicketVO convert(@RequestBody TicketVO ticket){
        log.info("convert " + ticket);
        return ticket;
    }

}
