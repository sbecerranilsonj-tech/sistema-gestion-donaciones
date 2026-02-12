<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Dashboard - Sistema de Donaciones" />

<jsp:include page="/includes/header.jsp" />
<jsp:include page="/includes/navbar.jsp" />

<!-- Dashboard Header -->
<div class="mb-8">
    <h1 class="text-3xl font-extrabold text-gray-900 tracking-tight">Resumen General</h1>
    <p class="text-gray-500 mt-1">Bienvenido de nuevo. Aquí tienes las estadísticas de hoy.</p>
</div>

<!-- Stat Cards -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-10">
    <!-- Card 1 -->
    <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 hover:shadow-md transition-shadow duration-300">
        <div class="flex items-center justify-between mb-4">
            <div class="bg-green-100 p-3 rounded-xl">
                <i class="fa-solid fa-hand-holding-dollar text-green-700 text-xl"></i>
            </div>
            <span class="text-xs font-bold text-green-600 bg-green-50 px-2 py-1 rounded-lg">+12.5%</span>
        </div>
        <p class="text-sm font-medium text-gray-500">Total Donado</p>
        <h3 class="text-2xl font-bold text-gray-900 mt-1">$45,230.00</h3>
    </div>

    <!-- Card 2 -->
    <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 hover:shadow-md transition-shadow duration-300">
        <div class="flex items-center justify-between mb-4">
            <div class="bg-blue-100 p-3 rounded-xl">
                <i class="fa-solid fa-users text-blue-700 text-xl"></i>
            </div>
            <span class="text-xs font-bold text-blue-600 bg-blue-50 px-2 py-1 rounded-lg">+8 new</span>
        </div>
        <p class="text-sm font-medium text-gray-500">Nuevos Donantes</p>
        <h3 class="text-2xl font-bold text-gray-900 mt-1">128</h3>
    </div>

    <!-- Card 3 -->
    <div class="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 hover:shadow-md transition-shadow duration-300">
        <div class="flex items-center justify-between mb-4">
            <div class="bg-purple-100 p-3 rounded-xl">
                <i class="fa-solid fa-bullhorn text-purple-700 text-xl"></i>
            </div>
            <span class="text-xs font-bold text-purple-600 bg-purple-50 px-2 py-1 rounded-lg">4 Activas</span>
        </div>
        <p class="text-sm font-medium text-gray-500">Campañas Vigentes</p>
        <h3 class="text-2xl font-bold text-gray-900 mt-1">12</h3>
    </div>
</div>

<!-- Recent Donations Table -->
<div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
    <div class="p-6 border-b border-gray-50 flex items-center justify-between">
        <h2 class="text-xl font-bold text-gray-900">Donaciones Recientes</h2>
        <a href="${pageContext.request.contextPath}/donaciones" class="text-sm font-semibold text-green-700 hover:text-green-800 transition-colors">Ver todas</a>
    </div>
    <div class="overflow-x-auto">
        <table class="w-full text-left">
            <thead>
                <tr class="bg-gray-50/50">
                    <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">Donante</th>
                    <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">Monto</th>
                    <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">Fecha</th>
                    <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">Estado</th>
                    <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider text-right">Acción</th>
                </tr>
            </thead>
            <tbody class="divide-y divide-gray-50">
                <tr class="hover:bg-green-50/30 transition-colors group">
                    <td class="px-6 py-4">
                        <div class="flex items-center">
                            <div class="h-8 w-8 rounded-full bg-gray-100 flex items-center justify-center text-gray-500 font-bold text-xs mr-3">JD</div>
                            <span class="text-sm font-semibold text-gray-700">Juan Delgado</span>
                        </div>
                    </td>
                    <td class="px-6 py-4 text-sm font-bold text-gray-900">$500.00</td>
                    <td class="px-6 py-4 text-sm text-gray-500">Hoy, 10:30 AM</td>
                    <td class="px-6 py-4">
                        <span class="px-2.5 py-1 text-[10px] font-bold uppercase rounded-lg bg-green-100 text-green-700 border border-green-200">Completado</span>
                    </td>
                    <td class="px-6 py-4 text-right">
                        <button class="text-gray-400 hover:text-green-700 transition-colors"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                    </td>
                </tr>
                <tr class="hover:bg-green-50/30 transition-colors group">
                    <td class="px-6 py-4">
                        <div class="flex items-center">
                            <div class="h-8 w-8 rounded-full bg-gray-100 flex items-center justify-center text-gray-500 font-bold text-xs mr-3">MA</div>
                            <span class="text-sm font-semibold text-gray-700">Maria Alva</span>
                        </div>
                    </td>
                    <td class="px-6 py-4 text-sm font-bold text-gray-900">$1,200.00</td>
                    <td class="px-6 py-4 text-sm text-gray-500">Ayer, 4:15 PM</td>
                    <td class="px-6 py-4">
                        <span class="px-2.5 py-1 text-[10px] font-bold uppercase rounded-lg bg-yellow-100 text-yellow-700 border border-yellow-200">Pendiente</span>
                    </td>
                    <td class="px-6 py-4 text-right">
                        <button class="text-gray-400 hover:text-green-700 transition-colors"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                    </td>
                </tr>
                <tr class="hover:bg-green-50/30 transition-colors group">
                    <td class="px-6 py-4">
                        <div class="flex items-center">
                            <div class="h-8 w-8 rounded-full bg-gray-100 flex items-center justify-center text-gray-500 font-bold text-xs mr-3">RC</div>
                            <span class="text-sm font-semibold text-gray-700">Roberto Carlos</span>
                        </div>
                    </td>
                    <td class="px-6 py-4 text-sm font-bold text-gray-900">$50.00</td>
                    <td class="px-6 py-4 text-sm text-gray-500">Feb 4, 2026</td>
                    <td class="px-6 py-4">
                        <span class="px-2.5 py-1 text-[10px] font-bold uppercase rounded-lg bg-green-100 text-green-700 border border-green-200">Completado</span>
                    </td>
                    <td class="px-6 py-4 text-right">
                        <button class="text-gray-400 hover:text-green-700 transition-colors"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/includes/footer.jsp" />