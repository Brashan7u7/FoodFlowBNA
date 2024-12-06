package model;

import configuration.ConnectionBD;
import controller.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    /**
     * Actualiza la información de un usuario en la base de datos.
     * @param usuario El objeto Usuario con la información actualizada.
     * @return true si la actualización fue exitosa; false en caso contrario.
     */
    public boolean actualizarUsuario(Usuario usuario) {
        String sql = "UPDATE usuarios SET nombre = ?, apellido_paterno = ?, apellido_materno = ?, correo = ?, rol = ? WHERE id = ?";
        try (Connection con = new ConnectionBD().getConnectionBD();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Configurar los parámetros de la consulta
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellidoPaterno());
            ps.setString(3, usuario.getApellidoMaterno());
            ps.setString(4, usuario.getCorreo());
            ps.setString(5, usuario.getRol());
            ps.setInt(6, usuario.getId());

            // Ejecutar la consulta de actualización
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar el usuario: " + e.getMessage());
        }
        return false;
    }

    /**
     * Obtiene un usuario específico por su ID.
     * @param idUsuario El ID del usuario a buscar.
     * @return El objeto Usuario si se encuentra; null en caso contrario.
     */
    public Usuario obtenerUsuarioPorId(int idUsuario) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuarios WHERE id = ?";

        try (Connection conn = new ConnectionBD().getConnectionBD();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Configurar el parámetro de la consulta
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();

            // Construir el objeto Usuario a partir del resultado
            if (rs.next()) {
                usuario = new Usuario(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("apellido_paterno"),
                        rs.getString("apellido_materno"),
                        rs.getString("correo"),
                        rs.getString("rol")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener el usuario por ID: " + e.getMessage());
        }
        return usuario;
    }
    
     public boolean eliminarUsuario(int idUsuario) {
        String sql = "DELETE FROM usuarios WHERE id = ?";
        try (Connection con = new ConnectionBD().getConnectionBD();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Configurar el parámetro de la consulta
            ps.setInt(1, idUsuario);

            // Ejecutar la consulta de eliminación
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar el usuario: " + e.getMessage());
        }
        return false;
    }
     
     // Método para agregar un nuevo usuario
    public boolean agregarUsuario(Usuario usuario) {
        boolean usuarioAgregado = false;
        
        // Conectar a la base de datos
        try (Connection conn = new ConnectionBD().getConnectionBD()) {
            String sql = "INSERT INTO usuarios ( nombre, apellido_paterno, apellido_materno, correo, pin, rol) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellidoPaterno());
            ps.setString(3, usuario.getApellidoMaterno());
            ps.setString(4, usuario.getCorreo());
            ps.setString(5, usuario.getPin()); // Almacenar el PIN (encriptado idealmente)
            ps.setString(6, usuario.getRol());


            int filasInsertadas = ps.executeUpdate();
            if (filasInsertadas > 0) {
                usuarioAgregado = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Puedes registrar esto en un log en vez de imprimirlo
        }
        
        return usuarioAgregado;
    }
    
}
