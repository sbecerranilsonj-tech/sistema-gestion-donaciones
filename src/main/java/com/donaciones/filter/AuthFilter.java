package com.donaciones.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
        // Sin inicializacion requerida
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String contextPath = req.getContextPath();
        String path = req.getRequestURI().substring(contextPath.length());

        boolean esPublico = path.startsWith("/login")
                || path.startsWith("/logout")
                || path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/images/")
                || path.endsWith(".css")
                || path.endsWith(".js")
                || path.endsWith(".png")
                || path.endsWith(".jpg")
                || path.endsWith(".jpeg")
                || path.endsWith(".gif")
                || path.endsWith(".ico")
                || path.endsWith(".svg");

        HttpSession session = req.getSession(false);
        boolean autenticado = session != null && session.getAttribute("usuarioLogueado") != null;

        if (autenticado && ("/login".equals(path) || "/".equals(path) || "/index.jsp".equals(path))) {
            res.sendRedirect(contextPath + "/inicio");
            return;
        }

        if (!autenticado && !esPublico) {
            boolean sesionExpirada = req.getRequestedSessionId() != null && !req.isRequestedSessionIdValid();
            if (sesionExpirada) {
                res.sendRedirect(contextPath + "/login?expirada=1");
            } else {
                res.sendRedirect(contextPath + "/login");
            }
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Sin destruccion requerida
    }
}
