package controller;

import configuration.ConnectionBD;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.OrdenesModel;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/carrito")
public class CarritoServlet extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoriaIdParam = request.getParameter("categoriaId");

        if (categoriaIdParam == null || categoriaIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/categorias");
            return;
        }

        int categoriaId;
        try {
            categoriaId = Integer.parseInt(categoriaIdParam);
            OrdenesModel orden = obtenerOrdenPorCategoria(categoriaId);
            if (orden == null) {
                response.sendRedirect(request.getContextPath() + "/categorias");
                return;
            }

            HttpSession session = request.getSession();
            List<OrdenesModel> carrito = (List<OrdenesModel>) session.getAttribute("carrito");

            if (carrito == null) {
                carrito = new ArrayList<>();
            }

            carrito.add(orden);
            session.setAttribute("carrito", carrito);
        } catch (SQLException e) {
            response.sendRedirect(request.getContextPath() + "/categorias");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/pages/cajero/carrito.jsp");
    }

    private OrdenesModel obtenerOrdenPorCategoria(int categoriaId) throws SQLException {
        OrdenesModel orden = null;

        String sql = "SELECT id, nombre, notas FROM ordenes WHERE categoria_id = ?";
        try ( Connection con = new ConnectionBD().getConnectionBD()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, categoriaId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    orden = new OrdenesModel();
                    orden.setId(rs.getInt("id"));
                    orden.setNombre(rs.getString("nombre"));
                    orden.setNotas(rs.getString("notas"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orden;
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
