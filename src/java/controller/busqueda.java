/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import configuration.ConnectionBD;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoriaModel;
import model.ClienteFModel;
import model.PlatilloModel;
import model.VentaModel;

/**
 *
 * @author nayel
 */
@WebServlet(name = "busqueda", urlPatterns = {"/busqueda"})
public class busqueda extends HttpServlet {

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
            out.println("<title>Servlet busqueda</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet busqueda at " + request.getContextPath() + "</h1>");
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
        String tipo = request.getParameter("tipo");
        List<?> resultados = null;
        System.out.println(tipo);
        try {
            if (tipo != null && !tipo.isEmpty()) {
                switch (tipo) {
                    case "Usuarios":
                        resultados = buscarUsuarios();
                        break;
                    case "Platillos":
                        resultados = buscarPlatillos();
                        break;
                    case "Categorías":
                        resultados = buscarCategorias();
                        break;
                    case "Ventas":
                        resultados = buscarVentas();
                        break;
                    case "Fidelidad":
                        resultados = buscarFidelidad();
                        break;
                    default:
                        resultados = null;
                        break;
                }
            }

            request.setAttribute("tipo", tipo);
            request.setAttribute("resultados", resultados);
            request.getRequestDispatcher("/pages/admin/busquedaCompleta.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar la solicitud: " + e.getMessage());
        }
    }

    private List<Usuario> buscarUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT id, nombre, apellido_paterno, apellido_materno, correo, rol FROM usuarios";

        try ( Connection conn = new ConnectionBD().getConnectionBD();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                usuarios.add(new Usuario(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("apellido_paterno"),
                        rs.getString("apellido_materno"),
                        rs.getString("correo"),
                        rs.getString("rol")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarios;
    }

    private List<PlatilloModel> buscarPlatillos() {
        List<PlatilloModel> platillos = new ArrayList<>();
        String sql = "SELECT p.id, p.nombre, p.imagen, p.descripcion, p.precio_unitario, c.nombre AS categoriaNombre, p.disponibilidad "
                + "FROM platillos p "
                + "LEFT JOIN categorias_platillos c ON p.categoria_id = c.id";

        try ( Connection conn = new ConnectionBD().getConnectionBD();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PlatilloModel platillo = new PlatilloModel();
                platillo.setId(rs.getInt("id"));
                platillo.setNombre(rs.getString("nombre"));
                platillo.setImagen(rs.getString("imagen"));
                platillo.setDescripcion(rs.getString("descripcion"));
                platillo.setPrecio_unitario(rs.getDouble("precio_unitario"));
                platillo.setCategoriaNombre(rs.getString("categoriaNombre"));
                platillo.setDisponibilidad(rs.getBoolean("disponibilidad"));
                platillos.add(platillo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return platillos;
    }

    private List<CategoriaModel> buscarCategorias() {
        List<CategoriaModel> categorias = new ArrayList<>();
        String sql = "SELECT id, nombre, imagen, estatus FROM categorias_platillos";

        try ( Connection conn = new ConnectionBD().getConnectionBD();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CategoriaModel categoria = new CategoriaModel();
                categoria.setId(rs.getInt("id"));
                categoria.setNombre(rs.getString("nombre"));
                categoria.setImagen(rs.getString("imagen"));
                categoria.setEstatus(rs.getString("estatus"));
                categorias.add(categoria);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categorias;
    }

    public List<VentaModel> buscarVentas() {
        List<VentaModel> ventas = new ArrayList<>();
        String sql = "SELECT "
                + "    v.id AS orden_id, "
                + "    v.cliente_id, "
                + "    v.total, "
                + "    v.fecha, "
                + "    c.nombre AS cliente_nombre "
                + "FROM ventas v "
                + "LEFT JOIN clientes c ON v.cliente_id = c.id";

        try ( Connection conn = new ConnectionBD().getConnectionBD();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                VentaModel venta = new VentaModel();
                venta.setIdOrden(rs.getInt("orden_id"));
                venta.setClienteId(rs.getInt("cliente_id"));
                venta.setClienteNombre(rs.getString("cliente_nombre"));
                venta.setTotalOrden(rs.getDouble("total"));
                venta.setFecha(rs.getString("fecha")); // Convertir `Date` a `String` si es necesario
                ventas.add(venta);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ventas;
    }

    private List<ClienteFModel> buscarFidelidad() {
        List<ClienteFModel> clientes = new ArrayList<>();
        String sql = "SELECT id, nombre, telefono, compras FROM clientes_fidelidad";

        try ( Connection conn = new ConnectionBD().getConnectionBD();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ClienteFModel cliente = new ClienteFModel();
                cliente.setId(rs.getInt("id"));
                cliente.setNombre(rs.getString("nombre"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setCompras(rs.getInt("compras"));
                clientes.add(cliente);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clientes;
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
