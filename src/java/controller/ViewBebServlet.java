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
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.BebidaModel;

/**
 *
 * @author BRASHAN
 */
@WebServlet("/pages/admin/viewBeb")
public class ViewBebServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ViewBebServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewBebServlet at " + request.getContextPath() + "</h1>");
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

        // Lista para almacenar las bebidas obtenidas de la base de datos
        ArrayList<BebidaModel> listaBebidas = new ArrayList<>();
        
        // Obtener las bebidas de la base de datos, incluyendo el nombre de la categoría
        try (Connection conn = new ConnectionBD().getConnectionBD();  
             PreparedStatement ps = conn.prepareStatement("SELECT p.id, p.nombre, p.imagen, p.descripcion, p.precio_unitario, c.nombre AS categoria_nombre, p.disponibilidad FROM bebidas p JOIN categorias_bebidas c ON p.categoria_id = c.id");  
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BebidaModel bebida = new BebidaModel();
                bebida.setId(rs.getInt("id"));
                bebida.setNombre(rs.getString("nombre"));
                bebida.setImagen(rs.getString("imagen"));
                bebida.setDescripcion(rs.getString("descripcion"));
                bebida.setPrecio_unitario(rs.getDouble("precio_unitario"));
                bebida.setCategoriaNombre(rs.getString("categoria_nombre"));  // Agregado nombre de la categoría
                bebida.setDisponibilidad(rs.getBoolean("disponibilidad"));
                
                listaBebidas.add(bebida);
            }
            request.setAttribute("bebidas", listaBebidas); // Cambié "categorias" a "bebidas"
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar Bebidas: " + e.getMessage());
        }

        // Redirigir a la vista JSP
        request.getRequestDispatcher("/pages/admin/viewBeb.jsp").forward(request, response);
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
