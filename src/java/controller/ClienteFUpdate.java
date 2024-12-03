/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ClienteFModel;

/**
 *
 * @author IDEAPAD
 */
@WebServlet(name = "ClienteFUpdate", urlPatterns = {"/clienteFupdate"})
public class ClienteFUpdate extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ClienteFUpdate</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ClienteFUpdate at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // Configuración de la conexión a la base de datos
    private final String JDBC_URL = "jdbc:mysql://localhost:3306/foodflow";
    private final String JDBC_USER = "root";
    private final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id"); // Se espera el parámetro `id`

        if (idParam == null || idParam.isEmpty()) {
            // Si no se proporciona ID, mostrar un error
            request.setAttribute("error", "Debe proporcionar un ID válido para buscar al cliente.");
            request.getRequestDispatcher("/pages/admin/mostrarClienteF.jsp").forward(request, response);
            return;
        }

        try ( Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            // Consulta SQL para buscar al cliente por ID
            String query = "SELECT * FROM clientes_fidelidad WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, Integer.parseInt(idParam));
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Si se encuentra el cliente, crear un objeto ClienteFModel
                ClienteFModel cliente = new ClienteFModel(
                        resultSet.getInt("id"),
                        resultSet.getString("nombre"),
                        resultSet.getString("telefono"),
                        resultSet.getInt("compras")
                );

                // Enviar el cliente al JSP de actualización
                request.setAttribute("cliente", cliente);
                request.getRequestDispatcher("/pages/admin/updateClienteF.jsp").forward(request, response);
            } else {
                // Si no se encuentra el cliente
                request.setAttribute("error", "Cliente no encontrado con el ID proporcionado.");
                request.getRequestDispatcher("/pages/admin/mostrarClienteF.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Manejo de errores
            request.setAttribute("error", "Error al buscar cliente: " + e.getMessage());
            request.getRequestDispatcher("/pages/admin/mostrarClienteF.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Recuperar los parámetros enviados desde el formulario
        String idParam = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String telefono = request.getParameter("telefono");
        String comprasParam = request.getParameter("compras");

        if (idParam == null || nombre == null || telefono == null || comprasParam == null) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("/pages/admin/updateClienteF.jsp").forward(request, response);
            return;
        }

        try ( Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            // Consulta SQL para actualizar el cliente
            String query = "UPDATE clientes_fidelidad SET nombre = ?, telefono = ?, compras = ? WHERE id = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, nombre);
            statement.setString(2, telefono);
            statement.setInt(3, Integer.parseInt(comprasParam));
            statement.setInt(4, Integer.parseInt(idParam));

            int rowsUpdated = statement.executeUpdate();

            if (rowsUpdated > 0) {
                // Redirigir al listado con mensaje de éxito
                request.setAttribute("success", "Cliente actualizado correctamente.");
                request.getRequestDispatcher("/pages/admin/mostrarClienteF.jsp").forward(request, response);
            } else {
                // Manejo de caso donde no se actualiza ninguna fila
                request.setAttribute("error", "No se pudo actualizar el cliente. Verifique el ID.");
                request.getRequestDispatcher("/pages/admin/updateClienteF.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Manejo de errores
            request.setAttribute("error", "Error al actualizar cliente: " + e.getMessage());
            request.getRequestDispatcher("/pages/admin/updateClienteF.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para actualizar clientes fidelizados";
    }
}
