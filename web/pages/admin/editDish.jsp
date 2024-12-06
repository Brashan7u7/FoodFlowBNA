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
        <title>Editar Platillo</title>
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

            .btnUpdateImg {
                margin: 40px;
                background-color: #EC3718 !important;
                color: #fff !important;
                width: 175px !important;
                box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.2);
            }

            input:disabled {
                background-color: #fff !important;
                cursor: not-allowed;
            }

            .imgDish {
                width: 250px;             
                height: 250px;            
                object-fit: cover;        
                margin: 0 auto;          
                display: block; 
                margin-bottom: 2vh;
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
            <%
                String id = request.getParameter("id");
                String nombre = "";
                String imagen = "";
                String descripcion = "";
                Double precio_unitario = 0.0;
                int categoria_id = 0;
                Boolean disponibilidad = true;
                ConnectionBD conexion = new ConnectionBD();
                Connection connection = conexion.getConnectionBD();
                PreparedStatement statement = null;
                ResultSet resultSet = null;
                try {
                    String sql = "SELECT nombre, imagen, descripcion, precio_unitario, categoria_id, disponibilidad"
                            + " FROM platillos WHERE id LIKE ?";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, id);
                    resultSet = statement.executeQuery();
                    if (resultSet.next()) {
                        nombre = resultSet.getString("nombre");
                        imagen = resultSet.getString("imagen");
                        descripcion = resultSet.getString("descripcion");
                        precio_unitario = resultSet.getDouble("precio_unitario");
                        categoria_id = resultSet.getInt("categoria_id");
                        disponibilidad = resultSet.getBoolean("disponibilidad");
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
            <form action="${pageContext.request.contextPath}/editDish" method="post"> 
                <div class="d-flex justify-content-start align-items-center">
                    <div class="col-4 text-end mt-3">
                        <p class="font">Nombre:</p>
                    </div>
                    <div class="col-4 ms-2">
                        <input class="form-control" name="txt_nombre" id="txt_nombre" type="text" value="<%=nombre%>" required>
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
                        <p class="font">Descripción:</p>
                    </div>
                    <div class="col-4 ms-2">
                        <textarea class="form-control" rows="3" name="txt_descripcion" id="txt_descripcion" required><%=descripcion%></textarea>
                    </div>
                </div>
                <div class="d-flex justify-content-start mt-3">
                    <div class="col-4 text-end">
                        <p class="font">Precio unitario:</p>
                    </div>
                    <div class="col-4 ms-2">
                        <input class="form-control" type="number" value="<%=precio_unitario%>" name="txt_precio_unitario" id="txt_precio_unitario" min="1" title="Ingresa una cantidad positiva" required>
                    </div>
                </div>
                <div class="d-flex justify-content-start">
                    <div class="col-4 text-end">
                        <p class="font">Categoria:</p>
                    </div>
                    <div class="col-4 ms-2">
                        <select class="form-select" name="txt_categoria_id" id="txt_categoria_id" required>
                            <%
                                ArrayList<CategoriaModel> listaCategorias = (ArrayList<CategoriaModel>) request.getAttribute("categorias");

                                if (listaCategorias != null && !listaCategorias.isEmpty()) {
                                    for (CategoriaModel categoria : listaCategorias) {
                            %>
                            <option value="<%= categoria.getId()%>" <%= categoria_id == categoria.getId() ? "selected" : ""%>>
                                <%= categoria.getNombre()%>
                            </option>

                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="7">No hay categorias registrados.</td>
                            </tr>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="d-flex justify-content-start">
                    <div class="col-4 text-end">
                        <p class="font">Disponibilidad:</p>
                    </div>
                    <div class="col-4 ms-2">
                        <select class="form-select" name="txt_disponibilidad" id="txt_disponibilidad" required>
                            <option selected value="1" <%= disponibilidad == true ? "selected" : "" %>>Activo</option>
                            <option value="2" <%= disponibilidad == false ? "selected" : "" %>>Inactivo</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5 offset-md-4">
                        <button type="button" onclick="actualizarPlatillo(<%=id%>)" class="btn btnUpdate">Actualizar</button>
                        <button type="button" class="btn btnDelete" onclick="eliminarPlatillo(<%=id%>)">
                            Eliminar
                        </button>
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
            // Función para abrir/cerrar el sidebar
            function toggleSidebar() {
                document.getElementById("mySidebar").classList.toggle("open");
            }
            
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
            
            function actualizarPlatillo(id) {
                var datos;
                const nombre = document.getElementById("txt_nombre").value;
                const imagenActual = document.getElementById("imagenActual").value;
                var imagen = document.getElementById("txt_imagen").value;
                const descripcion = document.getElementById("txt_descripcion").value;
                const precio_unitario = document.getElementById("txt_precio_unitario").value;
                const categoria_id = document.getElementById("txt_categoria_id").value;
                const disponibilidad = document.getElementById("txt_disponibilidad").value;
               
                if (!nombre || !descripcion || !precio_unitario) {
                    mostrarModal("error", "Error al actualizar el platillo. Verifica los datos ingresados.");
                    return;
                }
                
                if (imagen.length > 0) {
                    const fileName = imagen.split("\\").pop();  
                    imagen = `/foodflow/images/`+fileName;
                }
    
                if (imagen.length === 0){
                    datos = {
                      nombre: nombre,
                      imagen: imagenActual,
                      descripcion: descripcion,
                      precio_unitario: precio_unitario,
                      categoria_id: categoria_id,
                      disponibilidad: disponibilidad,
                      id: id
                    };  
                } else {
                    datos = {
                      nombre: nombre,
                      imagen: imagen,
                      descripcion: descripcion,
                      precio_unitario: precio_unitario,
                      categoria_id: categoria_id,
                      disponibilidad: disponibilidad,
                      id: id
                    };
                }
                fetch(`editDish?id=` + id , {
                    method: "PUT",
                    body: JSON.stringify(datos),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(() => {
                    mostrarModal("success", "¡Platillo actualizado con éxito!");
                    setTimeout(() => {
                        window.location.href = "<%= request.getContextPath()%>/platillos";
                    }, 2000);
                })
                .catch(error => {
                    console.error('Error:', error);
                    mostrarModal("error", "Hubo un problema al actualizar el platillo. Inténtalo nuevamente.");
                });
            }

            function eliminarPlatillo(id) {
                if (confirm("¿Estás seguro de que quieres eliminar este platillo?")) {
                    fetch(`editDish?id=` + id, {
                        method: 'DELETE'
                    }).then(response => {
                        if (response.ok) {
                            mostrarModal("success", "¡Platillo eliminado con éxito!");
                            setTimeout(() => {
                                window.location.href = "<%= request.getContextPath()%>/platillos";
                            }, 1000);
                        } else {
                            alert('Error al eliminar el platillo');
                        }
                    }).catch(error => console.error('Error:', error));
                }
            }
        </script> 
    </body>
</html>
