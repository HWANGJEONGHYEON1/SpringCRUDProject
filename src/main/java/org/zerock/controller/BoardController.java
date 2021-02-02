package org.zerock.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Pre;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import java.awt.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

    static final String uploadFolder = "/Users/hwangjeonghyeon/IdeaProjects/upload/";

    private BoardService service;

    @GetMapping("/list")
    public void list(Criteria cri, Model model){
        log.info("list");
        int total = service.getTotal(cri);
        model.addAttribute("list", service.getList(cri));
        model.addAttribute("pageMaker", new PageDTO(cri,total));
    }

    @GetMapping("/register")
    public void register() {
        log.info(" #Controller, register ");

//        service.register(board);
//
//        rttr.addAttribute("result", board.getBno());
//
//        return "redirect:/board/list";
    }

    @PostMapping("/register")
    @PreAuthorize("isAuthenticated()")
    public String register(BoardVO board, RedirectAttributes rttr) {
        log.info(" #Controller, register " + board);

        if(board.getAttachList() != null ){
            board.getAttachList().forEach(attach -> log.info(attach));
        }
        service.register(board);
        rttr.addAttribute("result", board.getBno());

        return "redirect:/board/list";
    }

    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri,
                    Model model){
        log.info(" #Controller, get " + bno);
        log.info(" #Controller, cri " + cri);
        model.addAttribute("board", service.get(bno));
    }

    @PreAuthorize("principal.username == #writer")
    @PostMapping("/modify")
    public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri ,RedirectAttributes rttr) {
        log.info(" #Controller, modify " + board);
        if(service.modify(board)) {
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/board/list" + cri.getListLink();
    }

    @PreAuthorize("principal.username == #writer")
    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri ,RedirectAttributes rttr, String writer){
        log.info(" #Controller, remove " + bno);

        List<BoardAttachVO> attachList = service.getAttachList(bno);


        if(service.remove(bno)) {

            deleteFiles(attachList);

            rttr.addFlashAttribute("result", "success");

        }


        return "redirect:/board/list" + cri.getListLink();
    }

    @GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
        log.info(" BoardController, getAttach bno" + bno);
        return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
    }

    private void deleteFiles(List<BoardAttachVO> attachList){
        if(attachList == null || attachList.size() ==0){
            return ;
        }

        log.info("delete attach files .....");
        log.info(attachList);

        attachList.forEach(attach -> {
            try {
                Path file = Paths.get(uploadFolder + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());

                Files.deleteIfExists(file);

                if(Files.probeContentType(file).startsWith("imagef")){
                    Path thumbNail = Paths.get(uploadFolder + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
                    Files.delete(thumbNail);
                }
            } catch (Exception e) {
                log.error("delete File error"+e.getMessage());
            }


        });
    }


}
