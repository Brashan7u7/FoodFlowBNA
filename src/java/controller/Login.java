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
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author nayel
 */
@WebServlet(name = "Login", urlPatterns = {"/login"})
public class Login extends HttpServlet {

    private static final long serialVersionUID = 1L;

    Connection conn;
    PreparedStatement ps;
    Statement statement;
    ResultSet rs;

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
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        System.out.println("Entro al doPost");
        ConnectionBD conexion = new ConnectionBD();

        // Obtener los parámetros del formulario 
        String correo = request.getParameter("correo");
        String pin = request.getParameter("pin");

        try {
            conn = conexion.getConnectionBD();

            String sql = "SELECT pin, rol, nombre FROM usuarios WHERE correo = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, correo);
            rs = ps.executeQuery();
            System.out.println(correo);
            if (rs.next()) {
                String hashPWD = rs.getString("pin");
                String rol = rs.getString("rol");
                System.out.println(hashPWD);
                // Verificar la contraseña con BCrypt
                if (BCrypt.checkpw(pin, hashPWD)) {

                    HttpSession session = request.getSession();
                    // Guardar el correo en la sesión
                    session.setAttribute("correo", correo);
                    session.setAttribute("nombre", rs.getString("nombre"));
                    // Establecer la duración de la sesión (30 minutos)
                    session.setMaxInactiveInterval(1800);


                    /*
            Cookie cookie = new Cookie("Correo", curp);
            cookie.setMaxAge(900); // 15 minutos de duración (900 segundos)
            response.addCookie(cookie);

            // Establecer el tiempo de expiración de la cookie en la sesión
            session.setAttribute("tiempoExpiracionCookie", System.currentTimeMillis() + (900 * 1000)); // 15 minutos
                     */
                    // Verificar el rol del usuario
                    if ("administrador".equalsIgnoreCase(rol)) {
                        // Redirigir a la vista de administrador
                        response.sendRedirect(request.getContextPath() + "/pages/admin/vistaventas.jsp");
                    } else if ("cajero".equalsIgnoreCase(rol)){
                        // Redirigir a la vista de cajero
                        response.sendRedirect(request.getContextPath() + "/mostcategoriasservlet");
                    }
                } else {
                    System.out.println("Credenciales incorrectas");
                    request.setAttribute("error", "Credenciales incorrectas");
                    response.sendRedirect("./pages/xd.jsp");
                }
            } else {
                System.out.println("Usuario no encontrado");
                request.setAttribute("error", "Usuario no encontrado");
                request.getRequestDispatcher("./pages/xdd.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
            response.sendRedirect("./pages/xd.jsp");
        }
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
