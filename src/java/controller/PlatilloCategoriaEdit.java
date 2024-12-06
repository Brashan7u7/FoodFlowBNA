package controller;

import com.google.gson.Gson;
import configuration.ConnectionBD;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.CategoriaModel;
import model.PlatilloModel;

@WebServlet("/editCategory")
public class PlatilloCategoriaEdit extends HttpServlet {

    Connection conn;
    PreparedStatement ps;
    Statement statement;
    ResultSet rs;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CatEdit</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CatEdit at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/admin/editCatDish.jsp").forward(request, response);
    }

     @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        ConnectionBD conexion = new ConnectionBD();
        StringBuilder sb = new StringBuilder();
        String line;

        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        Gson gson = new Gson();
        String json = sb.toString();
        String decodedJson = URLDecoder.decode(json, "UTF-8");
        CategoriaModel categoria = gson.fromJson(decodedJson, CategoriaModel.class);
        String sql = "UPDATE categorias_platillos SET nombre = ?, imagen = ?, estatus = ? WHERE id = ?";
        try {
            conn = conexion.getConnectionBD();
            ps = conn.prepareStatement(sql);
            ps.setString(1, categoria.getNombre());
            ps.setString(2, categoria.getImagen()); 
            ps.setString(3, categoria.getEstatus()); 
            ps.setInt(4, categoria.getId());

            int filasActualizadas = ps.executeUpdate();
            response.setContentType("text/plain");
            if (filasActualizadas > 0) {
                request.setAttribute("success", true);
                request.getRequestDispatcher("/pages/admin/editCatDish.jsp").forward(request, response);
            } else {
                request.setAttribute("success", true);
                request.getRequestDispatcher("/pages/admin/editCatDish.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
                request.setAttribute("success", true);
                request.getRequestDispatcher("/pages/admin/editCatDish.jsp").forward(request, response);
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
