<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Sistema de Donaciones'}</title>

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Google Fonts: Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- FontAwesome Icons CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />

    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
        }
        ::-webkit-scrollbar-track {
            background: #f0fdf4; /* bg-green-50 */
        }
        ::-webkit-scrollbar-thumb {
            background: #bbf7d0; /* bg-green-200 */
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #86efac; /* bg-green-300 */
        }
    </style>
</head>
<body class="bg-green-50 text-gray-900 min-h-screen font-sans">
    <div class="flex">