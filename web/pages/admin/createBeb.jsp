<%@page import="java.util.ArrayList"%>
<%@page import="model.CategoriaModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bebidas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .font {
                font-family: 'Barlow', sans-serif;
                font-weight: 600;
                font-size: 26px;
                padding-right: 30px;
                text-align: end;
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
        </style>
    </head>
    <body>
        <%@include file="../../components/headerAdmin.jsp" %>
        <%@include file="../../components/sidebarAdmin.jsp" %>

        <div style="margin-left: 100px; padding: 20px; min-width: 100vh;  height: 100vh; align-content: center;">
            <form action="/foodflow/pages/admin/createBeb" method="POST" enctype="multipart/form-data">

                <div class="d-flex justify-content-start align-items-center">
                    <div class="col-4 text-end mt-3">
                        <p class="font">Nombre(s):</p>
                    </div>
                    <div class="col-4 ms-2">
                        <input class="form-control" type="text" name="txt_nombre" id="txt_nombre" max="100">
                    </div>
                </div>
                
                <div class="d-flex justify-content-start align-items-center">
                    <div class="col-4 text-end mt-3">
                        <p class="font">Descripción:</p>
                    </div>
                    <div class="col-4 ms-2">
                        <input class="form-control" type="text" name="txt_descripcion" id="txt_descripcion">
                    </div>
                </div>

                <div class="d-flex justify-content-start  " style="padding-left: 3px;">
                    <div class="col-4 text-end">
                        <p class="font">Imagen:</p>
                    </div>
                    <div class="col-4 ms-2">
    <div class="input-group mb-3" style="position: relative;">
        <!-- Input de archivo -->
        <input type="file" class="form-control formImg" name="image" id="image" style="opacity: 0; position: absolute; top: 0; left: 0; width: 100%; height: 100%; cursor: pointer; z-index: 2;" onchange="updateFileName()">
        <!-- Contenedor para el borde y el icono -->
        <div class="input-group-prepend" style="border: 1px solid #EC3718; border-radius: 0px; height: 40px; width: 459px; display: flex; align-items: center;">
            <span class="input-group-text" style="background-color: transparent; border: none; margin-left: auto">
                <img src="../../assets/icons/upload.png" alt="Icono de subir" style="width: 24px; height: 24px;">
            </span>
            <span class="input-group-text" style="background-color: transparent; border: none;"></span>
        </div>
    </div>
 
</div>

                </div>
                <div class="d-flex justify-content-start align-items-center">
                    <div class="col-4 text-end mt-3">
                        <p class="font">Precio Unitario:</p>
                    </div>
                    <div class="col-4 ms-2">
                        <input class="form-control" type="number" name="txt_precio" id="txt_precio" min="0">
                    </div>
                </div>
                
                <div class="d-flex justify-content-start align-items-center">
                    <div class="col-4 text-end mt-3">
                        <p class="font">Categoria:</p>
                    </div>
                    <div class="col-4 ms-2">
                        <select class="form-control border-danger" id="inputCategoria" name="categoria">
                          <option selected>Seleccione una categoría</option>
                            <%
                                ArrayList<CategoriaModel> listaCategorias = (ArrayList<CategoriaModel>) request.getAttribute("categorias");

                                if (listaCategorias != null && !listaCategorias.isEmpty()) {
                                    for (CategoriaModel categoria : listaCategorias) {
                            %>
                            <option value="<%= categoria.getId()%>"><%= categoria.getNombre()%></option>
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
                
                <div class="d-flex justify-content-start align-items-center">
                    <div class="col-4 text-end mt-3">
                        <p class="font">Disponibilidad:</p>
                    </div>
                    <div class="col-4 ms-2">
                          <select class="form-control border-danger" id="inputDisponibilidad" name="disponibilidad">
                            <option value="1">Disponible</option>
                            <option value="2">Agotado</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 offset-md-5">
                        <button type="submit" class="btn btnAdd">Agregar</button>
                    </div>
                </div>

            </form>
        </div>

        <script>
            // Función para actualizar el nombre del archivo en el input de imagen
            function updateFileName() {
    const fileInput = document.getElementById('image');
    const fileNameDisplay = document.getElementById('fileNameDisplay');
    const fileName = fileInput.files[0] ? fileInput.files[0].name : 'Ningún archivo seleccionado';
    fileNameDisplay.textContent = fileName; // Mostrar el nombre del archivo
}

        </script>

    </body>
</html>
