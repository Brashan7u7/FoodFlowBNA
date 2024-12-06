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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.BebidaModel;
import model.CategoriaModel;
import model.PlatilloModel;

@WebServlet("/bebidas")
public class Bebida extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
            out.println("<title>Servlet Platillo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Platillo at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        List<BebidaModel> listaBebidas = new ArrayList<>();
        List<CategoriaModel> listaCategorias = new ArrayList<>();
        ResultSet rsBebidas = null;
        ResultSet rsCategorias = null;
        PreparedStatement psBebidas = null;
        PreparedStatement psCategorias = null;
        Connection conn = null;

        try {
            ConnectionBD connectionBD = new ConnectionBD();
            conn = connectionBD.getConnectionBD();
            String categoriasSql = "SELECT id, nombre FROM categorias_bebidas";
            psCategorias = conn.prepareStatement(categoriasSql);
            rsCategorias = psCategorias.executeQuery();

            while (rsCategorias.next()) {
                CategoriaModel categoria = new CategoriaModel();
                categoria.setId(rsCategorias.getInt("id"));
                categoria.setNombre(rsCategorias.getString("nombre"));
                listaCategorias.add(categoria);
            }
            String categoriaIdParam = request.getParameter("categoriaId");

            String bebidasSql = "SELECT p.id, p.nombre, p.imagen, p.descripcion, p.precio_unitario, c.nombre as categoriaNombre, p.disponibilidad "
                    + "FROM bebidas p "
                    + "LEFT JOIN categorias_bebidas c ON p.categoria_id = c.id";

            if (categoriaIdParam != null && !categoriaIdParam.isEmpty()) {
                bebidasSql += " WHERE p.categoria_id = ?";
                psBebidas = conn.prepareStatement(bebidasSql);
                psBebidas.setInt(1, Integer.parseInt(categoriaIdParam));
            } else {
                psBebidas = conn.prepareStatement(bebidasSql);
            }
            rsBebidas = psBebidas.executeQuery();
            while (rsBebidas.next()) {
                BebidaModel bebida = new BebidaModel();
                bebida.setId(rsBebidas.getInt("id"));
                bebida.setNombre(rsBebidas.getString("nombre"));
                bebida.setImagen(rsBebidas.getString("imagen"));
                bebida.setDescripcion(rsBebidas.getString("descripcion"));
                bebida.setPrecio_unitario(rsBebidas.getDouble("precio_unitario"));
                bebida.setCategoriaNombre(rsBebidas.getString("categoriaNombre"));
                bebida.setDisponibilidad(rsBebidas.getBoolean("disponibilidad"));
                listaBebidas.add(bebida);
            }

            request.setAttribute("bebidas", listaBebidas);
            request.setAttribute("categorias", listaCategorias);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/viewDrink.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener las bebidas: " + e);
        } finally {
            try {
                if (rsBebidas != null) {
                    rsBebidas.close();
                }
                if (rsCategorias != null) {
                    rsCategorias.close();
                }
                if (psBebidas != null) {
                    psBebidas.close();
                }
                if (psCategorias != null) {
                    psCategorias.close();
                }
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
