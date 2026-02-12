package com.donaciones.controller;

import com.donaciones.dao.UsuarioSistemaDAO;
import com.donaciones.model.UsuarioSistema;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login", "/logout"})
public class LoginServlet extends HttpServlet {

    private static final int SESSION_TIMEOUT_SECONDS = 20 * 60;
    private final UsuarioSistemaDAO usuarioDAO = new UsuarioSistemaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String servletPath = request.getServletPath();
        if ("/logout".equals(servletPath)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login?logout=1");
            return;
        }

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuarioLogueado") != null) {
            response.sendRedirect(request.getContextPath() + "/inicio");
            return;
        }

        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        if (usuario == null || usuario.trim().isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorLogin", "Debe ingresar usuario y contrasena.");
            request.setAttribute("usuarioIngresado", usuario);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        UsuarioSistema autenticado = usuarioDAO.autenticar(usuario.trim(), password);
        if (autenticado == null) {
            request.setAttribute("errorLogin", "Credenciales invalidas.");
            request.setAttribute("usuarioIngresado", usuario);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("usuarioLogueado", autenticado);
        session.setMaxInactiveInterval(SESSION_TIMEOUT_SECONDS);

        response.sendRedirect(request.getContextPath() + "/inicio");
    }
}
