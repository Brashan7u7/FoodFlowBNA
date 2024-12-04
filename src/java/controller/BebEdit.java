/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configuration.ConnectionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author BRASHAN
 */
@WebServlet("/pages/admin/editBeb")
public class BebEdit extends HttpServlet {

    Connection conn;
    PreparedStatement ps;
    Statement statement;
    ResultSet rs;
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
            out.println("<title>Servlet BebEdit</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BebEdit at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        if (id != null) {
            ConnectionBD conexion = new ConnectionBD();
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            try {
                connection = conexion.getConnectionBD();
                String sql = "SELECT b.nombre, b.descripcion, b.imagen, b.precio_unitario, b.disponibilidad, c.nombre AS categoria_nombre " +
                             "FROM bebidas b INNER JOIN categorias_bebidas c ON b.categoria_id = c.id WHERE b.id = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, id);

                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    // Datos de la bebida
                    request.setAttribute("id", id);
                    request.setAttribute("nombre", resultSet.getString("nombre"));
                    request.setAttribute("descripcion", resultSet.getString("descripcion"));
                    request.setAttribute("imagen", resultSet.getString("imagen"));
                    request.setAttribute("precio_unitario", resultSet.getDouble("precio_unitario"));
                    request.setAttribute("disponibilidad", resultSet.getBoolean("disponibilidad"));
                    request.setAttribute("categoria", resultSet.getString("categoria_nombre"));
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (statement != null) statement.close();
                    if (connection != null) connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        // Redirigir a la página JSP de edición
        request.getRequestDispatcher("/pages/admin/editBeb.jsp").forward(request, response);
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
        processRequest(request, response);
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ConnectionBD conexion = new ConnectionBD();
        String id = request.getParameter("id");
        
        if (id == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        int idFinal = 0;
        idFinal = Integer.parseInt(id); 
                
        String sql = "DELETE FROM bebidas WHERE id like ?";

        try {
            conn = conexion.getConnectionBD();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idFinal);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK); 
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); 
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); 
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
