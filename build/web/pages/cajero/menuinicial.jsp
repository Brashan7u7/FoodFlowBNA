<%-- 
    Document   : menuinicial
    Created on : Nov 19, 2024, 12:21:32 AM
    Author     : rafis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="model.mostcategorias" %>
<%@page import="java.util.List" %>
<%@include file="../../components/header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu Inicial</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .grid-container {
                display: grid;
                grid-template-columns: repeat(3, 1fr); /* Tres columnas */
                gap: 50px; /* Más espacio entre elementos */
                padding: 20px;
            }

            .grid-item {
                position: relative;
                overflow: hidden;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Sombra para destacar */
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .grid-item img {
                width: 100%;
                height: auto;
                display: block;
                transition: transform 0.3s ease;
            }

            .grid-item:hover {
                transform: translateY(-5px); /* Pequeño movimiento hacia arriba */
                box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
            }

            .overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.4);
                display: flex;
                justify-content: center;
                align-items: center;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .grid-item:hover .overlay {
                opacity: 1;
            }

            .overlay h2 {
                color: white;
                font-size: 1.5rem;
                text-transform: uppercase;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <%@include file="../../components/sidebarAdmin.jsp" %>
        <!-- Contenedor principal -->
        <div class="container mt-4">
            <!-- Grid de imágenes dinámico -->
            <div class="grid-container">
                <%
                List<mostcategorias> categorias = (List<mostcategorias>) request.getAttribute("categorias");
                if (categorias != null && !categorias.isEmpty()) {
                    for (mostcategorias categoria : categorias) {
                        System.out.println("Mostrando categoría: " + categoria.getNombre());
                %>
                    <a href="/filtradoCategorias?id=<%= categoria.getId() %>">
                        <div class="grid-item">
                            <img src="<%= categoria.getImagen() %>" alt="<%= categoria.getNombre() %>">
                            <div class="overlay">
                                <h2><%= categoria.getNombre() %></h2>
                            </div>
                        </div>
                    </a>
                <% 
                    }
                } else {
                %>
                <p>No hay categorías activas disponibles en este momento.</p>
            <% } %>
            </div>
        </div>

        <script>
            // Función para abrir/cerrar el sidebar
            function toggleSidebar() {
                document.getElementById("mySidebar").classList.toggle("open");
            }
        </script>
    </body>
</html>