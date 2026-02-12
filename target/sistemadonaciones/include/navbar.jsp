<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.donaciones.model.UsuarioSistema" %>
<%
    String uri = request.getRequestURI();
    boolean isInicio = uri.endsWith("/inicio") || uri.endsWith("/") || uri.contains("index.jsp");
    boolean isDonantes = uri.contains("/donantes");
    boolean isCampanias = uri.contains("/campanias");
    boolean isDonaciones = uri.contains("/donaciones");

    String pageTitleDisplay = "Dashboard";
    if (isDonantes) pageTitleDisplay = "Donantes";
    else if (isDonaciones) pageTitleDisplay = "Donaciones";
    else if (isCampanias) pageTitleDisplay = "Campanias";

    UsuarioSistema usuarioSesion = (UsuarioSistema) session.getAttribute("usuarioLogueado");
    String nombreUsuario = usuarioSesion != null ? usuarioSesion.getNombre() : "Usuario";
    String rolUsuario = usuarioSesion != null ? usuarioSesion.getRol() : "Rol";
%>

<aside class="w-64 bg-green-900 text-white flex-shrink-0 fixed h-full flex flex-col shadow-xl z-20">
    <div class="p-8 flex items-center gap-3">
        <div class="bg-white p-2 rounded-xl shadow-inner">
            <i class="fa-solid fa-heart text-green-700 text-xl"></i>
        </div>
        <span class="text-xl font-bold tracking-tight">Donaciones</span>
    </div>

    <nav class="mt-4 flex-1">
        <a href="${pageContext.request.contextPath}/inicio"
           class="flex items-center px-6 py-3.5 text-sm font-medium transition-all duration-200 group <%= isInicio ? "bg-green-800 text-white border-l-4 border-white" : "text-green-100 hover:bg-green-800/50 hover:text-white border-l-4 border-transparent" %>">
            <i class="fa-solid fa-chart-pie mr-3 w-5 text-center"></i> Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/donaciones"
           class="flex items-center px-6 py-3.5 text-sm font-medium transition-all duration-200 group <%= isDonaciones ? "bg-green-800 text-white border-l-4 border-white" : "text-green-100 hover:bg-green-800/50 hover:text-white border-l-4 border-transparent" %>">
            <i class="fa-solid fa-hand-holding-dollar mr-3 w-5 text-center"></i> Donaciones
        </a>

        <a href="${pageContext.request.contextPath}/donantes"
           class="flex items-center px-6 py-3.5 text-sm font-medium transition-all duration-200 group <%= isDonantes ? "bg-green-800 text-white border-l-4 border-white" : "text-green-100 hover:bg-green-800/50 hover:text-white border-l-4 border-transparent" %>">
            <i class="fa-solid fa-user-group mr-3 w-5 text-center"></i> Donantes
        </a>

        <a href="${pageContext.request.contextPath}/campanias"
           class="flex items-center px-6 py-3.5 text-sm font-medium transition-all duration-200 group <%= isCampanias ? "bg-green-800 text-white border-l-4 border-white" : "text-green-100 hover:bg-green-800/50 hover:text-white border-l-4 border-transparent" %>">
            <i class="fa-solid fa-handshake-angle mr-3 w-5 text-center"></i> Campanias
        </a>
    </nav>

    <div class="p-6 border-t border-green-800/50">
        <div class="flex items-center gap-3 bg-green-950/30 p-3 rounded-xl">
            <img src="https://ui-avatars.com/api/?name=<%= java.net.URLEncoder.encode(nombreUsuario, java.nio.charset.StandardCharsets.UTF_8) %>&background=15803d&color=fff" class="w-10 h-10 rounded-lg shadow-md border border-green-700/50" alt="Avatar" />
            <div class="overflow-hidden">
                <p class="text-sm font-bold truncate"><%= nombreUsuario %></p>
                <p class="text-[11px] text-green-300 truncate"><%= rolUsuario %></p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/logout" class="mt-3 w-full inline-flex justify-center items-center gap-2 py-2.5 rounded-xl bg-red-500/20 hover:bg-red-500/30 text-red-100 text-xs font-bold border border-red-200/20 transition">
            <i class="fa-solid fa-right-from-bracket"></i> Cerrar sesion
        </a>
    </div>
</aside>

<div class="flex-1 ml-64 flex flex-col min-h-screen">
    <header class="h-16 bg-white border-b border-gray-100 flex items-center justify-between px-10 sticky top-0 z-10 shadow-sm">
        <nav class="flex items-center text-sm font-medium" aria-label="Breadcrumb">
            <ol class="flex items-center space-x-2">
                <li><a href="${pageContext.request.contextPath}/inicio" class="text-gray-400 hover:text-green-700 transition-colors">Home</a></li>
                <li class="flex items-center space-x-2">
                    <i class="fa-solid fa-chevron-right text-[10px] text-gray-300"></i>
                    <span class="text-gray-900 font-semibold"><%= pageTitleDisplay %></span>
                </li>
            </ol>
        </nav>

        <div class="flex items-center gap-6">
            <div class="flex items-center gap-3 group">
                <div class="text-right hidden sm:block">
                    <p class="text-sm font-bold text-gray-800"><%= nombreUsuario %></p>
                    <p class="text-[10px] text-gray-400"><%= rolUsuario %></p>
                </div>
                <img src="https://ui-avatars.com/api/?name=<%= java.net.URLEncoder.encode(nombreUsuario, java.nio.charset.StandardCharsets.UTF_8) %>&background=15803d&color=fff" class="w-10 h-10 rounded-xl shadow-sm border border-gray-100" alt="Avatar" />
            </div>
        </div>
    </header>

    <main class="p-10 flex-1">
        <%
            String mensaje = (String) session.getAttribute("mensaje");
            String tipoMensaje = (String) session.getAttribute("tipoMensaje");

            if (mensaje != null) {
                String bg = "bg-blue-50 text-blue-700 border-blue-200";
                String icon = "fa-circle-info";
                if ("success".equals(tipoMensaje)) { bg = "bg-green-50 text-green-700 border-green-200"; icon = "fa-circle-check"; }
                else if ("error".equals(tipoMensaje) || "danger".equals(tipoMensaje)) { bg = "bg-red-50 text-red-700 border-red-200"; icon = "fa-circle-exclamation"; }
                else if ("warning".equals(tipoMensaje)) { bg = "bg-yellow-50 text-yellow-700 border-yellow-200"; icon = "fa-triangle-exclamation"; }
        %>
            <div class="mb-8 p-4 rounded-2xl border <%= bg %> flex items-center shadow-sm">
                <div class="mr-3 text-xl opacity-80">
                    <i class="fa-solid <%= icon %>"></i>
                </div>
                <p class="text-sm font-semibold tracking-tight"><%= mensaje %></p>
            </div>
        <%
                session.removeAttribute("mensaje");
                session.removeAttribute("tipoMensaje");
            }
        %>
