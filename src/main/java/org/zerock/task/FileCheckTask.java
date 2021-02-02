package org.zerock.task;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardAttachMapper;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Log4j
@Component
public class FileCheckTask {

    static final String uploadFolder = "/Users/hwangjeonghyeon/IdeaProjects/upload/";

    @Setter(onMethod_ = @Autowired)
    private BoardAttachMapper mapper;

    @Scheduled(cron = "0 * * * 1 * ")
    public void checkFile() throws Exception {
        log.warn("File check Task Run ........");
        log.warn(new Date());
        log.warn("===========================");

        List<BoardAttachVO> fileList = mapper.getOldFiles();

        List<Path> fileListPaths = fileList.stream()
                .map(vo -> Paths.get(uploadFolder, vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName())).
                        collect(Collectors.toList());

        fileList.stream().filter(vo -> vo.isFileType() == true)
                .map(vo -> Paths.get(uploadFolder, vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
                .forEach(p -> fileListPaths.add(p));

        log.warn("========================");

        fileListPaths.forEach(p -> log.warn(p));

        File targetDir = Paths.get(uploadFolder, getFolderYesterDay()).toFile();

        File removeFiles[] = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);

        log.warn("------------------------");

        for(File file : removeFiles) {
            log.warn(file.getAbsolutePath());
            file.delete();
        }
    }

    private String getFolderYesterDay() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-cd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);

        String str = sdf.format(cal.getTime());

        return str.replace("-", File.separator);
    }



}
