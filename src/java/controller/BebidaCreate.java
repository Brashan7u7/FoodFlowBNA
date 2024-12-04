/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configuration.ConnectionBD;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.CategoriaModel;

/**
 *
 * @author BRASHAN
 */
@WebServlet("/pages/admin/createBeb")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class BebidaCreate extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "images";

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
            out.println("<title>Servlet BebidaCreate</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BebidaCreate at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        List<CategoriaModel> listaCategorias = new ArrayList<>();
        String categoriaId = request.getParameter("categoriaId");
        String sqlCategories = "SELECT id, nombre FROM categorias_bebidas";

        try ( Connection conn = new ConnectionBD().getConnectionBD()) {
            try ( PreparedStatement psCategories = conn.prepareStatement(sqlCategories);  ResultSet rsCategories = psCategories.executeQuery()) {
                while (rsCategories.next()) {
                    CategoriaModel categoria = new CategoriaModel();
                    categoria.setId(rsCategories.getInt("id"));
                    categoria.setNombre(rsCategories.getString("nombre"));
                    listaCategorias.add(categoria);
                }
            }
            request.setAttribute("categorias", listaCategorias);
            request.getRequestDispatcher("/pages/admin/createBeb.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener las categorias: " + e.getMessage());
        }
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
    
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");

    ConnectionBD conexion = new ConnectionBD();
    String applicationPath = request.getServletContext().getRealPath("");
    String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;

    File uploadDir = new File(uploadFilePath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs();
    }

    try {
        // Obtener datos del formulario
        String nombre = request.getParameter("txt_nombre");
        String descripcion = request.getParameter("txt_descripcion");
        String precio_unitario = request.getParameter("txt_precio");
        String categoria_id = request.getParameter("categoria");
        String disponibilidad = request.getParameter("disponibilidad");

        double precioFinal = Double.parseDouble(precio_unitario);
        int categoriaFinal = Integer.parseInt(categoria_id);
        boolean disponibilidadFinal = disponibilidad.equals("1");

        // Manejo del archivo de imagen
        Part part = request.getPart("image");
        String fileName = getFileName(part);
        String filePath = uploadFilePath + File.separator + fileName;
        part.write(filePath);

        String relativePath = UPLOAD_DIR + "/" + fileName;
        
       


        // Guardar datos en la base de datos
        String sql = "INSERT INTO bebidas (nombre, imagen, descripcion, precio_unitario, categoria_id, disponibilidad) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        

        try (Connection conn = conexion.getConnectionBD();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.setString(2, relativePath); // Ruta relativa
            ps.setString(3, descripcion);
            ps.setDouble(4, precioFinal);
            ps.setInt(5, categoriaFinal);
            ps.setBoolean(6, disponibilidadFinal);

            int filasInsertadas = ps.executeUpdate();

            if (filasInsertadas > 0) {
                response.sendRedirect(request.getContextPath() + "/pages/admin/viewDish");
            } else {
                request.setAttribute("message", "Error al crear la bebida.");
                request.getRequestDispatcher("/pages/admin/createBeb.jsp").forward(request, response);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("message", "Error al procesar la solicitud: " + e.getMessage());
        request.getRequestDispatcher("/pages/admin/createBeb.jsp").forward(request, response);
    }
}


// Obtener el nombre del archivo subido
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String token : contentDisposition.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
            }
        }
        return "";
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




