<%-- 
    Document   : updateClienteF
    Created on : 01-dic-2024, 19:12:45
    Author     : Amanda
    UI14       : Edición usuarios fidelidad (Admin)
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="configuration.ConnectionBD"%>
<%@page import="model.ClienteFModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fidelidad | Editar perfil de usuario</title>
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
        <%
            String id = request.getParameter("id");
            String nombre = "";
            String telefono = "";
            int compras = 0;
            ConnectionBD conexion = new ConnectionBD();
            Connection connection = conexion.getConnectionBD();
            PreparedStatement statement = null;
            ResultSet resultSet = null;
            try {
                String sql = "SELECT nombre, telefono, compras"
                        + " FROM clientes_fidelidad WHERE id LIKE ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, id);
                resultSet = statement.executeQuery();
                if (resultSet.next()) {
                    nombre = resultSet.getString("nombre");
                    telefono = resultSet.getString("telefono");
                    compras = resultSet.getInt("compras");
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
        <!-- Contenido de la página -->
        <div style="margin-left: 100px; padding: 20px; min-width: 100vh;">
            <div class="row">
                <div class="col-6">
                    <h4>Fidelidad | Actualizar Cliente</h4>
                    <p><%= LocalDate.now().format(DateTimeFormatter.ofPattern("EEEE d MMM, yyyy"))%></p>
                </div>
            </div>
            <form action="${pageContext.request.contextPath}/clienteFupdate" method="post"> 
                <div class="d-flex justify-content-start align-items-center" style="margin-top: 100px;">
                    <div class="col-4 text-end mt-3">
                        <p class="font">Nombre(s):</p>
                    </div>
                    <div class="col-4 ms-2">
                        <input type="text" class="form-control" id="nombre" name="nombre" value="<%=nombre%>" required>
                    </div>
                </div>
                <div class="d-flex justify-content-start align-items-center">
                    <div class="col-4 text-end mt-3">
                        <p class="font">Número de teléfono:</p>
                    </div>
                    <div class="col-4 ms-2">
                        <input title="El número debe tener exactamente 10 dígitos" value="<%=telefono%>" type="text" class="form-control" id="telefono" name="telefono" maxlength="10" pattern="\d{10}" required>
                    </div>
                </div>    

                <div class="d-flex justify-content-start align-items-center">
                    <div class="col-4 text-end mt-3">
                        <p class="font">Nueva Compra:</p>
                    </div>
                    <div class="col-4 ms-2">
                        <input type="number" class="form-control" id="compras" name="compras" value="<%=compras%>" min="1" title="Ingresa una cantidad positiva" required>
                    </div>
                </div>  
                <div class="row">
                    <div class="col-md-5 offset-md-4">
                        <button type="button" onclick="actualizarCliente(<%=id%>)" class="btn btnUpdate">Actualizar</button>
                        <button type="button" class="btn btnDelete" onclick="eliminarCliente(<%=id%>)">
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script>
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
            
            function actualizarCliente(id) {
                var datos;
                const nombre = document.getElementById("nombre").value;
                const telefono = document.getElementById("telefono").value;
                const compras = document.getElementById("compras").value;
               
                if (!nombre || !telefono || !compras || compras < 1) {
                    mostrarModal("error", "Error al actualizar el cliente. Verifica los datos ingresados.");
                    return;
                }
    
                datos = {
                    nombre: nombre,
                    telefono: telefono,
                    compras: compras,
                    id: id
                }; 
                fetch(`clienteFupdate?id=` + id , {
                    method: "PUT",
                    body: JSON.stringify(datos),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(() => {
                    mostrarModal("success", "¡Cliente actualizado con éxito!");
                    setTimeout(() => {
                        window.location.href = "<%= request.getContextPath()%>/clienteFview";
                    }, 2000);
                })
                .catch(error => {
                    console.error('Error:', error);
                    mostrarModal("error", "Hubo un problema al actualizar el cliente. Inténtalo nuevamente.");
                });
            }

            function eliminarCliente(id) {
                if (confirm("¿Estás seguro de que quieres eliminar el cliente?")) {
                    fetch(`clienteFupdate?id=` + id, {
                        method: 'DELETE'
                    }).then(response => {
                        if (response.ok) {
                            mostrarModal("success", "¡Cliente eliminado con éxito!");
                            setTimeout(() => {
                                window.location.href = "<%= request.getContextPath()%>/clienteFview";
                            }, 1000);
                        } else {
                            alert('Error al eliminar el cliente');
                        }
                    }).catch(error => console.error('Error:', error));
                }
            }
        </script>
    </body>
</html>
