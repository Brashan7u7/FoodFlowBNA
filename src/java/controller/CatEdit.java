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
import javax.servlet.http.Part; // Para manejar la subida de archivos
import java.nio.file.Paths;    // Para manipular las rutas de archivos


@WebServlet("/pages/admin/editCat")
public class CatEdit extends HttpServlet {

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
        // Obtén el parámetro 'id' de la solicitud
        String id = request.getParameter("id");

        if (id != null) {
            ConnectionBD conexion = new ConnectionBD();
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            try {
                connection = conexion.getConnectionBD();
                String sql = "SELECT nombre, imagen, estatus FROM categorias_bebidas WHERE id = ?";
                statement = connection.prepareStatement(sql);
                statement.setString(1, id);

                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    String nombre = resultSet.getString("nombre");
                    String imagen = resultSet.getString("imagen");
                    String estatus = resultSet.getString("estatus");

                    // Configurar los datos como atributos
                    request.setAttribute("id", id);
                    request.setAttribute("nombre", nombre);
                    request.setAttribute("imagen", imagen);
                    request.setAttribute("estatus", estatus);
                }
            } catch (Exception e) {
                e.printStackTrace();
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
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        // Redirigir a la página JSP editCat
        request.getRequestDispatcher("/pages/admin/editCat.jsp").forward(request, response);
    }

    
         @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String id = request.getParameter("id");
    String nombre = request.getParameter("nombre");

    // Validar que el nombre no sea nulo o vacío
    if (nombre == null || nombre.trim().isEmpty()) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("{\"success\": false, \"message\": \"El nombre no puede estar vacío\"}");
        return;
    }

    // Aquí iría la lógica para actualizar la categoría, si el nombre es válido
    // ...
}



    @Override
protected void doPut(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    // Obtén el ID de la categoría desde la solicitud
    String id = request.getParameter("id");

    if (id != null) {
        ConnectionBD conexion = new ConnectionBD();
        Connection connection = null;
        PreparedStatement ps = null;

        try {
            connection = conexion.getConnectionBD();
            
            // SQL para actualizar el estatus a 'desactivado' de la categoría por su ID
            String sql = "UPDATE categorias_bebidas SET estatus = 'inactivo' WHERE id = ?";
            
            ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            int rowsAffected = ps.executeUpdate();
            
            // Verificar si se actualizó correctamente
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK); // OK, desactivada
                response.getWriter().write("Categoría desactivada con éxito");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // No se encontró
                response.getWriter().write("Categoría no encontrada");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Error del servidor
            response.getWriter().write("Hubo un error al desactivar la categoría");
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    } else {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // ID no proporcionado
        response.getWriter().write("ID no proporcionado");
    }
}

 @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtén el ID de la categoría desde la solicitud
        String id = request.getParameter("id");

        // Conéctate a la base de datos y ejecuta la eliminación
        ConnectionBD conexion = new ConnectionBD();
        Connection connection = null;
        PreparedStatement ps = null;

        try {
            // Conexión con la base de datos
            connection = conexion.getConnectionBD();

            // SQL para eliminar la categoría por su ID
            String sql = "DELETE FROM categorias_bebidas WHERE id = ?";

            // Preparar la declaración
            ps = connection.prepareStatement(sql);
            ps.setString(1, id);

            // Ejecutar la eliminación
            int rowsAffected = ps.executeUpdate();

            // Verificar si se eliminó la categoría
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK); // OK, eliminada
                response.getWriter().write("Categoría eliminada con éxito");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // No se encontró
                response.getWriter().write("Categoría no encontrada");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Error del servidor
            response.getWriter().write("Hubo un error al eliminar la categoría");
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
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
