package com.donaciones.dao;

import com.donaciones.conf.DatabaseConnection;
import com.donaciones.model.Campania;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CampaniaDAO {

    // LISTAR
    public List<Campania> listar() {
        List<Campania> lista = new ArrayList<>();
        String sql = "SELECT * FROM campania";

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Campania c = new Campania();
                c.setId_campania(rs.getInt("id_campania"));
                c.setNombre(rs.getString("nombre"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setFecha_inicio(rs.getDate("fecha_inicio"));
                c.setFecha_fin(rs.getDate("fecha_fin"));
                c.setEstado(rs.getString("estado"));
                lista.add(c);
            }

        } catch (SQLException e) {
            System.err.println("Error en CampaniaDAO.listar()");
            e.printStackTrace();
        }
        return lista;
    }

    // INSERTAR
    public boolean insertar(Campania c) {
        String sql = "INSERT INTO campania(nombre, descripcion, fecha_inicio, fecha_fin, estado) VALUES (?,?,?,?,?)";

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getDescripcion());
            ps.setDate(3, c.getFecha_inicio());
            ps.setDate(4, c.getFecha_fin());
            ps.setString(5, c.getEstado());
            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.err.println("Error en CampaniaDAO.insertar()");
            e.printStackTrace();
            return false;
        }
    }

    // OBTENER POR ID
    public Campania obtener(int id) {
        Campania c = null;
        String sql = "SELECT * FROM campania WHERE id_campania=?";

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    c = new Campania();
                    c.setId_campania(rs.getInt("id_campania"));
                    c.setNombre(rs.getString("nombre"));
                    c.setDescripcion(rs.getString("descripcion"));
                    c.setFecha_inicio(rs.getDate("fecha_inicio"));
                    c.setFecha_fin(rs.getDate("fecha_fin"));
                    c.setEstado(rs.getString("estado"));
                }
            }

        } catch (SQLException e) {
            System.err.println("Error en CampaniaDAO.obtener()");
            e.printStackTrace();
        }
        return c;
    }

    // ACTUALIZAR
    public boolean actualizar(Campania c) {
        String sql = "UPDATE campania SET nombre=?, descripcion=?, fecha_inicio=?, fecha_fin=?, estado=? WHERE id_campania=?";

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getNombre());
            ps.setString(2, c.getDescripcion());
            ps.setDate(3, c.getFecha_inicio());
            ps.setDate(4, c.getFecha_fin());
            ps.setString(5, c.getEstado());
            ps.setInt(6, c.getId_campania());
            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.err.println("Error en CampaniaDAO.actualizar()");
            e.printStackTrace();
            return false;
        }
    }

    // ELIMINAR
    public boolean eliminar(int id) {
        String sql = "DELETE FROM campania WHERE id_campania=?";

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.err.println("Error en CampaniaDAO.eliminar()");
            e.printStackTrace();
            return false;
        }
    }
}
