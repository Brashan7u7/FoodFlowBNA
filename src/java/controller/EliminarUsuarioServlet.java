/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.UsuarioDAO;
import controller.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "EliminarUsuarioServlet", urlPatterns = {"/eliminarusuario"})

public class EliminarUsuarioServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del usuario desde los parámetros de la solicitud
        String idUsuarioParam = request.getParameter("id");

        if (idUsuarioParam != null) {
            try {
                int idUsuario = Integer.parseInt(idUsuarioParam);
                
                // Crear instancia de UsuarioDAO para interactuar con la base de datos
                UsuarioDAO usuarioDAO = new UsuarioDAO();
                
                // Eliminar el usuario
                boolean usuarioEliminado = usuarioDAO.eliminarUsuario(idUsuario);
                
                // Verificar si la eliminación fue exitosa
                if (usuarioEliminado) {
                    // Redirigir a la lista de usuarios con un mensaje de éxito
                    response.sendRedirect("/foodflow/usuariosservlet");
                } else {
                    // Redirigir con un mensaje de error si no se pudo eliminar
                    response.sendRedirect("/foodflow/usuariosservlet?mensaje=Error al eliminar el usuario");
                }
                
            } catch (NumberFormatException e) {
                // Manejar el caso en que el ID no es un número válido
                System.err.println("ID de usuario inválido: " + e.getMessage());
                response.sendRedirect("/foodflow/usuariosservlet?mensaje=ID de usuario inválido");
            }
        } else {
            // Si no se proporcionó un ID, redirigir con un mensaje de error
            response.sendRedirect("/foodflow/usuariosservlet?mensaje=No se proporcionó un ID de usuario");
        }
    }
}
