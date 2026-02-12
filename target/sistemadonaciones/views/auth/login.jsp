<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso Comunidad Vulnerable - Sistema de Donaciones</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-emerald-100 via-lime-50 to-white text-slate-900">
    <div class="min-h-screen grid grid-cols-1 lg:grid-cols-2">
        <section class="hidden lg:flex items-center justify-center p-14 bg-emerald-900 text-white relative overflow-hidden">
            <div class="absolute inset-0 opacity-20 bg-[radial-gradient(circle_at_top,_#34d399_0%,_transparent_45%)]"></div>
            <div class="relative max-w-md">
                <div class="inline-flex items-center gap-3 bg-white/10 border border-white/20 px-4 py-2 rounded-full text-sm font-semibold mb-8">
                    <i class="fa-solid fa-heart-circle-check"></i> Sistema de Donaciones
                </div>
                <h1 class="text-4xl font-extrabold leading-tight">Portal seguro para gestionar apoyo a comunidades vulnerables</h1>
                <p class="mt-5 text-emerald-50/90 text-sm leading-6">Consulta donaciones, campañas y personas beneficiarias con acceso controlado y sesiones seguras.</p>
            </div>
        </section>

        <section class="flex items-center justify-center p-6 sm:p-10">
            <div class="w-full max-w-md bg-white/90 backdrop-blur rounded-3xl shadow-xl border border-white p-8 sm:p-10">
                <div class="mb-7">
                    <h2 class="text-2xl font-extrabold text-slate-900">Iniciar sesión</h2>
                    <p class="text-sm text-slate-500 mt-1">Tu sesión se cerrará automáticamente tras 20 minutos de inactividad.</p>
                </div>

                <% if (request.getParameter("expirada") != null) { %>
                    <div class="mb-5 px-4 py-3 rounded-xl bg-amber-50 border border-amber-200 text-amber-700 text-sm font-semibold">
                        La sesión expiró por inactividad. Vuelve a iniciar sesión.
                    </div>
                <% } %>

                <% if (request.getParameter("logout") != null) { %>
                    <div class="mb-5 px-4 py-3 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-700 text-sm font-semibold">
                        Sesión cerrada correctamente.
                    </div>
                <% } %>

                <% if (request.getAttribute("errorLogin") != null) { %>
                    <div class="mb-5 px-4 py-3 rounded-xl bg-red-50 border border-red-200 text-red-700 text-sm font-semibold">
                        <%= request.getAttribute("errorLogin") %>
                    </div>
                <% } %>

                <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-5">
                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Usuario</label>
                        <div class="relative">
                            <span class="absolute left-0 inset-y-0 pl-4 flex items-center text-slate-400"><i class="fa-solid fa-user"></i></span>
                            <input
                                type="text"
                                name="usuario"
                                value="${usuarioIngresado}"
                                required
                                maxlength="50"
                                class="w-full pl-11 pr-4 py-3 rounded-2xl border border-slate-200 bg-slate-50 focus:bg-white focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200 outline-none text-sm"
                                placeholder="Ingresa tu usuario"
                            >
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold text-slate-700 mb-2">Contraseña</label>
                        <div class="relative">
                            <span class="absolute left-0 inset-y-0 pl-4 flex items-center text-slate-400"><i class="fa-solid fa-lock"></i></span>
                            <input
                                type="password"
                                name="password"
                                required
                                maxlength="255"
                                class="w-full pl-11 pr-4 py-3 rounded-2xl border border-slate-200 bg-slate-50 focus:bg-white focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200 outline-none text-sm"
                                placeholder="Ingresa tu contraseña"
                            >
                        </div>
                    </div>

                    <button type="submit" class="w-full inline-flex items-center justify-center gap-2 py-3 rounded-2xl bg-emerald-700 hover:bg-emerald-800 text-white font-bold shadow-lg shadow-emerald-200 transition">
                        <i class="fa-solid fa-right-to-bracket"></i>
                        Acceder
                    </button>
                </form>
            </div>
        </section>
    </div>
</body>
</html>
