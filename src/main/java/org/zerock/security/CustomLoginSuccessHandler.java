package org.zerock.security;

import lombok.extern.log4j.Log4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        log.warn("Login Success");

        List<String> roleNames = new ArrayList<>();

        authentication.getAuthorities().forEach( auth -> {
            roleNames.add(auth.getAuthority());
        });

        log.warn("Role Name : " + roleNames);

        if(roleNames.contains("ROLE_ADMIN")) {
            log.info("## ADMIN");
            response.sendRedirect("/mem/admin");
            return ;
        }

        if(roleNames.contains("ROLE_MEMBER")) {
            log.info("## MEMBER");
            response.sendRedirect("/mem/member");
            return ;
        }

        response.sendRedirect("/board/list");
    }
}
