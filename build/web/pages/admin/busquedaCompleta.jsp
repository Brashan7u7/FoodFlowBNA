<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <%@include file="../../components/headerAdmin.jsp" %>
        <%@include file="../../components/sidebarAdmin.jsp" %>

        <!-- Contenido de la página -->
        <div style="margin-left: 100px; padding: 20px; min-width: 100vh;">
            <div class="row">
                <div class="col-6">
                    <div class="row">
                        <h4>Busqueda</h4>
                    </div>
                    <div class="row">
                        <p><%= LocalDate.now().format(DateTimeFormatter.ofPattern("EEEE d MMM, yyyy"))%></p>
                    </div>
                </div>    

                <div class="col-3">
                    <h4>Bienvenido</h4>
                </div>
            </div>
            <div class="d-flex justify-content-between align-items-center">
                <!-- Botón dropdown alineado a la izquierda -->
                <div class="dropdown">
                    <form action="<%= request.getContextPath()%>/busqueda" method="get">
                        <input type="hidden" name="tipo" id="tipo">
                        <button class="btn dropdown-toggle drop" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Tipo
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" onclick="seleccionarTipo('Usuarios')">Usuarios</a></li>
                            <li><a class="dropdown-item" href="#" onclick="seleccionarTipo('Platillos')">Platillos</a></li>
                            <li><a class="dropdown-item" href="#" onclick="seleccionarTipo('Categorías')">Categorías</a></li>
                            <li><a class="dropdown-item" href="#" onclick="seleccionarTipo('Ventas')">Ventas</a></li>
                            <li><a class="dropdown-item" href="#" onclick="seleccionarTipo('Fidelidad')">Fidelidad</a></li>
                        </ul>
                        <button type="submit" class="btn btn-primary mt-2">Buscar</button>
                    </form>

                </div>

                <script>
                    function seleccionarTipo(valor) {
                        document.getElementById('tipo').value = valor;
                    }
                </script>

                <div class="search-container ms-auto" style="margin-right: 120px; width: 400px">
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text" class="form-control" placeholder="Buscar ...." />
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
