package com.donaciones.controller;

import com.donaciones.dao.CampaniaDAO;
import com.donaciones.model.Campania;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@WebServlet(name = "CampaniaServlet", urlPatterns = {"/campanias"})

public class CampaniaServlet extends HttpServlet {

    private static final int PAGE_SIZE = 8;
    private final CampaniaDAO dao = new CampaniaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "listar":
                List<Campania> lista = dao.listar();
                String busqueda = normalizar(request.getParameter("q"));
                List<Campania> filtrada = filtrarCampanias(lista, busqueda);
                int pagina = parsePagina(request.getParameter("page"));
                int totalRegistros = filtrada.size();
                int totalPaginas = Math.max(1, (int) Math.ceil((double) totalRegistros / PAGE_SIZE));
                if (pagina > totalPaginas) pagina = totalPaginas;
                int desde = Math.max(0, (pagina - 1) * PAGE_SIZE);
                int hasta = Math.min(desde + PAGE_SIZE, totalRegistros);
                List<Campania> paginaDatos = filtrada.subList(desde, hasta);

                request.setAttribute("campanias", paginaDatos);
                request.setAttribute("q", busqueda);
                request.setAttribute("page", pagina);
                request.setAttribute("totalPaginas", totalPaginas);
                request.setAttribute("totalRegistros", totalRegistros);
                request.setAttribute("desdeRegistro", totalRegistros == 0 ? 0 : desde + 1);
                request.setAttribute("hastaRegistro", hasta);
                request.getRequestDispatcher("/views/campania/listar.jsp")
                       .forward(request, response);
                break;

            case "nuevo":
                request.getRequestDispatcher("/views/campania/form.jsp")
                       .forward(request, response);
                break;

            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                Campania c = dao.obtener(id);
                request.setAttribute("campania", c);
                request.getRequestDispatcher("/views/campania/form.jsp")
                       .forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(idEliminar);
                response.sendRedirect(request.getContextPath() + "/campanias");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/campanias");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id_campania");

        Campania c = new Campania();
        c.setNombre(request.getParameter("nombre"));
        c.setDescripcion(request.getParameter("descripcion"));
        c.setFecha_inicio(Date.valueOf(request.getParameter("fecha_inicio")));
        c.setFecha_fin(Date.valueOf(request.getParameter("fecha_fin")));
        c.setEstado(request.getParameter("estado"));

        if (id == null || id.isEmpty()) {
            dao.insertar(c);
        } else {
            c.setId_campania(Integer.parseInt(id));
            dao.actualizar(c);
        }

        response.sendRedirect(request.getContextPath() + "/campanias");
    }

    private List<Campania> filtrarCampanias(List<Campania> origen, String q) {
        if (q == null || q.isBlank()) {
            return origen;
        }

        String criterio = q.toLowerCase(Locale.ROOT);
        List<Campania> filtrada = new ArrayList<>();
        for (Campania c : origen) {
            String texto = (c.getNombre() + " " + c.getDescripcion() + " " + c.getEstado() + " " + c.getId_campania())
                    .toLowerCase(Locale.ROOT);
            if (texto.contains(criterio)) {
                filtrada.add(c);
            }
        }
        return filtrada;
    }

    private String normalizar(String valor) {
        return valor == null ? "" : valor.trim();
    }

    private int parsePagina(String pageParam) {
        try {
            int page = Integer.parseInt(pageParam);
            return Math.max(page, 1);
        } catch (Exception e) {
            return 1;
        }
    }
}
