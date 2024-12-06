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
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoriaModel;

/**
 * Servlet para gestionar la visualización de categorías. Obtiene las categorías
 * desde la base de datos y las envía a la vista JSP.
 */
@WebServlet("/pages/admin/viewCat")
public class ViewCatServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Maneja las solicitudes HTTP <code>GET</code>.
     *
     * @param request Solicitud del cliente.
     * @param response Respuesta del servidor.
     * @throws ServletException Si ocurre un error relacionado con el servlet.
     * @throws IOException Si ocurre un error de entrada/salida.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lista para almacenar las categorías obtenidas de la base de datos
        ArrayList<CategoriaModel> listaCategorias = new ArrayList<>();
// Obtener las categorías de la base de datos
        try ( Connection conn = new ConnectionBD().getConnectionBD();  PreparedStatement ps = conn.prepareStatement("SELECT id, nombre, imagen, estatus FROM categorias_bebidas");  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CategoriaModel categoria = new CategoriaModel();
                categoria.setId(rs.getInt("id"));
                categoria.setNombre(rs.getString("nombre"));
                categoria.setImagen(rs.getString("imagen"));
                categoria.setEstatus(rs.getString("estatus"));
                listaCategorias.add(categoria);
            }
            request.setAttribute("categorias", listaCategorias);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar categorías: " + e.getMessage());
        }

        // Redirigir a la vista JSP
        request.getRequestDispatcher("/pages/admin/viewCat.jsp").forward(request, response);
    }

    /**
     * Devuelve una breve descripción del servlet.
     *
     * @return Descripción del servlet.
     */
    @Override
    public String getServletInfo() {
        return "Servlet para visualizar las categorías de bebidas.";
    }
}
