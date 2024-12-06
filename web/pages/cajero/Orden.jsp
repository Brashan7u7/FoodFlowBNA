<%-- 
    Document   : Orden
    Created on : 29/11/2024, 07:27:23 PM
    Author     : carla
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orden</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .order-container {
                margin: 50px auto;
                max-width: 800px;
            }

            /* Estilo del contenedor de cada platillo */
            .order-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
                border-radius: 10px;
                background: rgba(0, 0, 0, 0.05); /* Difuminado */
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* Sombra */
                margin-bottom: 20px;
            }

            .order-item h6 {
                font-weight: bold;
                margin-bottom: 5px;
            }

            .quantity-controls {
                display: flex;
                align-items: center;
                gap: 5px;
            }

            /* Botones cuadrados */
            .quantity-controls button {
                border: 1px solid #ccc;
                border-radius: 5px; /* Cuadrado */
                width: 40px;
                height: 40px;
                padding: 0;
                background-color: #f8f9fa;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .quantity-controls span {
                width: 30px;
                text-align: center;
                font-size: 16px;
            }

            /* Botón de pagar */
            .pay-button {
                background-color: #ff5722;
                color: white;
                border: none;
                padding: 10px 30px; /* Botón más corto */
                font-size: 18px;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
                margin-top: 20px;
                float: right; /* Botón a la derecha */
            }

            .pay-button:hover {
                background-color: #e64a19;
            }

        </style>
    </head>
    <body>
        <%@include file="../../components/headerAdmin.jsp" %>
        <%@include file="../../components/sidebarAdmin.jsp" %>

        <div class="order-container">
            <h2 class="text-center mb-4">Orden</h2>

            <!-- Bloque para un platillo -->
            <div class="order-item">
                <div>
                    <h6>SHRIMP TEMPURA</h6>
                    <p>5 tiger shrimp with tempura sauce</p>
                    <p>RM23.90 + RM1.20(SST) = <b>RM25.10</b></p>
                </div>
                <div class="quantity-controls">
                    <button class="btn-minus">-</button>
                    <span class="quantity">1</span>
                    <button class="btn-plus">+</button>
                </div>
            </div>
            <!-- Fin del bloque de platillo -->

            <button class="pay-button">PAGAR</button>
        </div>

        <script>
            // Función para abrir/cerrar el sidebar
            function toggleSidebar() {
                document.getElementById("mySidebar").classList.toggle("open");
            }
            /////


            // Seleccionamos todos los botones para manejar los eventos
            document.addEventListener("DOMContentLoaded", () => {
                const minusButtons = document.querySelectorAll(".btn-minus");
                const plusButtons = document.querySelectorAll(".btn-plus");
                const quantities = document.querySelectorAll(".quantity");

                // Agregar funcionalidad al botón "+"
                plusButtons.forEach((button, index) => {
                    button.addEventListener("click", () => {
                        const currentQuantity = parseInt(quantities[index].textContent);
                        quantities[index].textContent = currentQuantity + 1;
                    });
                });

                // Agregar funcionalidad al botón "-"
                minusButtons.forEach((button, index) => {
                    button.addEventListener("click", () => {
                        const currentQuantity = parseInt(quantities[index].textContent);
                        if (currentQuantity > 1) {
                            quantities[index].textContent = currentQuantity - 1;
                        }
                    });
                });
            });
        </script>
    </body>
</html>
