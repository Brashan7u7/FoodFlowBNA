<%-- 
    Document   : categorias
    Created on : Nov 20, 2024, 8:43:57 PM
    Author     : rafis
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Platillo" %>

<%@include file="../../components/header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Categorías</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .menu-card {
                border: 1px solid #ddd;
                border-radius: 10px;
                text-align: center;
                overflow: hidden;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .menu-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
            }

            .menu-card img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                margin-top: 15px;
            }

            .menu-card h5 {
                margin: 10px 0;
                font-size: 1.2rem;
                color: #333;
            }

            .menu-card p {
                margin: 5px 0;
                color: #777;
                font-size: 0.9rem;
            }

            .menu-card .add-button {
                background-color: #ffe5e5;
                color: #e63946;
                border: none;
                padding: 10px;
                width: 100%;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .menu-card .add-button:hover {
                background-color: #ffcccc;
            }

            .category-button {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 30px;
                padding: 10px 20px;
                font-size: 1rem;
                font-weight: bold;
                color: #333;
                cursor: pointer;
                transition: box-shadow 0.3s ease, background-color 0.3s ease;
            }

            .category-button:hover {
                background-color: #f5f5f5;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .category-button img {
                margin-right: 10px;
                width: 20px;
                height: auto;
            }
            .add-button .icon {
                height: 1.5em; /* Ajusta la altura al tamaño del texto */
                width: auto; /* Mantén las proporciones del ícono */
                margin-right: 3px; /* Espacio entre el ícono y el texto */
                position: relative; /* Necesario para aplicar el ajuste manual */
                top: -8px; /* Ajusta la posición vertical del ícono */
            }
        </style>
    </head>

    <body>
        <%@include file="../../components/sidebarAdmin.jsp" %>

        <div class="container mt-4">
            <!-- Botón Categorías -->
            <a action="<%= request.getContextPath()%>/mostcategoriasservlet" >
                <div  class="d-flex justify-content-start mb-4">
                    <button  class="category-button" >
                        <img src="../../assets/Option.png" alt="Icon">
                        Categorías
                    </button>
                </div>
            </a>

            <div class="row g-3">
                <%
                    List<Platillo> platillos = (List<Platillo>) request.getAttribute("platillos");
                    if (platillos != null && !platillos.isEmpty()) {
                        for (Platillo platillo : platillos) {
                %>
                <div class="col-md-3">
                    <div class="menu-card">
                        <img src="<%= platillo.getImagen()%>" alt="<%= platillo.getNombre()%>">
                        <h5><%= platillo.getNombre()%></h5>
                        <p>RM<%= platillo.getPrecioUnitario()%></p>
                        <a href="${pageContext.request.contextPath}/carrito?categoriaId=${categoria.id}">
                            <button class="add-button">
                                <img src="../../assets/Edit.png" alt="Icon" class="icon">Agregar
                            </button>
                        </a>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <p>No hay platillos disponibles en esta categoría.</p>
                <%
                    }
                %>
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
