package com.donaciones.dao;

import com.donaciones.conf.DatabaseConnection;
import com.donaciones.model.Donante;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DonanteDAO {

    // LISTAR
    public List<Donante> listar() {
        List<Donante> lista = new ArrayList<>();
        String sql = "SELECT * FROM donante";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DatabaseConnection.getInstance().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Donante d = new Donante();
                d.setIdDonante(rs.getInt("id_donante"));
                d.setNombre(rs.getString("nombre"));
                d.setEmail(rs.getString("email"));
                d.setTelefono(rs.getString("telefono"));
                d.setDireccion(rs.getString("direccion"));
                d.setTipoDonante(rs.getString("tipo_donante"));
                d.setIdPais(rs.getInt("id_pais"));
                d.setFechaRegistro(rs.getDate("fecha_registro"));
                lista.add(d);
            }

        } catch (Exception e) {
            System.err.println("Error en DonanteDAO.listar()");
            e.printStackTrace();
        } finally {
            cerrar(rs, ps);
        }
        return lista;
    }

    // INSERTAR
    public boolean insertar(Donante d) {
        String sql = "INSERT INTO donante(nombre,email,telefono,direccion,tipo_donante,id_pais,fecha_registro) VALUES (?,?,?,?,?,?,?)";

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DatabaseConnection.getInstance().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, d.getNombre());
            ps.setString(2, d.getEmail());
            ps.setString(3, d.getTelefono());
            ps.setString(4, d.getDireccion());
            ps.setString(5, d.getTipoDonante());
            ps.setInt(6, d.getIdPais());
            ps.setDate(7, d.getFechaRegistro());
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.err.println("Error en DonanteDAO.insertar()");
            e.printStackTrace();
            return false;
        } finally {
            cerrar(null, ps);
        }
    }

    // OBTENER POR ID
    public Donante obtener(int id) {
        Donante d = null;
        String sql = "SELECT * FROM donante WHERE id_donante=?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DatabaseConnection.getInstance().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                d = new Donante();
                d.setIdDonante(rs.getInt("id_donante"));
                d.setNombre(rs.getString("nombre"));
                d.setEmail(rs.getString("email"));
                d.setTelefono(rs.getString("telefono"));
                d.setDireccion(rs.getString("direccion"));
                d.setTipoDonante(rs.getString("tipo_donante"));
                d.setIdPais(rs.getInt("id_pais"));
                d.setFechaRegistro(rs.getDate("fecha_registro"));
            }

        } catch (Exception e) {
            System.err.println("Error en DonanteDAO.obtener()");
            e.printStackTrace();
        } finally {
            cerrar(rs, ps);
        }
        return d;
    }

    // ACTUALIZAR
    public boolean actualizar(Donante d) {
        String sql = "UPDATE donante SET nombre=?,email=?,telefono=?,direccion=?,tipo_donante=?,id_pais=?,fecha_registro=? WHERE id_donante=?";

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DatabaseConnection.getInstance().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, d.getNombre());
            ps.setString(2, d.getEmail());
            ps.setString(3, d.getTelefono());
            ps.setString(4, d.getDireccion());
            ps.setString(5, d.getTipoDonante());
            ps.setInt(6, d.getIdPais());
            ps.setDate(7, d.getFechaRegistro());
            ps.setInt(8, d.getIdDonante());
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.err.println("Error en DonanteDAO.actualizar()");
            e.printStackTrace();
            return false;
        } finally {
            cerrar(null, ps);
        }
    }

    // ELIMINAR
    public boolean eliminar(int id) {
        String sql = "DELETE FROM donante WHERE id_donante=?";

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DatabaseConnection.getInstance().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.err.println("Error en DonanteDAO.eliminar()");
            e.printStackTrace();
            return false;
        } finally {
            cerrar(null, ps);
        }
    }

    // MÉTODO UTILITARIO PARA CERRAR RECURSOS
    private void cerrar(ResultSet rs, PreparedStatement ps) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
