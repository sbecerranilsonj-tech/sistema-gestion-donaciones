package com.donaciones.controller;

import com.donaciones.dao.DonanteDAO;
import com.donaciones.dao.PaisDAO;
import com.donaciones.model.Donante;
import com.donaciones.model.Pais;

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

@WebServlet(name = "DonanteServlet", urlPatterns = {"/donantes"})

public class DonanteServlet extends HttpServlet {

    private static final int PAGE_SIZE = 8;
    private final DonanteDAO dao = new DonanteDAO();
    private final PaisDAO paisDAO = new PaisDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        switch (accion) {

            case "listar":
                List<Donante> lista = dao.listar();
                String busqueda = normalizar(request.getParameter("q"));
                List<Donante> filtrada = filtrarDonantes(lista, busqueda);
                int pagina = parsePagina(request.getParameter("page"));
                int totalRegistros = filtrada.size();
                int totalPaginas = Math.max(1, (int) Math.ceil((double) totalRegistros / PAGE_SIZE));
                if (pagina > totalPaginas) pagina = totalPaginas;
                int desde = Math.max(0, (pagina - 1) * PAGE_SIZE);
                int hasta = Math.min(desde + PAGE_SIZE, totalRegistros);
                List<Donante> paginaDatos = filtrada.subList(desde, hasta);

                request.setAttribute("donantes", paginaDatos);
                request.setAttribute("q", busqueda);
                request.setAttribute("page", pagina);
                request.setAttribute("totalPaginas", totalPaginas);
                request.setAttribute("totalRegistros", totalRegistros);
                request.setAttribute("desdeRegistro", totalRegistros == 0 ? 0 : desde + 1);
                request.setAttribute("hastaRegistro", hasta);
                request.getRequestDispatcher("/views/donante/listar.jsp")
                       .forward(request, response);
                break;

            case "nuevo":
                List<Pais> paises = paisDAO.listar();
                request.setAttribute("paises", paises);
                request.getRequestDispatcher("/views/donante/form.jsp")
                       .forward(request, response);
                break;

            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                Donante d = dao.obtener(id);
                List<Pais> paisesEditar = paisDAO.listar();
                request.setAttribute("donante", d);
                request.setAttribute("paises", paisesEditar);
                request.getRequestDispatcher("/views/donante/form.jsp")
                       .forward(request, response);
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(idEliminar);
                response.sendRedirect(request.getContextPath() + "/donantes");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/donantes");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // Asegurar la codificación de caracteres

        String idParam = request.getParameter("idDonante");
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String tipoDonante = request.getParameter("tipoDonante");
        String idPaisParam = request.getParameter("idPais");
        String fechaRegistroParam = request.getParameter("fechaRegistro");

        // --- Server-side validation ---
        boolean isValid = true;
        StringBuilder errorMessage = new StringBuilder();

        if (nombre == null || nombre.trim().isEmpty()) {
            errorMessage.append("El nombre es obligatorio.<br/>");
            isValid = false;
        }
        if (tipoDonante == null || tipoDonante.trim().isEmpty()) {
            errorMessage.append("El tipo de donante es obligatorio.<br/>");
            isValid = false;
        }
        if (idPaisParam == null || idPaisParam.trim().isEmpty()) {
            errorMessage.append("El ID de país es obligatorio.<br/>");
            isValid = false;
        } else {
            try {
                int idPais = Integer.parseInt(idPaisParam);
                if (idPais <= 0) {
                    errorMessage.append("El ID de país debe ser un número positivo.<br/>");
                    isValid = false;
                }
            } catch (NumberFormatException e) {
                errorMessage.append("El ID de país debe ser un número válido.<br/>");
                isValid = false;
            }
        }
        if (fechaRegistroParam == null || fechaRegistroParam.trim().isEmpty()) {
            errorMessage.append("La fecha de registro es obligatoria.<br/>");
            isValid = false;
        }

        // Basic email validation
        if (email != null && !email.trim().isEmpty() && !email.contains("@")) {
            errorMessage.append("El formato del email no es válido.<br/>");
            isValid = false;
        }

        if (!isValid) {
            request.getSession().setAttribute("mensaje", errorMessage.toString());
            request.getSession().setAttribute("tipoMensaje", "error");
            
            // Re-populate form fields to avoid losing data
            Donante d = new Donante();
            if (idParam != null && !idParam.isEmpty()) {
                d.setIdDonante(Integer.parseInt(idParam));
            }
            d.setNombre(nombre);
            d.setEmail(email);
            d.setTelefono(telefono);
            d.setDireccion(direccion);
            d.setTipoDonante(tipoDonante);
            try { d.setIdPais(Integer.parseInt(idPaisParam)); } catch (NumberFormatException e) {}
            try { d.setFechaRegistro(Date.valueOf(fechaRegistroParam)); } catch (IllegalArgumentException e) {}
            
            request.setAttribute("donante", d); // Pass the donante object back to the form
            List<Pais> paisesError = paisDAO.listar(); // Re-fetch countries for the form
            request.setAttribute("paises", paisesError);
            request.getRequestDispatcher("/views/donante/form.jsp").forward(request, response);
            return;
        }

        // --- Data assignment and robust date parsing ---
        Donante d = new Donante();
        if (idParam != null && !idParam.isEmpty()) {
            d.setIdDonante(Integer.parseInt(idParam));
        }
        d.setNombre(nombre);
        d.setEmail(email);
        d.setTelefono(telefono);
        d.setDireccion(direccion);
        d.setTipoDonante(tipoDonante);
        d.setIdPais(Integer.parseInt(idPaisParam)); // Already validated
        
        Date fechaRegistro;
        try {
            fechaRegistro = Date.valueOf(fechaRegistroParam); // Already validated as not empty
            d.setFechaRegistro(fechaRegistro);
        } catch (IllegalArgumentException e) {
            // This should ideally not happen if client-side validation and server-side isEmpty check passed
            request.getSession().setAttribute("mensaje", "Error interno: Formato de fecha inválido.");
            request.getSession().setAttribute("tipoMensaje", "error");
            request.getRequestDispatcher("/views/donante/form.jsp").forward(request, response);
            return;
        }

        // --- DAO operation and feedback ---
        boolean success;
        if (idParam == null || idParam.isEmpty()) {
            success = dao.insertar(d);
            if (success) {
                request.getSession().setAttribute("mensaje", "Donante registrado exitosamente.");
                request.getSession().setAttribute("tipoMensaje", "success");
            } else {
                request.getSession().setAttribute("mensaje", "Error al registrar el donante.");
                request.getSession().setAttribute("tipoMensaje", "error");
            }
        } else {
            success = dao.actualizar(d);
            if (success) {
                request.getSession().setAttribute("mensaje", "Donante actualizado exitosamente.");
                request.getSession().setAttribute("tipoMensaje", "success");
            } else {
                request.getSession().setAttribute("mensaje", "Error al actualizar el donante.");
                request.getSession().setAttribute("tipoMensaje", "error");
            }
        }

        response.sendRedirect(request.getContextPath() + "/donantes");
    }

    private List<Donante> filtrarDonantes(List<Donante> origen, String q) {
        if (q == null || q.isBlank()) {
            return origen;
        }

        String criterio = q.toLowerCase(Locale.ROOT);
        List<Donante> filtrada = new ArrayList<>();
        for (Donante d : origen) {
            String texto = (d.getIdDonante() + " " + d.getNombre() + " " + d.getEmail() + " " + d.getTelefono() + " " + d.getTipoDonante())
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
