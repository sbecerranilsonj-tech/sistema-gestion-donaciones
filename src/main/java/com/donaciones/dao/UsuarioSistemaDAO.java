package com.donaciones.dao;

import com.donaciones.conf.DatabaseConnection;
import com.donaciones.model.UsuarioSistema;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioSistemaDAO {

    public UsuarioSistema autenticar(String usuario, String password) {
        UsuarioSistema autenticado = autenticarConProcedimiento(usuario, password);
        if (autenticado != null) {
            return autenticado;
        }
        return autenticarConConsulta(usuario, password);
    }

    private UsuarioSistema autenticarConProcedimiento(String usuario, String password) {
        String sql = "{CALL sp_login_usuario(?, ?)}";

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             CallableStatement cs = con.prepareCall(sql)) {
            cs.setString(1, usuario);
            cs.setString(2, password);

            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    UsuarioSistema u = new UsuarioSistema();
                    u.setIdUsuario(rs.getInt("id_usuario"));
                    u.setNombre(rs.getString("nombre"));
                    u.setUsuario(rs.getString("usuario"));
                    u.setRol(rs.getString("rol"));
                    return u;
                }
            }
        } catch (SQLException e) {
            System.err.println("sp_login_usuario no disponible o con error. Se intenta autenticacion directa.");
        }
        return null;
    }

    private UsuarioSistema autenticarConConsulta(String usuario, String password) {
        String sql = """
                SELECT u.id_usuario, u.nombre, u.usuario, r.nombre AS rol
                FROM usuario_sistema u
                INNER JOIN rol_usuario r ON u.id_rol = r.id_rol
                WHERE u.usuario = ? AND u.password = ? AND u.estado = TRUE
                """;

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, usuario);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    UsuarioSistema u = new UsuarioSistema();
                    u.setIdUsuario(rs.getInt("id_usuario"));
                    u.setNombre(rs.getString("nombre"));
                    u.setUsuario(rs.getString("usuario"));
                    u.setRol(rs.getString("rol"));
                    return u;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en UsuarioSistemaDAO.autenticarConConsulta()");
            e.printStackTrace();
        }

        return null;
    }
}
