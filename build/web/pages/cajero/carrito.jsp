<%-- 
    Document   : factura
    Created on : Nov 25, 2024
    Author     : rafis
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../../components/header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ventas diarias</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            h1 {
                font-size: 3rem;
                font-weight: bold;
                margin-bottom: 10px;
                text-align: left;
            }
            .table {
                width: 100%;
                margin: 20px 0;
                border-collapse: collapse;
            }
            .table th {
                border-bottom: 2px solid black;
                text-align: left;
                padding: 8px;
            }
            .table td {
                padding: 8px;
                text-align: left;
            }
            .pagination {
                display: flex;
                justify-content: center;
                list-style: none;
                padding: 0;
            }
            .pagination li {
                margin: 0 5px;
            }
            .pagination a {
                text-decoration: none;
                color: black;
                padding: 5px 10px;
                border: 1px solid black;
                border-radius: 5px;
            }
            .pagination a:hover {
                background-color: #f0f0f0;
            }
            .pagination .active a {
                background-color: #007bff;
                color: white;
                border: 1px solid black;
            }
            .pagination li:first-child a,
            .pagination li:last-child a {
                color: #007bff;
                border: none;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <%@include file="../../components/sidebarAdmin.jsp" %>

        <div class="container">
            <h1>BILL</h1>
            <div class="text-start mb-4">
                <p>Date: June 4, 2020</p>
                <p>Invoice: #2005</p>
            </div>

            <table class="table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>Folio</th>
                        <th>Nombre</th>
                        <th>Fecha</th>
                        <th>Cliente</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>asada</td>
                        <td>Shrimp Tempura</td>
                        <td>20/12/2024</td>
                        <td>Sí</td>
                        <td>RM 47.80</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>sasa</td>
                        <td>Oyster Dynamite</td>
                        <td>20/12/2024</td>
                        <td>No</td>
                        <td>RM 23.90</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>assa</td>
                        <td>Fried Calamari Salad</td>
                        <td>20/12/2024</td>
                        <td>Sí</td>
                        <td>RM 47.80</td>
                    </tr>
                </tbody>
            </table>
            <br>
            <br>
            <br>
            <br>
            <!-- Pagination -->
            <nav>
                <ul class="pagination">
                    <li class="page-item"><a class="page-link" href="#">Anterior</a></li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">Siguiente</a></li>
                </ul>
            </nav>
        </div>

    </body>
</html>