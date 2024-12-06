<%-- 
    Document   : crud
    Created on : 8/11/2024, 02:49:21 PM
    Author     : arman
--%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.ArrayList" %>
<%@page import="controller.Usuario" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CRUD</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .header-info {
                margin-left: 150px;
                margin-top: 30px;
            }
            .current-date {
                font-size: 14px;
                color: #555;
            }
            .btn-rol {
                background-color: white;
                border: gray;
                color: black;
                padding: 10px;
                font-size: 16px;
                border-radius: 5px;
                margin-top: 10px;
            }
            .btn-rol:hover {
                background-color: gray;
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
        <script>
            function mostrarFechaActual() {
                const fecha = new Date();
                const opciones = {year: 'numeric', month: 'long', day: 'numeric'};
                document.getElementById("fecha-actual").textContent = fecha.toLocaleDateString('es-ES', opciones);
            }
            window.onload = mostrarFechaActual;
        </script>
    </head>
    <body>
        <%@include file="../../components/headerAdmin.jsp" %>
        <%@include file="../../components/sidebarAdmin.jsp" %>    

        <div style="margin-left: 100px; padding: 20px; min-width: 100vh;">
            <div class="row">
                <div class="col-9">
                    <div class="row">
                        <h4>Usuarios</h4>
                    </div>
                    <div class="row">
                        <p>
                            <%= LocalDate.now().format(DateTimeFormatter.ofPattern("EEEE d MMM, yyyy"))%>
                        </p>
                    </div>
                </div>
                <div class="col-3">
                    <h4>Bienvenido</h4>
                </div>
            </div>

            <div class="fieldset">
                <div class="row">
                    <div class="col-10">
                        <h5>Usuarios</h5>
                    </div>
                    <div class="col-2">
                        <button type="button" class="btn btnAdd w-100" onclick="window.location.href = '/foodflow/pages/admin/registrarusuario.jsp'">Agregar</button>
                    </div>
                </div>
                <div class="row mt-4">
                    <table class="table tableCustom">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Apellido Paterno</th>
                                <th>Apellido Materno</th>
                                <th>Correo Electrónico</th>
                                <th>Rol</th>
                            </tr>
                        </thead>

                        <tbody class="table-group-divider">
                            <%
                                ArrayList<Usuario> usuarios = (ArrayList<Usuario>) request.getAttribute("usuarios");
                                if (usuarios != null) {
                                    for (Usuario usuario : usuarios) {
                            %>
                            <tr onclick="window.location.href = '/foodflow/pages/admin/editarusuario.jsp?id=<%= usuario.getId()%>'">
                                <td><%= usuario.getId()%></td>
                                <td><%= usuario.getNombre()%></td>
                                <td><%= usuario.getApellidoPaterno()%></td>
                                <td><%= usuario.getApellidoMaterno()%></td>
                                <td><%= usuario.getCorreo()%></td>
                                <td><%= usuario.getRol()%></td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="7">No hay usuarios registrados.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
