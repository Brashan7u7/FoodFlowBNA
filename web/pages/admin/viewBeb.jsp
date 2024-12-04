<%@page import="model.BebidaModel"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.LocalDate, java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Bebidas</title>
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
                font-weight: 500;
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
                padding: 0px !important;
            }

            tr {
                cursor: pointer;
            }

            tr:hover {
                background-color: #f8f9fa;
            }
        </style>
    </head>
    <body>
        <%@include file="../../components/headerAdmin.jsp" %>
        <%@include file="../../components/sidebarAdmin.jsp" %>
        <!-- Contenido principal -->
        <div style="margin-left: 100px; padding: 20px; min-width: 100vh;">
            <div class="row">
                <div class="col-7">
                    <h4>Bebidas</h4>
                    <p>
                        <%= LocalDate.now().format(DateTimeFormatter.ofPattern("EEEE d MMM, yyyy"))%>
                    </p>
                </div>
                <div class="col-2">
                    <div class="dropdown">
                        <button class="btn dropdown-toggle drop" type="button" data-bs-toggle="dropdown">
                            Tipo
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Platillos</a></li>
                            <li><a class="dropdown-item" href="#">Bebidas</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-3">
                    <h4>Bienvenido: Juan</h4>
                </div>
            </div>
            <div class="fieldset">
                <div class="row mb-3">
                    <div class="col-10">
                        <h5>Bebidas</h5>
                    </div>
                    <div class="col-2">
                        <a href="createBeb.jsp"><button type="button" class="btn btnAdd w-100">Agregar</button></a>
                    </div>
                </div>
                <div class="row">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Descripción</th>
                                <th scope="col">Precio Unitario</th>
                                <th scope="col">Categoria</th>
                                <th scope="col">Disponibilidad</th>
                                
                            </tr>
                        </thead>
                        <tbody class="table-group-divider">
                            <%
                                ArrayList<BebidaModel> listaBebidas = (ArrayList<BebidaModel>) request.getAttribute("bebidas");

                                if (listaBebidas != null && !listaBebidas.isEmpty()) {
                                    for (BebidaModel bebida : listaBebidas) {
                            %>
                            <tr onclick="window.location.href = '/foodflow/pages/admin/editBeb?id=<%= bebida.getId()%>'">
                                <th scope="row"><%= bebida.getId()%></th>
                                <td><%= bebida.getNombre()%></td>
                                <td><%= bebida.getDescripcion()%></td>
                                <td><%= bebida.getPrecio_unitario()%></td>
                                <td><%= bebida.getCategoriaNombre()%></td>
                                <td><%= bebida.isDisponibilidad()%></td>
                                
                                
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="4" class="text-center">No hay bebidas registradas.</td>
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
            function toggleSidebar() {
                document.getElementById("mySidebar").classList.toggle("open");
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>