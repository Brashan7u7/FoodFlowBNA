<%-- 
    Document   : OrdenVacia
    Created on : 29/11/2024, 07:26:39 PM
    Author     : carla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orden Vacia</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            /* Estilo para centrar el contenido en la pantalla */
            .center-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
                text-align: center;
            }
            .logo {
                width: 600px;  /* Ancho obligatorio de 600px */
                height: auto;   /* La altura se ajustará automáticamente manteniendo la proporción */
                margin-bottom: 20px;
            }


            .btn-orange {
                background-color: #ff5722;
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
            }
            .btn-orange:hover {
                background-color: #e64a19;
            }
        </style>

    </head>
    <body>
        <%@include file="../../components/headerAdmin.jsp" %>
        <%@include file="../../components/sidebarAdmin.jsp" %>

        <!-- Contenido de la página -->
        <div class="center-container">
            <img src="../../assets/FoodFlow Logo.png" class="logo" alt="LOGO">
            <a href="${pageContext.request.contextPath}/pages/cajero/menuinicial.jsp">
                <button class="btn-orange">Agregar Platillos</button>
            </a>

        </div>

        <script>
            // Función para abrir/cerrar el sidebar
            function toggleSidebar() {
                document.getElementById("mySidebar").classList.toggle("open");
            }
        </script>
    </body>
</html>
