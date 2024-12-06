<%-- 
    Document   : registrar
    Created on : 7/11/2024, 08:03:54 PM
    Author     : arman
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

        <div style="margin-left: 100px; padding: 20px; min-width: 100vh;"> 
            <!-- Formulario de registro de usuario -->
            <div class="login-form">
                <form action="/foodflow/usuariosservlet" method="post">
                    <div class="d-flex justify-content-start align-items-center">
                        <div class="col-4 text-end mt-3">
                            <p class="font">Nombre(s):</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input class="form-control" type="text" id="firstName" name="firstName" required>
                        </div>
                    </div>
                    <div class="d-flex justify-content-start">
                        <div class="col-4 text-end">
                            <p class="font">Apellido Paterno:</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input class="form-control" type="text" id="lastName" name="lastName" required>
                        </div>
                    </div>
                    <div class="d-flex justify-content-start">
                        <div class="col-4 text-end">
                            <p class="font">Apellido Materno:</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input class="form-control" type="text" id="middleName" name="middleName" required>
                        </div>
                    </div>
                    <div class="d-flex justify-content-start">
                        <div class="col-4 text-end">
                            <p class="font">Correo electrónico:</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input class="form-control" type="email" class="form-control" id="email" name="email" required>
                        </div>
                    </div>
                    <div class="d-flex justify-content-start">
                        <div class="col-4 text-end">
                            <p class="font">PIN:</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input type="password" class="form-control" id="pin" name="pin" required>
                        </div>
                    </div>
                    <div class="d-flex justify-content-start">
                        <div class="col-4 text-end">
                            <p class="font">Rol:</p>
                        </div>
                        <div class="col-4 ms-2">
                            <select class="form-select" id="role" name="role" required>
                                <option value="" disabled selected>Seleccione un rol</option>
                                <option value="administrador">Administrador</option>
                                <option value="cocinero">Cocina</option>
                                <option value="mesero">Mesero</option>
                                <option value="cajero">Cajero</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 offset-md-5">
                            <button type="submit" class="btn btnAdd">Agregar</button>
<!--                            <button type="button" class="btn-add" onclick="window.location.href = '/foodflow/pages/admin/crud.jsp'">Regresar</button>-->
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>