package com.donaciones.controller;

import com.donaciones.dao.CampaniaDAO;
import com.donaciones.dao.DonacionDAO;
import com.donaciones.dao.DonanteDAO;
import com.donaciones.model.Campania;
import com.donaciones.model.Donacion;
import com.donaciones.model.Donante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@WebServlet(name = "DonacionServlet", urlPatterns = {"/donaciones"})

public class DonacionServlet extends HttpServlet {

    private static final int PAGE_SIZE = 8;
    private final DonacionDAO donacionDAO = new DonacionDAO();
    private final DonanteDAO donanteDAO = new DonanteDAO(); // Para poblar el dropdown de donantes
    private final CampaniaDAO campaniaDAO = new CampaniaDAO(); // Para poblar el dropdown de campañas

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {
            case "listar":
                List<Donacion> lista = donacionDAO.listar();
                String busqueda = normalizar(request.getParameter("q"));
                List<Donacion> filtrada = filtrarDonaciones(lista, busqueda);
                int pagina = parsePagina(request.getParameter("page"));
                int totalRegistros = filtrada.size();
                int totalPaginas = Math.max(1, (int) Math.ceil((double) totalRegistros / PAGE_SIZE));
                if (pagina > totalPaginas) pagina = totalPaginas;
                int desde = Math.max(0, (pagina - 1) * PAGE_SIZE);
                int hasta = Math.min(desde + PAGE_SIZE, totalRegistros);
                List<Donacion> paginaDatos = filtrada.subList(desde, hasta);

                request.setAttribute("donaciones", paginaDatos);
                request.setAttribute("q", busqueda);
                request.setAttribute("page", pagina);
                request.setAttribute("totalPaginas", totalPaginas);
                request.setAttribute("totalRegistros", totalRegistros);
                request.setAttribute("desdeRegistro", totalRegistros == 0 ? 0 : desde + 1);
                request.setAttribute("hastaRegistro", hasta);
                request.getRequestDispatcher("/views/donacion/listar.jsp")
                       .forward(request, response);
                break;

            case "nuevo":
                // Necesitamos donantes y campañas para el formulario
                List<Donante> donantes = donanteDAO.listar();
                List<Campania> campanias = campaniaDAO.listar();
                request.setAttribute("donantes", donantes);
                request.setAttribute("campanias", campanias);
                request.getRequestDispatcher("/views/donacion/form.jsp")
                       .forward(request, response);
                break;

            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                Donacion donacion = donacionDAO.obtener(id);
                // Necesitamos donantes y campañas para el formulario
                List<Donante> donantesEditar = donanteDAO.listar();
                List<Campania> campaniasEditar = campaniaDAO.listar();
                request.setAttribute("donacion", donacion);
                request.setAttribute("donantes", donantesEditar);
                request.setAttribute("campanias", campaniasEditar);
                request.getRequestDispatcher("/views/donacion/form.jsp")
                       .forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                donacionDAO.eliminar(idEliminar);
                request.getSession().setAttribute("mensaje", "Donación eliminada exitosamente.");
                request.getSession().setAttribute("tipoMensaje", "success");
                response.sendRedirect(request.getContextPath() + "/donaciones");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/donaciones");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id_donacion");
        String idDonanteParam = request.getParameter("id_donante");
        String idCampaniaParam = request.getParameter("id_campania");
        String tipoDonacion = request.getParameter("tipo_donacion");
        String estadoDonacion = request.getParameter("estado_donacion");
        String fechaDonacionParam = request.getParameter("fecha_donacion");
        String montoParam = request.getParameter("monto");
        String descripcion = request.getParameter("descripcion");

        // --- Server-side validation ---
        boolean isValid = true;
        StringBuilder errorMessage = new StringBuilder();

        if (idDonanteParam == null || idDonanteParam.trim().isEmpty()) {
            errorMessage.append("El donante es obligatorio.<br/>");
            isValid = false;
        } else {
            try {
                int idDonante = Integer.parseInt(idDonanteParam);
                if (idDonante <= 0) {
                    errorMessage.append("ID de donante inválido.<br/>");
                    isValid = false;
                }
            } catch (NumberFormatException e) {
                errorMessage.append("ID de donante debe ser un número válido.<br/>");
                isValid = false;
            }
        }
        
        if (idCampaniaParam != null && !idCampaniaParam.trim().isEmpty()) {
            try {
                int idCampania = Integer.parseInt(idCampaniaParam);
                if (idCampania <= 0) {
                    errorMessage.append("ID de campaña inválido.<br/>");
                    isValid = false;
                }
            } catch (NumberFormatException e) {
                errorMessage.append("ID de campaña debe ser un número válido.<br/>");
                isValid = false;
            }
        }


