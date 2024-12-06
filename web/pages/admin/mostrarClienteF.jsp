<%-- 
    Document   : mostrarClienteF
    Created on : 01-dic-2024, 19:12:45
    Author     : Amanda
    UI13       : Vista usuarios fidelidad
--%>

<%@page import="model.ClienteFModel"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clientes fidelidad</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .drop {
                background-color: #F6F6F6 !important;
                border: 2px solid rgba(0, 0, 0, 0.5) !important;
                width: 150px;
            }

            .fieldset {
                background-color: #F6F6F6 !important;
                border: 2px solid rgba(0, 0, 0, 0.5) !important;
                padding: 8vh;
                width: 81vw;
            }

            .btnAdd {
                background-color: #EC3718 !important;
                color: #fff !important;
                padding-left: 20px !important;
                padding-right: 20px !important;
                box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2);
            }

            .table, .table th, .table td {
                background-color: transparent !important;
                font-weight:  500;
            }

            a {
                text-decoration: none !important;
                color: #fff !important;
            }

            .dropdown-item {
                color: #000 !important;
            }
            
            .btn-light {
                margin: 0px !important;
                padding-top: 0px !important;
                padding-bottom: 0px !important;
            }
            
            tr {
                cursor: pointer;
            }

            tr:hover {
                background-color: #fff;
            }
        </style>
    </head>
    <body>
        <%@include file="../../components/headerAdmin.jsp" %>
        <%@include file="../../components/sidebarAdmin.jsp" %>
        
        <!-- Contenido de la página -->
        <div style="margin-left: 100px; padding: 20px; min-width: 100vh;">
            <div class="row">
                <div class="col-6">
                    <div class="row">
                        <h4>Fidelidad</h4>
                    </div>
                    <div class="row">
                        <p>
                            <%= LocalDate.now().format(DateTimeFormatter.ofPattern("EEEE d MMM, yyyy")) %>
                        </p>
                    </div>
                </div>
                
                <div class="col-3">
                </div>      
                
                <div class="col-3">
                    <h4>Bienvenido</h4>
                </div>
            </div>
            <div class="fieldset">
                <div class="row">
                    <div class="col-8">
                        <h5>Clientes con Fidelidad</h5>
                    </div>
                    
                    <div class="col-2"></div>
                    <div class="col-2">
                        <a href="${pageContext.request.contextPath}/clienteFcreate"><button type="button" class="btn btnAdd w-100">Agregar</button></a>
                    </div>
                </div>
                <div class="row mt-4">
                    <table class="table tableCustom">
                        <thead>
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Teléfono</th>
                                <th scope="col">Número de Compras</th>
                            </tr>
                        </thead>
                        <tbody class="table-group-divider">
                            <%
                                ArrayList<ClienteFModel> clientes = (ArrayList<ClienteFModel>) request.getAttribute("clientes");

                                if (clientes != null && !clientes.isEmpty()) {
                                    for (ClienteFModel cliente : clientes) {
                            %>
                            <tr onclick="window.location.href = '/foodflow/clienteFupdate?id=<%= cliente.getId()%>'"> 
                                <th scope="row"><%= cliente.getId() %></th>
                                <td><%= cliente.getNombre() %></td>
                                <td><%= cliente.getTelefono() %></td>
                                <td><%= cliente.getCompras() %></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="4">No hay clientes registrados.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script>
            // Función para abrir/cerrar el sidebar
            function toggleSidebar() {
                document.getElementById("mySidebar").classList.toggle("open");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
