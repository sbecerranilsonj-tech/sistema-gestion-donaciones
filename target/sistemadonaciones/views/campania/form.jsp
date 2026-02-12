<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="${campania == null ? 'Nueva Campaña' : 'Editar Campaña'} - Sistema de Donaciones" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/navbar.jsp" />

<div class="max-w-4xl mx-auto">
    <div class="mb-8">
        <a href="${pageContext.request.contextPath}/campanias" class="text-sm font-semibold text-green-700 hover:text-green-800 flex items-center gap-2 mb-4 transition-colors">
            <i class="fa-solid fa-arrow-left"></i> Volver a campañas
        </a>
        <h1 class="text-3xl font-extrabold text-gray-900 tracking-tight">
            ${campania == null ? "Crear Nueva Campaña" : "Editar Campaña"}
        </h1>
        <p class="text-gray-500 mt-1">Defina los objetivos y el período de vigencia de la iniciativa.</p>
    </div>

    <div class="bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden">
        <form action="${pageContext.request.contextPath}/campanias" method="post" class="p-8 md:p-12">
            
            <!-- ID oculto (solo para edición) -->
            <input type="hidden" name="id_campania" value="${campania != null ? campania.id_campania : ''}">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <!-- Nombre -->
                <div class="md:col-span-2 space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Nombre de la Campaña <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                            <i class="fa-solid fa-flag"></i>
                        </span>
                        <input type="text" name="nombre" value="${campania != null ? campania.nombre : ''}" required
                               class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none" placeholder="Ej. Colecta de Invierno 2026">
                    </div>
                </div>

                <!-- Fecha Inicio -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Fecha de Inicio <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                            <i class="fa-solid fa-calendar-play"></i>
                        </span>
                        <input type="date" name="fecha_inicio" value="<fmt:formatDate value='${campania.fecha_inicio}' pattern='yyyy-MM-dd'/>" required
                               class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none">
                    </div>
                </div>

                <!-- Fecha Fin -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Fecha de Finalización <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                            <i class="fa-solid fa-calendar-check"></i>
                        </span>
                        <input type="date" name="fecha_fin" value="<fmt:formatDate value='${campania.fecha_fin}' pattern='yyyy-MM-dd'/>" required
                               class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none">
                    </div>
                </div>

                <!-- Estado -->
                <div class="md:col-span-2 space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Estado de la Campaña <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-circle-nodes"></i>
                        </span>
                        <select name="estado" required
                                class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none appearance-none">
                            <option value="">Seleccione un estado</option>
                            <option value="Planificada" ${campania != null && campania.estado == 'Planificada' ? 'selected' : ''}>Planificada</option>
                            <option value="Activa" ${campania != null && campania.estado == 'Activa' ? 'selected' : ''}>Activa</option>
                            <option value="Finalizada" ${campania != null && campania.estado == 'Finalizada' ? 'selected' : ''}>Finalizada</option>
                            <option value="Cancelada" ${campania != null && campania.estado == 'Cancelada' ? 'selected' : ''}>Cancelada</option>
                        </select>
                        <span class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-chevron-down text-[10px]"></i>
                        </span>
                    </div>
                </div>

                <!-- Descripción -->
                <div class="md:col-span-2 space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Propósito y Detalles</label>
                    <textarea name="descripcion" rows="5"
                              class="block w-full px-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none resize-none" placeholder="Escriba aquí los objetivos de la campaña...">${campania != null ? campania.descripcion : ''}</textarea>
                </div>
            </div>

            <div class="mt-12 flex items-center justify-end gap-4 border-t border-gray-100 pt-8">
                <a href="${pageContext.request.contextPath}/campanias"
                   class="px-6 py-3 text-sm font-bold text-gray-500 hover:text-gray-700 transition-colors">
                    Cancelar
                </a>
                <button type="submit"
                        class="px-10 py-3 bg-green-700 hover:bg-green-800 text-white text-sm font-extrabold rounded-2xl shadow-lg shadow-green-200 transition-all duration-200 transform hover:-translate-y-1">
                    <i class="fa-solid fa-rocket mr-2"></i> ${campania == null ? 'Lanzar Campaña' : 'Guardar Cambios'}
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />