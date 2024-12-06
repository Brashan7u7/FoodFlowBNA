/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configuration.ConnectionBD;
import java.io.IOException;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ClienteFCreate", urlPatterns = {"/clienteFcreate"})
public class ClienteFCreate extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/admin/agregarClienteF.jsp").forward(request, response);
    }
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Configurar codificación y contenido
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Obtener parámetros del formulario con decodificación
        String nombre = URLDecoder.decode(request.getParameter("nombre"), "UTF-8");
        String telefono = URLDecoder.decode(request.getParameter("telefono"), "UTF-8");
        String comprasParam = URLDecoder.decode(request.getParameter("compras"), "UTF-8");

        // Validar que los campos no sean nulos ni vacíos
        if (nombre == null || telefono == null || comprasParam == null
                || nombre.isEmpty() || telefono.isEmpty() || comprasParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Todos los campos son obligatorios.");
            return;
        }

        // Convertir el campo compras a entero
        int compras = 0;
        try {
            compras = Integer.parseInt(comprasParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "El campo 'compras' debe ser un número válido.");
            return;
        }

        // Conexión y ejecución de la consulta
        try ( Connection conn = new ConnectionBD().getConnectionBD()) {

            String sql = "INSERT INTO clientes_fidelidad (nombre, telefono, compras) VALUES (?, ?, ?)";
            try ( PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, nombre);
                ps.setString(2, telefono);
                ps.setInt(3, compras);

                int filasInsertadas = ps.executeUpdate();
                if (filasInsertadas > 0) {
                    request.setAttribute("success", true);
            request.getRequestDispatcher("/pages/admin/agregarClienteF.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al registrar el cliente.");
                }
            }
        } catch (SQLIntegrityConstraintViolationException e) {
            // Si ocurre un error por duplicado, enviar el mensaje al JSP
            request.setAttribute("errorMessage", "Cliente ya registrado en el programa de fidelidad.");
            request.getRequestDispatcher("pages/admin/agregarClienteF.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la base de datos: " + e.getMessage());
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet para registrar clientes de fidelidad.";
    }
}
