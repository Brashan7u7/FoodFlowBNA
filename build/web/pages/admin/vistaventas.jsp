<%-- 
    Document   : vistaventas
    Created on : 16/11/2024, 09:29:53 PM
    Author     : CruzF
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%
    // Parámetros de filtro por fecha (opcional)
    String fechaInicial = request.getParameter("fechaInicial");
    String fechaFinal = request.getParameter("fechaFinal");
    String fechaFinal2 = request.getParameter("fechaFinal");

    if (fechaFinal2 != null && !fechaFinal2.isEmpty()) {
        fechaFinal2 += " 23:59:59";
    }

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    // Lista para almacenar los resultados
    ArrayList<HashMap<String, String>> ventas = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurante", "root", "");

        // Consulta SQL con filtro por fecha
        String sql = "SELECT "
                + "    o.id AS orden_id, "
                + "    o.folio, "
                + "    u.nombre AS usuario_nombre, "
                + "    o.fecha, "
                + "    cf.nombre AS cliente_nombre, "
                + "    COALESCE(SUM(odp.precio_unitario * odp.cantidad), 0) + "
                + "    COALESCE(SUM(odb.precio_unitario * odb.cantidad), 0) AS total_orden "
                + "FROM "
                + "    ordenes o "
                + "JOIN "
                + "    usuarios u ON o.usuario_id = u.id "
                + "LEFT JOIN "
                + "    clientes_fidelidad cf ON o.cliente_id = cf.id "
                + "LEFT JOIN "
                + "    ordenes_detalle_platillos odp ON o.id = odp.orden_id "
                + "LEFT JOIN "
                + "    ordenes_detalle_bebidas odb ON o.id = odb.orden_id "
                + "WHERE "
                + "    (? IS NULL OR o.fecha >= ?) AND "
                + "    (? IS NULL OR o.fecha <= ?) "
                + "GROUP BY "
                + "    o.id, o.folio, u.nombre, o.fecha, cf.nombre";

        // Preparar consulta
        statement = connection.prepareStatement(sql);

        // Establecer parámetros
        statement.setString(1, fechaInicial);
        statement.setString(2, fechaInicial);
        statement.setString(3, fechaFinal2);
        statement.setString(4, fechaFinal2);

        // Ejecutar consulta
        resultSet = statement.executeQuery();

        // Procesar resultados
        while (resultSet.next()) {
            HashMap<String, String> row = new HashMap<>();
            row.put("orden_id", resultSet.getString("orden_id"));
            row.put("folio", resultSet.getString("folio"));
            row.put("usuario_nombre", resultSet.getString("usuario_nombre"));
            row.put("fecha", resultSet.getString("fecha"));
            row.put("cliente_nombre", resultSet.getString("cliente_nombre"));
            row.put("total_orden", resultSet.getString("total_orden"));
            ventas.add(row);
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
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
        } catch (SQLException e) {
            out.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vista de Ventas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script>
            // Actualizar la hora en tiempo real
            function updateClock() {
                const now = new Date();
                const optionsDate = {weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'};
                document.getElementById("currentDate").innerHTML = now.toLocaleDateString('es-ES', optionsDate).toUpperCase();
                const optionsTime = {hour: '2-digit', minute: '2-digit', second: '2-digit'};
                document.getElementById("currentTime").innerHTML = now.toLocaleTimeString('es-ES', optionsTime).toUpperCase();
            }

            setInterval(updateClock, 1000); // Actualizar cada segundo
        </script>
        <style>
            .custom-card {
                background-color: #F6F6F6;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .date-input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                font-size: 1rem;
                color: #495057;
            }

            .date-input::placeholder {
                color: #adb5bd;
                font-style: italic;
            }

            .containerTop h2 {
                margin-bottom: 0;
            }
        </style>
    </head>
    <body onload="updateClock()">
        <%@include file="../../components/headerAdmin.jsp" %>
        <%@include file="../../components/sidebarAdmin.jsp" %>


        <!-- Contenido de la página -->
        <<div style="margin-left: 100px; padding: 20px; margin-right: 100px">
            <!-- Títulos -->
            <div class="row containerTop mb-4">
                <div class="col-8">
                    <h2>Búsqueda</h2>
                    <%-- Fecha inicial desde el servidor --%>
                    <p><span id="currentDate"></span></p>
                    <p><span id="currentTime"></span></p>
                </div>
                <div class="col-4 text-end">
                    <h2>Bienvenido: <%= session.getAttribute("nombre") != null ? session.getAttribute("nombre") : "Invitado"%></h2>
                </div>
            </div>

            <!-- Tabla de ventas y controles de búsqueda por fecha -->
            <div class="card custom-card" style="">
                <div class="row mb-4">
                    <div class="col-12">
                        <form method="GET" action="vistaventas.jsp" onsubmit="return validateDates()">
                            <div class="row mb-3">
                                <div class="col-6">
                                    <h3>Ventas</h3>
                                </div>
                                <div class="col-2">
                                    <label for="fechaInicial" class="form-label">Fecha de inicio</label>
                                    <input type="date" id="fechaInicial" name="fechaInicial" class="form-control" placeholder="Fecha Inicial" value="<%= fechaInicial != null ? fechaInicial : ""%>">
                                </div>
                                <div class="col-2">
                                    <label for="fechaFinal" class="form-label">Fecha final</label>
                                    <input type="date" id="fechaFinal" name="fechaFinal" class="form-control" placeholder="Fecha Final" value="<%= fechaFinal != null ? fechaFinal : ""%>">
                                </div>
                                <div class="col-2 d-flex align-items-end">
                                    <button type="submit" class="btn" style="background-color: #E58A56; color: white" >Filtrar</button>
                                    <%
                                        if(fechaFinal!=null || fechaInicial!=null){
                                    %>
                                    <a href="vistaventas.jsp" class="btn btn-danger ms-2">Quitar filtro</a>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Folio</th>
                            <th>Nombre Usuario</th>
                            <th>Fecha</th>
                            <th>Cliente</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int counter = 1;
                            for (HashMap<String, String> venta : ventas) {
                        %>
                        <tr>
                            <td><%= counter++%></td>
                            <td><%= venta.get("folio")%></td>
                            <td><%= venta.get("usuario_nombre")%></td>
                            <td><%= venta.get("fecha")%></td>
                            <td><%= venta.get("cliente_nombre")%></td>
                            <td>$<%= venta.get("total_orden")%></td>
                        </tr>
                        <% } %>
                        <% if (ventas.isEmpty()) { %>
                        <tr>
                            <td colspan="6" class="text-center">No se encontraron resultados.</td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- Tabla de resultados -->
        <script>
            // Función para abrir/cerrar el sidebar
            function toggleSidebar() {
                document.getElementById("mySidebar").classList.toggle("open");
            }
            function validateDates() {
                const fechaInicial = document.querySelector('input[name="fechaInicial"]').value;
                const fechaFinal = document.querySelector('input[name="fechaFinal"]').value;

                if (fechaInicial && fechaFinal && new Date(fechaFinal) < new Date(fechaInicial)) {
                    alert("La fecha final debe ser mayor o igual a la fecha inicial.");
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>