        if (tipoDonacion == null || tipoDonacion.trim().isEmpty()) {
            errorMessage.append("El tipo de donación es obligatorio.<br/>");
            isValid = false;
        }
        if (estadoDonacion == null || estadoDonacion.trim().isEmpty()) {
            errorMessage.append("El estado de la donación es obligatorio.<br/>");
            isValid = false;
        }
        if (fechaDonacionParam == null || fechaDonacionParam.trim().isEmpty()) {
            errorMessage.append("La fecha de donación es obligatoria.<br/>");
            isValid = false;
        }
        if (montoParam == null || montoParam.trim().isEmpty()) {
            errorMessage.append("El monto es obligatorio.<br/>");
            isValid = false;
        } else {
            try {
                BigDecimal monto = new BigDecimal(montoParam);
                if (monto.compareTo(BigDecimal.ZERO) <= 0) {
                    errorMessage.append("El monto debe ser un valor positivo.<br/>");
                    isValid = false;
                }
            } catch (NumberFormatException e) {
                errorMessage.append("El monto debe ser un número válido.<br/>");
                isValid = false;
            }
        }
        

        if (!isValid) {
            request.getSession().setAttribute("mensaje", errorMessage.toString());
            request.getSession().setAttribute("tipoMensaje", "error");
            
            // Re-populate form fields and dropdowns
            Donacion donacion = new Donacion();
            if (idParam != null && !idParam.isEmpty()) {
                donacion.setId_donacion(Integer.parseInt(idParam));
            }
            try { donacion.setId_donante(Integer.parseInt(idDonanteParam)); } catch (NumberFormatException e) {}
            if (idCampaniaParam != null && !idCampaniaParam.trim().isEmpty()) {
                try { donacion.setId_campania(Integer.parseInt(idCampaniaParam)); } catch (NumberFormatException e) {}
            }
            donacion.setTipo_donacion(tipoDonacion);
            donacion.setEstado_donacion(estadoDonacion);
            try { donacion.setFecha_donacion(Date.valueOf(fechaDonacionParam)); } catch (IllegalArgumentException e) {}
            try { donacion.setMonto(new BigDecimal(montoParam)); } catch (NumberFormatException e) {}
            donacion.setDescripcion(descripcion);
            
            request.setAttribute("donacion", donacion);
            request.setAttribute("donantes", donanteDAO.listar());
            request.setAttribute("campanias", campaniaDAO.listar());
            request.getRequestDispatcher("/views/donacion/form.jsp").forward(request, response);
            return;
        }

        // --- Data assignment and robust parsing ---
        Donacion donacion = new Donacion();
        if (idParam != null && !idParam.isEmpty()) {
            donacion.setId_donacion(Integer.parseInt(idParam));
        }
        donacion.setId_donante(Integer.parseInt(idDonanteParam));
        if (idCampaniaParam != null && !idCampaniaParam.trim().isEmpty()) {
            donacion.setId_campania(Integer.parseInt(idCampaniaParam));
        } else {
            donacion.setId_campania(null); // Asegurar que es null si no se selecciona
        }
        donacion.setTipo_donacion(tipoDonacion);
        donacion.setEstado_donacion(estadoDonacion);
        donacion.setFecha_donacion(Date.valueOf(fechaDonacionParam));
        donacion.setMonto(new BigDecimal(montoParam));
        donacion.setDescripcion(descripcion);

        // --- DAO operation and feedback ---
        boolean success;
        if (idParam == null || idParam.isEmpty()) {
            success = donacionDAO.insertar(donacion);
            if (success) {
                request.getSession().setAttribute("mensaje", "Donación registrada exitosamente.");
                request.getSession().setAttribute("tipoMensaje", "success");
            } else {
                request.getSession().setAttribute("mensaje", "Error al registrar la donación.");
                request.getSession().setAttribute("tipoMensaje", "error");
            }
        } else {
            success = donacionDAO.actualizar(donacion);
            if (success) {
                request.getSession().setAttribute("mensaje", "Donación actualizada exitosamente.");
                request.getSession().setAttribute("tipoMensaje", "success");
            } else {
                request.getSession().setAttribute("mensaje", "Error al actualizar la donación.");
                request.getSession().setAttribute("tipoMensaje", "error");
            }
        }

        response.sendRedirect(request.getContextPath() + "/donaciones");
    }

    private List<Donacion> filtrarDonaciones(List<Donacion> origen, String q) {
        if (q == null || q.isBlank()) {
            return origen;
        }

        String criterio = q.toLowerCase(Locale.ROOT);
        List<Donacion> filtrada = new ArrayList<>();
        for (Donacion d : origen) {
            String texto = (d.getId_donacion() + " " + d.getNombreDonante() + " " + d.getNombreCampania() + " "
                    + d.getTipo_donacion() + " " + d.getEstado_donacion() + " " + d.getDescripcion())
                    .toLowerCase(Locale.ROOT);
            if (texto.contains(criterio)) {
                filtrada.add(d);
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
