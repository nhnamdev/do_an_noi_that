package vn.edu.hcmuaf.fit.sourcedoannoithat.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthorizationFilter implements Filter {

    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();
        Integer role = (session != null) ? (Integer) session.getAttribute("role") : null;
        Integer active = (session != null) ? (Integer) session.getAttribute("active") : null;
        String contextPath = req.getContextPath();
        boolean isAllowedPage = uri.endsWith("blockedaccount.jsp")||uri.endsWith("/logout") ;

        if (!isAllowedPage && active != null && active == -1) {
            res.sendRedirect(contextPath + "/blockedaccount.jsp");
            return;
        }
        if (uri.endsWith("mod.jsp")) {
            if (role == null || role < 1) {
                res.sendRedirect(contextPath + "/index.jsp");
                return;
            }
        }

        if (uri.endsWith("admin.jsp")) {
            if (role == null || role < 2) {
                res.sendRedirect(contextPath + "/index.jsp");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
