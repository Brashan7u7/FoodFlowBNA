package controller;

import configuration.ConnectionBD;
import model.Platillo;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/filtradoCategorias")
public class filtradocategorias extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el parámetro 'id' de la categoría desde la URL
        String categoriaId = request.getParameter("id");
        System.out.println("Categoria seleccionada con ID: " + categoriaId);

        List<Platillo> platillos = new ArrayList<>();
        ConnectionBD connectionBD = new ConnectionBD();
        try (Connection connection = connectionBD.getConnectionBD()) {
            String sql = "SELECT id, nombre, imagen, precio_unitario FROM platillos WHERE categoria_id = ? AND disponibilidad = 1";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, categoriaId);  // Establecer el valor de categoria_id
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Platillo platillo = new Platillo();
                platillo.setId(resultSet.getInt("id"));
                platillo.setNombre(resultSet.getString("nombre"));
                platillo.setImagen(resultSet.getString("imagen"));
                platillo.setPrecioUnitario(resultSet.getDouble("precio_unitario"));
                platillos.add(platillo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Agregar la lista de platillos filtrados al request para pasarlos al JSP
        request.setAttribute("platillos", platillos);
        // Redirigir al JSP que muestra los platillos filtrados (categorias.jsp)
        request.getRequestDispatcher("pages/cajero/categorias.jsp").forward(request, response);
    }
}
