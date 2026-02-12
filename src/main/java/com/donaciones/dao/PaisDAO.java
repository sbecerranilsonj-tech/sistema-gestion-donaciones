package com.donaciones.dao;

import com.donaciones.conf.DatabaseConnection;
import com.donaciones.model.Pais;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PaisDAO {

    public List<Pais> listar() {
        List<Pais> lista = new ArrayList<>();
        String sql = "SELECT id_pais, nombre FROM pais";

        try (Connection con = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Pais pais = new Pais();
                pais.setId_pais(rs.getInt("id_pais"));
                pais.setNombre(rs.getString("nombre"));
                lista.add(pais);
            }

        } catch (SQLException e) {
            System.err.println("Error en PaisDAO.listar()");
            e.printStackTrace();
        }
        return lista;
    }
}
