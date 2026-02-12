package com.donaciones.dao;

import com.donaciones.conf.DatabaseConnection;
import com.donaciones.model.Donacion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DonacionDAO {

    // =========================
    // LISTAR (con JOIN)
    // =========================
    public List<Donacion> listar() {
        List<Donacion> lista = new ArrayList<>();

        String sql = """
            SELECT d.id_donacion, d.id_donante, dn.nombre AS nombreDonante,
                   d.id_campania, c.nombre AS nombreCampania,
                   d.tipo_donacion, d.estado_donacion,
                   d.fecha_donacion, d.monto, d.descripcion
            FROM donacion d
            INNER JOIN donante dn ON d.id_donante = dn.id_donante
            LEFT JOIN campania c ON d.id_campania = c.id_campania
        """;

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Donacion d = new Donacion();
                d.setId_donacion(rs.getInt("id_donacion"));
                d.setId_donante(rs.getInt("id_donante"));
                d.setNombreDonante(rs.getString("nombreDonante"));

                Integer idCampania = rs.getObject("id_campania", Integer.class);
                d.setId_campania(idCampania);
                d.setNombreCampania(rs.getString("nombreCampania"));

                d.setTipo_donacion(rs.getString("tipo_donacion"));
                d.setEstado_donacion(rs.getString("estado_donacion"));
                d.setFecha_donacion(rs.getDate("fecha_donacion"));
                d.setMonto(rs.getBigDecimal("monto"));
                d.setDescripcion(rs.getString("descripcion"));

                lista.add(d);
            }

        } catch (SQLException e) {
            System.err.println("Error en DonacionDAO.listar()");
            e.printStackTrace();
        }

        return lista;
    }

    // =========================
    // INSERTAR
    // =========================
    public boolean insertar(Donacion d) {

        String sql = """
            INSERT INTO donacion
            (id_donante, id_campania, tipo_donacion,
             estado_donacion, fecha_donacion, monto, descripcion)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, d.getId_donante());

            if (d.getId_campania() != null) {
                ps.setInt(2, d.getId_campania());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }

            ps.setString(3, d.getTipo_donacion());
            ps.setString(4, d.getEstado_donacion());
            ps.setDate(5, d.getFecha_donacion());
            ps.setBigDecimal(6, d.getMonto());
            ps.setString(7, d.getDescripcion());

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.err.println("Error en DonacionDAO.insertar()");
            e.printStackTrace();
            return false;
        }
    }

    // =========================
    // OBTENER POR ID
    // =========================
    public Donacion obtener(int id) {

        Donacion d = null;

        String sql = """
            SELECT d.id_donacion, d.id_donante, dn.nombre AS nombreDonante,
                   d.id_campania, c.nombre AS nombreCampania,
                   d.tipo_donacion, d.estado_donacion,
                   d.fecha_donacion, d.monto, d.descripcion
            FROM donacion d
            INNER JOIN donante dn ON d.id_donante = dn.id_donante
            LEFT JOIN campania c ON d.id_campania = c.id_campania
            WHERE d.id_donacion = ?
        """;

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    d = new Donacion();
                    d.setId_donacion(rs.getInt("id_donacion"));
                    d.setId_donante(rs.getInt("id_donante"));
                    d.setNombreDonante(rs.getString("nombreDonante"));

                    Integer idCampania = rs.getObject("id_campania", Integer.class);
                    d.setId_campania(idCampania);
                    d.setNombreCampania(rs.getString("nombreCampania"));

                    d.setTipo_donacion(rs.getString("tipo_donacion"));
                    d.setEstado_donacion(rs.getString("estado_donacion"));
                    d.setFecha_donacion(rs.getDate("fecha_donacion"));
                    d.setMonto(rs.getBigDecimal("monto"));
                    d.setDescripcion(rs.getString("descripcion"));
                }
            }

        } catch (SQLException e) {
            System.err.println("Error en DonacionDAO.obtener()");
            e.printStackTrace();
        }

        return d;
    }

    // =========================
    // ACTUALIZAR
    // =========================
    public boolean actualizar(Donacion d) {

        String sql = """
            UPDATE donacion
            SET id_donante = ?, id_campania = ?, tipo_donacion = ?,
                estado_donacion = ?, fecha_donacion = ?, monto = ?, descripcion = ?
            WHERE id_donacion = ?
        """;

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, d.getId_donante());

            if (d.getId_campania() != null) {
                ps.setInt(2, d.getId_campania());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }

            ps.setString(3, d.getTipo_donacion());
            ps.setString(4, d.getEstado_donacion());
            ps.setDate(5, d.getFecha_donacion());
            ps.setBigDecimal(6, d.getMonto());
            ps.setString(7, d.getDescripcion());
            ps.setInt(8, d.getId_donacion());

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.err.println("Error en DonacionDAO.actualizar()");
            e.printStackTrace();
            return false;
        }
    }

    // =========================
    // ELIMINAR
    // =========================
    public boolean eliminar(int id) {

        String sql = "DELETE FROM donacion WHERE id_donacion = ?";

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.err.println("Error en DonacionDAO.eliminar()");
            e.printStackTrace();
            return false;
        }
    }
}
