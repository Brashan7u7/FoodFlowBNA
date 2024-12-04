<%@page import="model.BebidaModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="configuration.ConnectionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Bebida</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            /* Estilos personalizados */
            .font {
                font-family: 'Barlow', sans-serif;
                font-weight: 600;
                font-size: 26px;
                padding-right: 30px;
            }

            .form-control, .form-select {
                border-color: #EC3718 !important;
                border-radius: 0 !important;
            }

            .btnAction {
                margin-top: 5vh;
                background-color: #EC3718 !important;
                color: #fff !important;
                width: 120px !important;
                box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2);
            }

            .imgDrink {
                max-width: 250px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="../../components/headerAdmin.jsp" %>
        <%@include file="../../components/sidebarAdmin.jsp" %>

        <div style="margin-left: 100px; padding: 20px; min-width: 100vh;">
            <%
                String id = request.getParameter("id");
                String nombre = "", descripcion = "", imagen = "", categoriaNombre = "";
                double precio_unitario = 0;
                boolean disponibilidad = false;

                ConnectionBD conexion = new ConnectionBD();
                Connection connection = conexion.getConnectionBD();
                PreparedStatement statement = null;
                ResultSet resultSet = null;
                try {
                    String sql = "SELECT b.nombre, b.descripcion, b.imagen, b.precio_unitario, b.disponibilidad, c.nombre AS categoria_nombre " +
                                 "FROM bebidas b INNER JOIN categorias_bebidas c ON b.categoria_id = c.id WHERE b.id = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, id);
                    resultSet = statement.executeQuery();
                    if (resultSet.next()) {
                        nombre = resultSet.getString("nombre");
                        descripcion = resultSet.getString("descripcion");
                        imagen = resultSet.getString("imagen");
                        precio_unitario = resultSet.getDouble("precio_unitario");
                        disponibilidad = resultSet.getBoolean("disponibilidad");
                        categoriaNombre = resultSet.getString("categoria_nombre");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
            
            <div class="d-flex justify-content-start align-items-center">
                <div class="col-4 text-end mt-3">
                    <p class="font">Nombre:</p>
                </div>
                <div class="col-4 ms-2">
                    <input class="form-control" id="txt_nombre" type="text" name="nombre" value="<%= nombre %>">
                </div>
            </div>

            <div class="d-flex justify-content-start align-items-center">
                <div class="col-4 text-end mt-3">
                    <p class="font">Descripción:</p>
                </div>
                <div class="col-4 ms-2">
                    <textarea class="form-control" id="txt_descripcion" name="descripcion"><%= descripcion %></textarea>
                </div>
            </div>

            <div class="d-flex justify-content-start">
                <div class="col-4 text-end">
                    <p class="font">Imagen:</p>
                </div>
                <div class="col-4 ms-2">
                    <div class="row">
                        <div class="col-7">
                            <img src="<%= request.getContextPath() + "/" + imagen %>" class="imgDrink" alt="Bebida"/>
                        </div>
                        <div class="col-5">
                            <button onclick="seleccionarImagen()" class="btn btnAction">Actualizar imagen</button>
                            <input type="file" id="txt_imagen" name="imagen" class="form-control" style="display:none" onchange="mostrarImagen()">
                        </div>
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-start align-items-center">
                <div class="col-4 text-end mt-3">
                    <p class="font">Precio Unitario:</p>
                </div>
                <div class="col-4 ms-2">
                    <input class="form-control" id="txt_precio" type="number" step="0.01" name="precio_unitario" value="<%= precio_unitario %>">
                </div>
            </div>

            <div class="d-flex justify-content-start align-items-center">
                <div class="col-4 text-end mt-3">
                    <p class="font">Categoría:</p>
                </div>
                <div class="col-4 ms-2">
                    <input class="form-control" id="txt_categoria" type="text" name="categoria" value="<%= categoriaNombre %>" readonly>
                </div>
            </div>

            <div class="d-flex justify-content-start align-items-center">
                <div class="col-4 text-end mt-3">
                    <p class="font">Disponibilidad:</p>
                </div>
                <div class="col-4 ms-2">
                    <select class="form-select" id="txt_disponibilidad" name="disponibilidad">
                        <option value="true" <%= disponibilidad ? "selected" : "" %>>Disponible</option>
                        <option value="false" <%= !disponibilidad ? "selected" : "" %>>Agotado</option>
                    </select>
                </div>
            </div>

            <div class="row mt-5">
                <div class="col-md-6 offset-md-4">
                    <button onclick="actualizarBebida()" class="btn btnAction">Actualizar</button>
                    <button onclick="eliminarBebida('<%=id%>')" class="btn btnAction">Eliminar</button>
                </div>
            </div>
        </div>

        <script>
            function seleccionarImagen() {
                document.getElementById("txt_imagen").click();
            }

            function mostrarImagen() {
                const file = document.getElementById("txt_imagen").files[0];
                const reader = new FileReader();
                reader.onload = function (e) {
                    document.querySelector(".imgDrink").src = e.target.result;
                };
                reader.readAsDataURL(file);
            }

            function actualizarBebida() {
                alert("Función para actualizar bebida...");
            }

            function eliminarBebida(id) {
                console.log(`eliminarPlatillo?id=` + id);
                if (confirm("¿Estás seguro de que quieres eliminar este platillo?")) {
                    fetch(`editBeb?id=` + id, {
                        method: 'DELETE'
                    }).then(response => {
                        if (response.ok) {
                            alert('Platillo eliminado exitosamente');
                             window.location.href = "/foodflow/pages/admin/viewBeb";
                        } else {
                            alert('Error al eliminar la bebida');
                        }
                    }).catch(error => console.error('Error:', error));
                }
                
            }
        </script>
    </body>
</html>
