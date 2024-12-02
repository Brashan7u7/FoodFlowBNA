package controller;

import configuration.ConnectionBD;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/pages/admin/createCat")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class CatCreate extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "images";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Crear directorio para subir imágenes si no existe
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            // Obtener el nombre de la categoría
            String nombre = request.getParameter("txt_nombre");

            // Manejo del archivo de imagen
            Part part = request.getPart("image");
            String fileName = getFileName(part);
            String filePath = uploadFilePath + File.separator + fileName;
            part.write(filePath);

            // Ruta relativa para guardar en la base de datos
            String relativePath = UPLOAD_DIR + "/" + fileName;

            // Guardar datos en la base de datos
            if (saveCategoryToDatabase(nombre, relativePath)) {
                // Redirigir al servlet que maneja la vista de categorías (GET)
                response.sendRedirect(request.getContextPath() + "/pages/admin/viewCat");
            } else {
                // En caso de error, mostrar mensaje en la misma página
                request.setAttribute("message", "Error al crear la categoría.");
                request.getRequestDispatcher("/pages/admin/viewCat").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Manejar errores y redirigir a la vista con un mensaje
            request.setAttribute("message", "Error al procesar la solicitud: " + e.getMessage());
            request.getRequestDispatcher("/pages/admin/viewCat").forward(request, response);
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

    // Guardar datos en la base de datos
    private boolean saveCategoryToDatabase(String nombre, String imagePath) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            ConnectionBD conexion = new ConnectionBD();
            conn = conexion.getConnectionBD();
            String sql = "INSERT INTO categorias_bebidas (nombre, imagen) VALUES (?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, imagePath);

            int filasInsertadas = ps.executeUpdate();
            return filasInsertadas > 0;

        } catch (SQLException e) {
            System.out.println("Error al insertar datos: " + e.getMessage());
            return false;

        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para crear categorías con imagen.";
    }
}
