<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="${donante == null ? 'Nuevo Donante' : 'Editar Donante'} - Sistema de Donaciones" />

<jsp:include page="/includes/header.jsp"/>
<jsp:include page="/includes/navbar.jsp"/>

<div class="max-w-4xl mx-auto">
    <div class="mb-8">
        <a href="${pageContext.request.contextPath}/donantes" class="text-sm font-semibold text-green-700 hover:text-green-800 flex items-center gap-2 mb-4 transition-colors">
            <i class="fa-solid fa-arrow-left"></i> Volver al listado
        </a>
        <h1 class="text-3xl font-extrabold text-gray-900 tracking-tight">
            ${donante == null ? "Registrar Nuevo Donante" : "Editar Donante"}
        </h1>
        <p class="text-gray-500 mt-1">Complete la información requerida para el registro del donante.</p>
    </div>

    <div class="bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden">
        <form action="${pageContext.request.contextPath}/donantes" method="post" class="p-8 md:p-12">
            
            <!-- ID oculto (solo para edición) -->
            <input type="hidden" name="idDonante" value="${donante != null ? donante.idDonante : ''}">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                <!-- Nombre -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Nombre Completo <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                            <i class="fa-solid fa-user"></i>
                        </span>
                        <input type="text" name="nombre" value="${donante != null ? donante.nombre : ''}" maxlength="150" required
                               class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none" placeholder="Ej. Juan Pérez">
                    </div>
                </div>

                <!-- Email -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Correo Electrónico</label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                            <i class="fa-solid fa-envelope"></i>
                        </span>
                        <input type="email" name="email" value="${donante != null ? donante.email : ''}" maxlength="100"
                               class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none" placeholder="correo@ejemplo.com">
                    </div>
                </div>

                <!-- Teléfono -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Teléfono</label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                            <i class="fa-solid fa-phone"></i>
                        </span>
                        <input type="text" name="telefono" value="${donante != null ? donante.telefono : ''}" maxlength="20"
                               class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none" placeholder="+54 9 1234 5678">
                    </div>
                </div>

                <!-- País -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">País de Origen <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-globe"></i>
                        </span>
                        <select name="idPais" required
                                class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none appearance-none">
                            <option value="">Seleccione un país</option>
                            <c:forEach var="pais" items="${paises}">
                                <option value="${pais.id_pais}" ${donante != null && donante.idPais == pais.id_pais ? 'selected' : ''}>
                                    ${pais.nombre}
                                </option>
                            </c:forEach>
                        </select>
                        <span class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-chevron-down text-[10px]"></i>
                        </span>
                    </div>
                </div>

                <!-- Tipo de Donante -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Categoría <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-tag"></i>
                        </span>
                        <select name="tipoDonante" required
                                class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none appearance-none">
                            <option value="">Seleccione</option>
                            <option value="Persona Natural" ${donante != null && donante.tipoDonante == 'Persona Natural' ? 'selected' : ''}>Persona Natural</option>
                            <option value="Empresa" ${donante != null && donante.tipoDonante == 'Empresa' ? 'selected' : ''}>Empresa</option>
                            <option value="Institucion" ${donante != null && donante.tipoDonante == 'Institucion' ? 'selected' : ''}>Institucion</option>
                            <option value="Gobierno" ${donante != null && donante.tipoDonante == 'Gobierno' ? 'selected' : ''}>Gobierno</option>
                        </select>
                        <span class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 pointer-events-none">
                            <i class="fa-solid fa-chevron-down text-[10px]"></i>
                        </span>
                    </div>
                </div>

                <!-- Fecha -->
                <div class="space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Fecha de Registro <span class="text-red-500">*</span></label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                            <i class="fa-solid fa-calendar-days"></i>
                        </span>
                        <input type="date" name="fechaRegistro" value="<fmt:formatDate value='${donante.fechaRegistro}' pattern='yyyy-MM-dd'/>" required
                               class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none">
                    </div>
                </div>

                <!-- Dirección -->
                <div class="md:col-span-2 space-y-2">
                    <label class="block text-sm font-bold text-gray-700">Dirección Postal</label>
                    <div class="relative">
                        <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                            <i class="fa-solid fa-location-dot"></i>
                        </span>
                        <input type="text" name="direccion" value="${donante != null ? donante.direccion : ''}" maxlength="200"
                               class="block w-full pl-11 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-2xl text-sm focus:ring-2 focus:ring-green-500 focus:border-green-500 focus:bg-white transition-all outline-none" placeholder="Calle, Número, Ciudad">
                    </div>
                </div>
            </div>

            <div class="mt-12 flex items-center justify-end gap-4 border-t border-gray-100 pt-8">
                <a href="${pageContext.request.contextPath}/donantes"
                   class="px-6 py-3 text-sm font-bold text-gray-500 hover:text-gray-700 transition-colors">
                    Cancelar
                </a>
                <button type="submit"
                        class="px-10 py-3 bg-green-700 hover:bg-green-800 text-white text-sm font-extrabold rounded-2xl shadow-lg shadow-green-200 transition-all duration-200 transform hover:-translate-y-1">
                    <i class="fa-solid fa-floppy-disk mr-2"></i> ${donante == null ? 'Registrar' : 'Guardar Cambios'}
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/includes/footer.jsp"/>
