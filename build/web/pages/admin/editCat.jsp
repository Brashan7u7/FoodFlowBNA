<%@page import="model.CategoriaModel"%>
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
        <title>Editar Categoría</title>
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

            .imgCategory {
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
                String nombre = "";
                String imagen = "";
                String estatus = "";

                ConnectionBD conexion = new ConnectionBD();
                Connection connection = conexion.getConnectionBD();
                PreparedStatement statement = null;
                ResultSet resultSet = null;
                try {
                    String sql = "SELECT nombre, imagen, estatus FROM categorias_bebidas WHERE id = ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, id);
                    resultSet = statement.executeQuery();
                    if (resultSet.next()) {
                        nombre = resultSet.getString("nombre");
                        imagen = resultSet.getString("imagen");
                        estatus = resultSet.getString("estatus");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) {
                            resultSet.close();
                        }
                        if (statement != null) {
                            statement.close();
                        }
                        if (connection != null) {
                            connection.close();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
            
            <div class="d-flex justify-content-start align-items-center">
                <div class="col-4 text-end mt-3">
                    <p class="font">Nombre(s):</p>
                </div>
                <div class="col-4 ms-2">
                    <input class="form-control" id="txt_nombre" type="text" name="nombre" value="<%= nombre%>">
                </div>
            </div>
            <div class="d-flex justify-content-start">
                <div class="col-4 text-end">
                    <p class="font">Imagen:</p>
                </div>
                <div class="col-4 ms-2">
                    <div class="row">
                        <div class="col-7">
                            <img src="<%= request.getContextPath() + "/" + imagen%>" name="imagen" style="width: 370px; height: 211px;" class="imgCategory" alt="Categoría"/>
                        </div>
                        <div class="col-5" s>
                            <!-- Botón para actualizar la imagen -->
                            <button onclick="seleccionarImagen()" class="btn btnAction">Actualizar imagen</button>
                            <!-- Input oculto para seleccionar la imagen -->
                            <input type="file" id="txt_imagen" name="txt_imagen" class="form-control" style="display:none" onchange="mostrarImagen()">
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 offset-md-4">
                    <button onclick="actualizarCategoria()" class="btn btnAction">Actualizar</button>
                    <button onclick="eliminarCategoria()" class="btn btnAction">Eliminar</button>
                    <button onclick="desactivarCategoria()" class="btn btnAction">Desactivar</button>
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
                    const img = document.querySelector(".imgCategory");
                    img.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }




            function eliminarCategoria() {
                const id = "<%= id%>";
                if (confirm(`¿Estás seguro de que quieres eliminar esta categoría?`)) {
                    fetch(`/foodflow/pages/admin/editCat?id=${id}`, {
                        method: 'DELETE',
                    })
                            .then(response => {
                                if (response.ok) {
                                    alert("Categoría eliminada con éxito");
                                    window.location.href = "/foodflow/pages/admin/viewCat";
                                } else {
                                    alert("Error al eliminar la categoría");
                                }
                            })
                            .catch(error => console.error("Error:", error));
                }
            }

            function actualizarCategoria() {
                const id = "<%= id%>";
                const nombre = document.getElementById("txt_nombre").value.trim();
                const imagen = document.getElementById("txt_imagen").files[0];

                if (!nombre) {
                    alert("El nombre no puede estar vacío.");
                    return;  // No enviar el formulario si el nombre es vacío
                }

                const formData = new FormData();
                formData.append("id", id);
                formData.append("nombre", nombre);  // Asegúrate de que el valor de 'nombre' no sea vacío
                if (imagen) {
                    formData.append("imagen", imagen);
                }

                fetch(`/foodflow/pages/admin/editCat?id=${id}`, {
                    method: 'POST',
                    body: formData,
                })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Error al actualizar la categoría');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                alert("Categoría actualizada con éxito");
                                window.location.href = "/foodflow/pages/admin/viewCat";
                            } else {
                                alert("Error al actualizar la categoría: " + data.message);
                            }
                        })
                        .catch(error => {
                            console.error("Error:", error);
                            alert("Hubo un error al enviar la solicitud.");
                        });
            }




            function desactivarCategoria() {
                const id = "<%= id%>";
                if (confirm(`¿Estás seguro de que quieres desactivar esta categoría?`)) {
                    fetch(`/foodflow/pages/admin/editCat?id=${id}`, {
                        method: 'PUT',
                    })
                            .then(response => {
                                if (response.ok) {
                                    alert("Categoría desactivada con éxito");
                                    location.reload();
                                } else {
                                    alert("Error al desactivar la categoría");
                                }
                            })
                            .catch(error => console.error("Error:", error));
                }
            }
        </script>
    </body>
</html>
