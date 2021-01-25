package org.zerock.aop;


import lombok.extern.log4j.Log4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Aspect
@Log4j
@Component
public class LogAdvice {

//    @Before("execution(* org.zerock.service.BoardService*.*(..))")
//    public void logBefore() {
//        log.info(" ===================== ");
//    }

    @Before("execution(* org.zerock.service.BoardService*.get(Long)) && args(bno)")
    public void logRegister(Long bno) {
        log.info(" ===================== " + bno);
    }

    @AfterThrowing(pointcut = "execution(* org.zerock.service.BoardService*.*(..))", throwing = "exception")
    public void logException(Exception exception){
        log.info("Exception");
        log.info("ex - " + exception);
    }


    @Around("execution(* org.zerock.service.BoardService*.*(..))")
    public Object logTime(ProceedingJoinPoint pjp){
        long start = System.currentTimeMillis();

        log.info("Target : " + pjp.getTarget());
        log.info("Param : " + Arrays.toString(pjp.getArgs()));

        Object result = null;

        try {
            result = pjp.proceed();
        } catch (Throwable e ){
            e.printStackTrace();
        }

        long end = System.currentTimeMillis();

        log.info("TIME : " + (end - start));

        return result;
    }
}
