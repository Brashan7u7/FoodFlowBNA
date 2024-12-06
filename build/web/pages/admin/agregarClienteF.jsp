<%-- 
    Document   : agregarClienteF
    Created on : 01-dic-2024, 19:12:45
    Author     : Amanda
    UI18       :  Creación de Usuario Fidelidad (Cajero)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fidelidad | Agregar Cliente</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .font {
                font-family: 'Barlow', sans-serif;
                font-weight: 600;
                font-size: 26px;
                padding-right: 30px;
            }

            .form-control {
                border-color: #EC3718 !important;
                border-radius: 0% !important;
            }

            .formImg {
                border-right: 0;
            }

            .iconForm {
                background-color: #fff !important;
                border-left-color: #fff !important;
                border-left: 0;
            }

            .form-select {
                border-color: #EC3718 !important;
                border-radius: 0% !important;
            }

            .btnAdd {
                margin-top: 10vh;
                background-color: #EC3718 !important;
                color: #fff !important;
                padding-left: 20px !important;
                padding-right: 20px !important;
                box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2);
            }
            
            .alert {
                margin: 50px;
                margin-left: 50px !important;
            }
            
            .modal {
                margin-top: 35vh !important;
                margin-left: 8vh !important;
                display: none;
            }
            
            .modal-dialog {
                border: 4px solid #EC3718 !important;
                border-radius: 10px;
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
                    <h4>Fidelidad | Agregar Cliente</h4>
                    <p><%= LocalDate.now().format(DateTimeFormatter.ofPattern("EEEE d MMM, yyyy"))%></p>
                </div>
            </div>

            <div style="margin-left: 100px; padding: 20px; min-width: 100vh;">
                <form action="<%= request.getContextPath()%>/clienteFcreate" method="POST">
                    <div class="d-flex justify-content-start align-items-center">
                        <div class="col-4 text-end mt-3">
                            <p class="font">Nombre(s):</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input type="text" class="form-control" id="nombre" name="nombre" required>
                        </div>
                    </div>

                    <div class="d-flex justify-content-start align-items-center">
                        <div class="col-4 text-end mt-3">
                            <p class="font">Número de teléfono:</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input title="El número debe tener exactamente 10 dígitos" type="text" class="form-control" id="telefono" name="telefono" maxlength="10" pattern="\d{10}" required>
                        </div>
                    </div>    

                    <div class="d-flex justify-content-start align-items-center">
                        <div class="col-4 text-end mt-3">
                            <p class="font">Nueva Compra:</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input type="number" class="form-control" id="compras" name="compras" min="1" title="Ingresa una cantidad positiva" required>
                        </div>
                    </div>  

                    <div>
                        <h1></h1>
                    </div>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <button type="submit" class="btn btnAdd mx-2">Guardar</button>
                            <a href="${pageContext.request.contextPath}/clienteFview" class="btn btnAdd mx-2">Cancelar</a>
                        </div>
                    </div>
                </form>
                <!-- Modal de Éxito -->
                <div id="successModal" class="modal" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Creado</h5>
                            </div>
                            <div class="modal-body">
                                <p>¡Cliente registrado con éxito!.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <div class="alert alert-danger" role="alert">
            <%= errorMessage%>
        </div>
        <%
            }
        %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script>    
            function toggleSidebar() {
                document.getElementById("mySidebar").classList.toggle("open");
            }
            
            document.addEventListener("DOMContentLoaded", function () {
                const success = <%= request.getAttribute("success") != null ? "true" : "false" %>;
                if (success) {
                    const modal = document.getElementById("successModal");
                    modal.style.display = "block";

                    setTimeout(() => {
                        window.location.href = "<%= request.getContextPath() %>/clienteFview";
                    }, 2000);
                }
            });
        </script>
    </body>
</html>
