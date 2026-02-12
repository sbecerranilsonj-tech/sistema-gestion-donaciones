<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="${donacion == null ? 'Nueva Donación' : 'Editar Donación'} - Sistema de Donaciones" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/navbar.jsp" />

<div class="max-w-4xl mx-auto">
    <div class="mb-8">
        <a href="${pageContext.request.contextPath}/donaciones" class="text-sm font-semibold text-green-700 hover:text-green-800 flex items-center gap-2 mb-4 transition-colors">
            <i class="fa-solid fa-arrow-left"></i> Volver al historial
        </a>
        <h1 class="text-3xl font-extrabold text-gray-900 tracking-tight">
            ${donacion == null ? "Registrar Nueva Donación" : "Editar Donación"}
        </h1>
        <p class="text-gray-500 mt-1">Ingrese los detalles de la contribución recibida.</p>
    </div>

    <div class="bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden">
        <form action="${pageContext.request.contextPath}/donaciones" method="post" class="p-8 md:p-12">
            
            <!-- ID oculto (solo para edición) -->
            <input type="hidden" name="id_donacion" value="${donacion != null ? donacion.id_donacion : ''}">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <!-- Donante -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Donante <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-user"></i>
                        </span>
                        <select name="id_donante" required
                                class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none appearance-none">
                            <option value="">Seleccione un donante</option>
                            <c:forEach var="donante" items="${donantes}">
                                <option value="${donante.idDonante}" ${donacion != null && donacion.id_donante == donante.idDonante ? 'selected' : ''}>
                                    ${donante.nombre}
                                </option>
                            </c:forEach>
                        </select>
                        <span class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-chevron-down text-[10px]"></i>
                        </span>
                    </div>
                </div>

                <!-- Campaña -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Campaña Relacionada</label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-bullhorn"></i>
                        </span>
                        <select name="id_campania"
                                class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none appearance-none">
                            <option value="">Donación General (Sin Campaña)</option>
                            <c:forEach var="campania" items="${campanias}">
                                <option value="${campania.id_campania}" ${donacion != null && donacion.id_campania == campania.id_campania ? 'selected' : ''}>
                                    ${campania.nombre}
                                </option>
                            </c:forEach>
                        </select>
                        <span class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-chevron-down text-[10px]"></i>
                        </span>
                    </div>
                </div>

                <!-- Tipo -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Tipo de Contribución <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-tag"></i>
                        </span>
                        <select name="tipo_donacion" required
                                class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none appearance-none">
                            <option value="">Seleccione tipo</option>
                            <option value="Monetaria" ${donacion != null && donacion.tipo_donacion == 'Monetaria' ? 'selected' : ''}>Monetaria</option>
                            <option value="En Especie" ${donacion != null && donacion.tipo_donacion == 'En Especie' ? 'selected' : ''}>En Especie</option>
                            <option value="Servicio" ${donacion != null && donacion.tipo_donacion == 'Servicio' ? 'selected' : ''}>Servicio</option>
                        </select>
                        <span class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-chevron-down text-[10px]"></i>
                        </span>
                    </div>
                </div>

                <!-- Estado -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Estado <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-circle-check"></i>
                        </span>
                        <select name="estado_donacion" required
                                class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none appearance-none">
                            <option value="">Seleccione estado</option>
                            <option value="Pendiente" ${donacion != null && donacion.estado_donacion == 'Pendiente' ? 'selected' : ''}>Pendiente</option>
                            <option value="Confirmada" ${donacion != null && donacion.estado_donacion == 'Confirmada' ? 'selected' : ''}>Confirmada</option>
                            <option value="Rechazada" ${donacion != null && donacion.estado_donacion == 'Rechazada' ? 'selected' : ''}>Rechazada</option>
                            <option value="Completada" ${donacion != null && donacion.estado_donacion == 'Completada' ? 'selected' : ''}>Completada</option>
                        </select>
                        <span class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-chevron-down text-[10px]"></i>
                        </span>
                    </div>
                </div>

                <!-- Fecha -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Fecha de Recepción <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                            <i class="fa-solid fa-calendar-days"></i>
                        </span>
                        <input type="date" name="fecha_donacion" value="<fmt:formatDate value='${donacion.fecha_donacion}' pattern='yyyy-MM-dd'/>" required
                               class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none">
                    </div>
                </div>

                <!-- Monto -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Monto / Valor Estimado <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                            <i class="fa-solid fa-dollar-sign"></i>
                        </span>
                        <input type="number" name="monto" value="${donacion != null ? donacion.monto : ''}" min="0.01" step="0.01" required
                               class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none" placeholder="0.00">
                    </div>
                </div>

                <!-- Descripción -->
                <div class="md:col-span-2 space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Observaciones / Descripción</label>
                    <textarea name="descripcion" rows="4"
                              class="block w-full px-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none resize-none" placeholder="Detalles adicionales sobre la donación...">${donacion != null ? donacion.descripcion : ''}</textarea>
                </div>
            </div>

            <div class="mt-12 flex items-center justify-end gap-4 border-t border-gray-100 pt-8">
                <a href="${pageContext.request.contextPath}/donaciones"
                   class="px-6 py-3 text-sm font-bold text-gray-500 hover:text-gray-700 transition-colors">
                    Cancelar
                </a>
                <button type="submit"
                        class="px-10 py-3 bg-green-700 hover:bg-green-800 text-white text-sm font-extrabold rounded-2xl shadow-lg shadow-green-200 transition-all duration-200 transform hover:-translate-y-1">
                    <i class="fa-solid fa-floppy-disk mr-2"></i> ${donacion == null ? 'Registrar Donación' : 'Guardar Cambios'}
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />
