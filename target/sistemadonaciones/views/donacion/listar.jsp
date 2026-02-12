<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Donaciones - Sistema de Donaciones" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/navbar.jsp" />

<div class="flex items-center justify-between mb-8">
    <div>
        <h1 class="text-3xl font-extrabold text-gray-900 tracking-tight">Historial de Donaciones</h1>
        <p class="text-gray-500 mt-1">Registro completo de contribuciones recibidas.</p>
    </div>
    <a href="${pageContext.request.contextPath}/donaciones?accion=nuevo"
       class="inline-flex items-center px-5 py-2.5 bg-green-700 hover:bg-green-800 text-white text-sm font-bold rounded-xl shadow-sm transition-all duration-200 transform hover:-translate-y-0.5">
        <i class="fa-solid fa-plus mr-2"></i> Nueva Donación
    </a>
</div>

<div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
    <div class="p-5 border-b border-gray-100 bg-gray-50/50">
        <form action="${pageContext.request.contextPath}/donaciones" method="get" class="flex flex-col sm:flex-row gap-3 sm:items-center sm:justify-between">
            <input type="hidden" name="accion" value="listar">
            <div class="relative w-full sm:max-w-md">
                <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </span>
                <input
                    type="text"
                    name="q"
                    value="${q}"
                    placeholder="Buscar por donante, campania, estado o tipo"
                    class="w-full pl-11 pr-4 py-2.5 rounded-xl border border-gray-200 bg-white text-sm focus:ring-2 focus:ring-green-200 focus:border-green-500 outline-none"
                >
            </div>
            <button type="submit" class="inline-flex items-center justify-center px-4 py-2.5 rounded-xl bg-green-700 hover:bg-green-800 text-white text-sm font-bold">
                Buscar
            </button>
        </form>
        <p class="mt-3 text-xs text-gray-500">
            Mostrando ${desdeRegistro} - ${hastaRegistro} de ${totalRegistros} resultados
        </p>
    </div>

    <c:choose>
        <c:when test="${empty donaciones}">
            <div class="p-20 text-center">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-green-50 text-green-600 rounded-full mb-4">
                    <i class="fa-solid fa-hand-holding-dollar text-2xl"></i>
                </div>
                <h3 class="text-lg font-bold text-gray-900">Sin donaciones</h3>
                <p class="text-gray-500 mt-1">Todavía no se han registrado transacciones.</p>
                <div class="mt-6">
                    <a href="${pageContext.request.contextPath}/donaciones?accion=nuevo" class="text-green-700 font-semibold hover:underline">Registrar donación &rarr;</a>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead>
                        <tr class="bg-gray-50/50">
                            <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">ID</th>
                            <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">Donante / Campaña</th>
                            <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">Tipo</th>
                            <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">Estado</th>
                            <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider text-right">Monto</th>
                            <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider text-right">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-50">
                        <c:forEach var="d" items="${donaciones}">
                            <tr class="hover:bg-green-50/30 transition-colors">
                                <td class="px-6 py-4 text-sm text-gray-500 font-mono">#${d.id_donacion}</td>
                                <td class="px-6 py-4">
                                    <div class="text-sm font-bold text-gray-900">${d.nombreDonante}</div>
                                    <div class="text-xs text-gray-400 mt-0.5">${d.nombreCampania != null ? d.nombreCampania : 'Donación General'}</div>
                                </td>
                                <td class="px-6 py-4">
                                    <span class="text-sm text-gray-600 font-medium">${d.tipo_donacion}</span>
                                    <div class="text-[10px] text-gray-400 font-medium"><fmt:formatDate value="${d.fecha_donacion}" pattern="dd MMM, yyyy"/></div>
                                </td>
                                <td class="px-6 py-4">
                                    <c:set var="badgeClass" value="bg-gray-100 text-gray-700 border-gray-200" />
                                    <c:if test="${d.estado_donacion == 'COMPLETADA'}">
                                        <c:set var="badgeClass" value="bg-green-50 text-green-700 border-green-200" />
                                    </c:if>
                                    <c:if test="${d.estado_donacion == 'PENDIENTE'}">
                                        <c:set var="badgeClass" value="bg-yellow-50 text-yellow-700 border-yellow-200" />
                                    </c:if>
                                    <span class="px-2.5 py-1 text-[10px] font-bold uppercase rounded-lg border ${badgeClass}">
                                        ${d.estado_donacion}
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <span class="text-sm font-extrabold text-gray-900">
                                        <fmt:formatNumber value="${d.monto}" type="currency" currencySymbol="$" maxFractionDigits="2"/>
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right space-x-2">
                                    <a href="${pageContext.request.contextPath}/donaciones?accion=editar&id=${d.id_donacion}"
                                       class="inline-flex items-center justify-center w-9 h-9 text-blue-600 bg-blue-50 hover:bg-blue-100 rounded-xl transition-colors shadow-sm">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/donaciones?accion=eliminar&id=${d.id_donacion}"
                                       class="inline-flex items-center justify-center w-9 h-9 text-red-600 bg-red-50 hover:bg-red-100 rounded-xl transition-colors shadow-sm"
                                       onclick="return confirm('¿Está seguro de eliminar esta donación?')">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="px-5 py-4 border-t border-gray-100 bg-gray-50/60 flex items-center justify-between">
                <a href="${pageContext.request.contextPath}/donaciones?accion=listar&page=${page > 1 ? page - 1 : 1}&q=${q}"
                   class="inline-flex items-center gap-2 px-3 py-2 rounded-lg border text-sm font-semibold ${page > 1 ? 'text-gray-700 bg-white hover:bg-gray-50 border-gray-200' : 'text-gray-400 bg-gray-100 border-gray-100 pointer-events-none'}">
                    <i class="fa-solid fa-chevron-left text-[10px]"></i> Anterior
                </a>
                <span class="text-xs font-semibold text-gray-500">Pagina ${page} de ${totalPaginas}</span>
                <a href="${pageContext.request.contextPath}/donaciones?accion=listar&page=${page < totalPaginas ? page + 1 : totalPaginas}&q=${q}"
                   class="inline-flex items-center gap-2 px-3 py-2 rounded-lg border text-sm font-semibold ${page < totalPaginas ? 'text-gray-700 bg-white hover:bg-gray-50 border-gray-200' : 'text-gray-400 bg-gray-100 border-gray-100 pointer-events-none'}">
                    Siguiente <i class="fa-solid fa-chevron-right text-[10px]"></i>
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/includes/footer.jsp" />
