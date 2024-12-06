<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="controller.Usuario"%>
<%@page import="model.UsuarioDAO"%>
<%
    // Obtener el ID del usuario desde los parámetros de la solicitud
    String idUsuarioParam = request.getParameter("id");
    Usuario usuario = null;

    if (idUsuarioParam != null) {
        try {
            int idUsuario = Integer.parseInt(idUsuarioParam);
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuario = usuarioDAO.obtenerUsuarioPorId(idUsuario);
        } catch (NumberFormatException e) {
            System.err.println("ID de usuario inválido: " + e.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Usuario</title>
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

            .btnUpdate {
                margin-top: 5vh;
                background-color: #EC3718 !important;
                color: #fff !important;
                width: 120px !important;
                box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2);
            }

            .btnDelete {
                margin-left: 10vh;
                margin-top: 5vh;
                background-color: #EC3718 !important;
                color: #fff !important;
                width: 120px !important;
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
            <div class="login-form">
                <%
                    if (usuario != null) {
                %>
                <form action="/foodflow/editarusuario" method="post">
                    <!-- Campo oculto para el ID -->
                    <input type="hidden" name="id" value="<%= usuario.getId() %>">

                    <div class="d-flex justify-content-start align-items-center">
                        <div class="col-4 text-end mt-3">
                            <p class="font">Nombre(s):</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input class="form-control" type="text" id="nombre" name="nombre" value="<%= usuario.getNombre()%>" required>
                        </div>
                    </div>
                    <div class="d-flex justify-content-start">
                        <div class="col-4 text-end">
                            <p class="font">Apellido Paterno:</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input class="form-control" type="text" id="apellidoPaterno" name="apellido_paterno" value="<%= usuario.getApellidoPaterno() %>" required>
                        </div>
                    </div>
                    <div class="d-flex justify-content-start">
                        <div class="col-4 text-end">
                            <p class="font">Apellido Materno:</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input class="form-control" type="text" id="apellidoMaterno" name="apellido_materno" value="<%= usuario.getApellidoMaterno() %>" required>
                        </div>
                    </div>
                    <div class="d-flex justify-content-start">
                        <div class="col-4 text-end">
                            <p class="font">Correo electrónico:</p>
                        </div>
                        <div class="col-4 ms-2">
                            <input class="form-control" type="email" class="form-control" id="correo" name="correo" value="<%= usuario.getCorreo() %>" required>
                        </div>
                    </div>
                    <div class="d-flex justify-content-start">
                        <div class="col-4 text-end">
                            <p class="font">Rol:</p>
                        </div>
                        <div class="col-4 ms-2">
                            <select class="form-select" id="rol" name="rol" required>
                                <option value="" disabled <%= usuario.getRol() == null ? "selected" : "" %>>Seleccione un rol</option>
                                <option value="administrador" <%= "administrador".equals(usuario.getRol()) ? "selected" : "" %>>Administrador</option>
                                <option value="cocinero" <%= "cocinero".equals(usuario.getRol()) ? "selected" : "" %>>Cocina</option>
                                <option value="mesero" <%= "mesero".equals(usuario.getRol()) ? "selected" : "" %>>Mesero</option>
                                <option value="cajero" <%= "cajero".equals(usuario.getRol()) ? "selected" : "" %>>Cajero</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-5 offset-md-4">
                            <button class="btn btnUpdate" type="submit" class="btn-login">Actualizar</button>
                        </div>
                    </div>
                </form>
                <form action="/foodflow/eliminarusuario" method="post">
                    <input type="hidden" name="id" value="<%= usuario.getId() %>">
                    <button type="submit" class="btn btnDelete"">Eliminar</button>
                </form>
                <%
                    } else {
                %>
                <p>No se encontró el usuario. <a href="/foodflow/usuariosservlet">Volver</a></p>
                <%
                    }
                %>
                <div id="messageModal" class="modal" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 id="modalTitle" class="modal-title"></h5>
                            </div>
                            <div class="modal-body">
                                <p id="modalMessage"></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
