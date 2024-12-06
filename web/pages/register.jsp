<%-- 
    Document   : register
    Created on : 16/11/2024, 08:05:51 PM
    Author     : CruzF
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro de Usuario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .container {
                max-width: 600px;
                background: white;
                padding: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }
        </style>
    </head>
    <body>
        <%@include file="../components/header.jsp" %>
        <div class="container">
            <h1>Registro de Usuario</h1>
            <form action="${pageContext.request.contextPath}/access" method="post">
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="apellido_paterno">Apellido Paterno:</label>
                    <input type="text" id="apellido_paterno" name="apellido_paterno" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="apellido_materno">Apellido Materno:</label>
                    <input type="text" id="apellido_materno" name="apellido_materno" class="form-control">
                </div>
                <div class="form-group">
                    <label for="correo">Correo Electrónico:</label>
                    <input type="email" id="correo" name="correo" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="pin">PIN (6 dígitos):</label>
                    <input type="password" id="pin" name="pin" class="form-control" maxlength="6" required>
                </div>
                <div class="form-group">
                    <label for="rol">Rol:</label>
                    <select id="rol" name="rol" class="form-control" required>
                        <option value="cajero">Cajero</option>
                        <option value="mesero">Mesero</option>
                        <option value="cocinero">Cocinero</option>
                        <option value="administrador">Administrador</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary mt-3">Registrar</button>
            </form>
        </div>
    </body>
</html>