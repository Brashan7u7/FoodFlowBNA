/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configuration.ConnectionBD;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UsuarioDAO;

@WebServlet(name = "UsuariosServlet", urlPatterns = {"/usuariosservlet"})
public class UsuariosServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
      
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          ArrayList<Usuario> usuarios = new ArrayList<>();
        
        // Conexión a la base de datos utilizando ConnectionBD
        try {
            ConnectionBD connectionBD = new ConnectionBD();
            Connection conn = connectionBD.getConnectionBD();
            
            String sql = "SELECT id, nombre, apellido_paterno, apellido_materno, correo, rol FROM usuarios";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Usuario usuario = new Usuario(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("apellido_paterno"),
                        rs.getString("apellido_materno"),
                        rs.getString("correo"),
                        rs.getString("rol")
                );
                usuarios.add(usuario);
                    System.out.println("Usuario agregado: " + usuario.getNombre());

            }
            conn.close();

            System.out.println("Número de usuarios recuperados: " + usuarios.size()); // Verificación del tamaño de la lista

        } catch (Exception e) {
            System.err.println("Error en la consulta o conexión a la base de datos: " + e.getMessage());
        }

        // Pasar la lista de usuarios al JSP
        request.setAttribute("usuarios", usuarios);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/crud.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtener los parámetros del formulario
        String nombre = request.getParameter("firstName");
        String apellidoPaterno = request.getParameter("lastName");
        String apellidoMaterno = request.getParameter("middleName");
        String correo = request.getParameter("email");
        String pin = request.getParameter("pin"); 
        String rol = request.getParameter("role");

        // Validar que no estén vacíos
        if (nombre != null && !nombre.isEmpty() && 
            apellidoPaterno != null && !apellidoPaterno.isEmpty() && 
            apellidoMaterno != null && !apellidoMaterno.isEmpty() && 
            correo != null && !correo.isEmpty() && 
            pin != null && !pin.isEmpty() && 
            rol != null && !rol.isEmpty()) {
            
            try {
                // Crear un objeto Usuario con los parámetros recibidos
                Usuario usuario = new Usuario();
                usuario.setNombre(nombre);
                usuario.setApellidoPaterno(apellidoPaterno);
                usuario.setApellidoMaterno(apellidoMaterno);
                usuario.setCorreo(correo);
                usuario.setPin(pin);  
                usuario.setRol(rol);

                // Usar el DAO para agregar el usuario
                UsuarioDAO usuarioDAO = new UsuarioDAO();
                boolean usuarioAgregado = usuarioDAO.agregarUsuario(usuario);

                if (usuarioAgregado) {
                    response.sendRedirect("usuariosservlet"); // Redirigir a la lista de usuarios
                } else {
                    request.setAttribute("error", "No se pudo agregar el usuario.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/registrarusuario.jsp");
                    dispatcher.forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace(); // Puedes registrar esto en un log en vez de imprimirlo
                request.setAttribute("error", "Error al agregar el usuario: " + e.getMessage());
                RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/registrarusuario.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/registrarusuario.jsp");
            dispatcher.forward(request, response);
        }
    }
}
