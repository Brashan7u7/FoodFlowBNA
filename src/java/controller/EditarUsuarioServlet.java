package controller;

import configuration.ConnectionBD;
import model.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EditarUsuarioServlet", urlPatterns = {"/editarusuario"})
public class EditarUsuarioServlet extends HttpServlet {

    // Método GET: Cargar los datos del usuario para mostrar en el formulario
 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String idUsuario = request.getParameter("id");
    request.setAttribute("idUsuario", idUsuario);
    request.getRequestDispatcher("/pages/usuario/editarUsuario.jsp").forward(request, response);
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String idUsuario = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String apellidoPaterno = request.getParameter("apellido_paterno");
        String apellidoMaterno = request.getParameter("apellido_materno");
        String correoElectronico = request.getParameter("correo");
        String rol = request.getParameter("rol");

        try {
            // Depuración: Imprimir el valor de idUsuario
            System.out.println("idUsuario recibido: " + idUsuario);

            // Verificar si idUsuario no es nulo ni vacío antes de convertirlo
            if (idUsuario == null || idUsuario.trim().isEmpty()) {
                System.out.println("idUsuario está vacío o nulo.");
                response.sendRedirect("/error.jsp"); // Redirigir a una página de error si el ID no es válido
                return;
            }

            // Convertir idUsuario a int
            int idUsuarioInt = Integer.parseInt(idUsuario);

            // Depuración: Imprimir el valor convertido
            System.out.println("idUsuario convertido a int: " + idUsuarioInt);

            // Conexión a la base de datos
            try (Connection conn = new ConnectionBD().getConnectionBD()) {

                // Actualizar el usuario en la base de datos
                String sql = "UPDATE usuarios SET nombre = ?, apellido_paterno = ?, apellido_materno = ?, correo = ?, rol = ? WHERE id = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, nombre);
                    ps.setString(2, apellidoPaterno);
                    ps.setString(3, apellidoMaterno);
                    ps.setString(4, correoElectronico);
                    ps.setString(5, rol);
                    ps.setInt(6, idUsuarioInt); // Usar setInt para el ID

                    int rowsUpdated = ps.executeUpdate();

                    if (rowsUpdated > 0) {
                        response.sendRedirect("/foodflow/usuariosservlet"); // Redirigir a una página de éxito
                    } else {
                        response.sendRedirect("/error.jsp?message=No se actualizó el usuario");
                    }
                }
            }
        } catch (NumberFormatException e) {
            // Capturar la excepción y redirigir a una página de error si no se puede convertir el ID a entero
            e.printStackTrace();
            response.sendRedirect("/error.jsp?message=ID inválido");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al actualizar el usuario: " + e.getMessage());
        }
    }
}
