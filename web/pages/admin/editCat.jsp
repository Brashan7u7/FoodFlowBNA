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

            .btnUpdateImg {
                margin: 40px;
                background-color: #EC3718 !important;
                color: #fff !important;
                width: 175px !important;
                box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2);
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
                margin-left: 20vh;
                box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2);
            }

            .imgCategory {
                max-width: 250px;
                margin-bottom: 20px;
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

            .imgDish {
                width: 250px;
                height: 250px;
                object-fit: cover;
                margin: 0 auto;
                display: block;
                margin-bottom: 2vh;
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
            
            <form action="${pageContext.request.contextPath}/pages/admin/editCat" method="post">
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
                            <div class="col-6">
                                <img src="<%=imagen%>" class="imgDish" alt="Platillo"/>
                                <input type="hidden" name="imagenActual" id="imagenActual" value="<%=imagen%>" accept=".jpg,.png">
                            </div>
                            <div class="col-6">
                                <label for="txt_imagen" class="btn btnUpdateImg">Actualizar Imagen <i class="bi bi-upload"></i></label>
                                <input type="file" id="txt_imagen" name="txt_imagen" class="d-none" accept=".jpg,.png">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-start">
                    <div class="col-4 text-end">
                        <p class="font">Estatus:</p>
                    </div>
                    <div class="col-4 ms-2">
                        <select class="form-select" name="txt_estatus" id="txt_estatus" required>
                            <option value="activo" <%= estatus.equals("activo") ? "selected" : ""%>>Activo</option>
                            <option value="inactivo" <%= estatus.equals("inactivo") ? "selected" : ""%>>Inactivo</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 offset-md-4">
                        <button type="button" onclick="actualizarCategoria(<%=id%>)" class="btn btnAction">Actualizar</button>
                    </div>
                </div>
            </form>
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

        <script>
            function mostrarModal(tipo, mensaje) {
                const modal = document.getElementById("messageModal");
                const modalTitle = document.getElementById("modalTitle");
                const modalMessage = document.getElementById("modalMessage");
                if (tipo === "success") {
                    modalTitle.textContent = "¡Éxito!";
                    modalTitle.className = "modal-title text-success";
                } else if (tipo === "error") {
                    modalTitle.textContent = "Error";
                    modalTitle.className = "modal-title text-danger";
                }
                modalMessage.textContent = mensaje;
                modal.style.display = "block";

                setTimeout(() => {
                    modal.style.display = "none";
                }, 1500);
            }

            function actualizarCategoria(id) {
                const nombre = document.getElementById("txt_nombre").value;
                const imagenActual = document.getElementById("imagenActual").value;
                const imagen = document.getElementById("txt_imagen").value;
                const estatus = document.getElementById("txt_estatus").value;

                if (!nombre || !estatus) {
                    mostrarModal("error", "Error al actualizar la categoría. Verifica los datos ingresados.");
                    return;
                }

                let datos;
                if (imagen.length > 0) {
                    const fileName = imagen.split("\\").pop();
                    datos = {
                        nombre: nombre,
                        imagen: `/foodflow/images/` + fileName,
                        estatus: estatus,
                        id: id
                    };
                } else {
                    datos = {
                        nombre: nombre,
                        imagen: imagenActual,
                        estatus: estatus,
                        id: id
                    };
                }

                fetch(`editCat?id=` + id, {
                    method: "PUT",
                    body: JSON.stringify(datos),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(() => {
                    mostrarModal("success", "¡Categoría actualizada con éxito!");
                    setTimeout(() => {
                        window.location.href = "<%= request.getContextPath()%>/pages/admin/viewCat";
                    }, 2000);
                })
                .catch(error => {
                    console.error('Error:', error);
                    mostrarModal("error", "Hubo un problema al actualizar la categoría. Inténtalo nuevamente.");
                });
            }
        </script>
    </body>
</html>
