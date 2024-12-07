package controller;

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
import configuration.ConnectionBD;
import model.mostcategorias;

@WebServlet("/mostcategoriasservlet")
public class MostCategoriasServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<mostcategorias> categorias = new ArrayList<>();
        ConnectionBD connectionBD = new ConnectionBD();
        Connection connection = null;

        // Actualiza la consulta SQL para filtrar por estatus activo
        String sql = "SELECT id, nombre, imagen FROM categorias_platillos WHERE estatus = 'activo'";
        try {
            connection = connectionBD.getConnectionBD();
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            System.out.println("hola");
            System.out.println("Número de categorías encontradas: " + categorias.size());


            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String nombre = resultSet.getString("nombre");
                String imagen = resultSet.getString("imagen");
                categorias.add(new mostcategorias(id, nombre, imagen));
            }
            System.out.println(categorias);
        } catch (Exception e) {
            e.printStackTrace(); // Imprime el error en la consola
        } finally {
            try {
                if (connection != null && !connection.isClosed()) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Establece la lista de categorías como atributo de la solicitud
        request.setAttribute("categorias", categorias);
        // Redirige a la JSP que mostrará las categorías
        request.getRequestDispatcher("pages/cajero/menuinicial.jsp").forward(request, response);
    }
}