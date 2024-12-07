<%-- 
    Document   : sidebar
    Created on : 7/11/2024, 01:17:14 PM
    Author     : CruzF
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sidebar Component</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Estilo del contenedor del sidebar */
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                height: 100%;
                width: 50px; /* Ajustar el ancho cerrado */
                background-color: white;
                overflow-x: hidden;
                transition: width 0.3s;
                color: black;
                display: flex;
                flex-direction: column;
                z-index: 1000;
            }

            /* Estilo del sidebar cuando está abierto */
            .sidebar.open {
                width: 250px;
            }

            /* Estilo del botón para abrir/cerrar */
            .sidebar-toggle {
                background-color: #fff;
                color: black;
                border: none;
                width: 100%;
                padding: 10px;
                cursor: pointer;
                text-align: center; /* Centrar el ícono ☰ */
                font-size: 18px;
                transition: background-color 0.3s;
            }

            .sidebar-toggle:hover {
                background-color: #ffcccc;
            }

            /* Estilo de las opciones */
            .sidebar-option {
                display: flex;
                align-items: center;
                padding: 15px;
                font-size: 16px;
                cursor: pointer;
                color: black;
                transition: background-color 0.3s;
            }

            .sidebar-option:hover {
                background-color: #ffcccc;
            }

            /* Imagen de las opciones */
            .sidebar-option img {
                width: 40px;
                height: 40px;
                margin-right: 15px;
                transition: margin 0.3s;
            }

            /* Ocultar texto de la opción cuando el sidebar está cerrado */
            .sidebar:not(.open) .option-text,
            .sidebar:not(.open) .sidebar-option img {
                display: none;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar" id="mySidebar">
            <!-- Botón para abrir/cerrar el sidebar -->
            <button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>
            
            <!-- Opciones del sidebar -->
            <div class="sidebar-option">
                <img src="../../assets/icons/search.png" class="logo" alt="LOGO" onerror="fallbackImage(this, './assets/icons/search.png')">
                <span class="option-text">Buscar</span>
            </div>
            <div class="sidebar-option" onclick="window.location.href = '/foodflow/mostcategoriasservlet'">
                <img src="../../assets/icons/platillos.png" alt="Opción 3" onerror="fallbackImage(this, './assets/icons/platillos.png')">
                <span class="option-text">Menú</span>
            </div>
<!--            <div class="sidebar-option" onclick="window.location.href ='/foodflow/pages/admin/vistaventas.jsp'">
                <img src="../../assets/icons/ventas.png" alt="Opción 5" onerror="fallbackImage(this, './assets/icons/ventas.png')">
                <span class="option-text">Ventas</span>
            </div>-->
            <div class="sidebar-option" onclick="window.location.href ='/foodflow/clienteFview'">
                <img src="../../assets/icons/cart.png" alt="Opción 6" onerror="fallbackImage(this, './assets/icons/cart.png')">
                <span class="option-text">Carrito</span>
            </div>
            <div class="sidebar-option" onclick="window.location.href ='/foodflow/pages/login.jsp'">
                <img src="../../assets/icons/logout.png" alt="Opción 6" onerror="fallbackImage(this, './assets/icons/logout.png')">
                <span class="option-text">Cerrar Sesión</span>
            </div>
        </div>

        <script>
            // Función para abrir/cerrar el sidebar
            function toggleSidebar() {
                document.getElementById("mySidebar").classList.toggle("open");
            }
            
            function fallbackImage(imgElement, fallbackSrc) {
                imgElement.src = fallbackSrc;
            }
        </script>
    </body>
</html>