package com.donaciones.model;

import java.io.Serializable;

public class Pais implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id_pais;
    private String nombre;

    public Pais() {
    }

    public Pais(int id_pais, String nombre) {
        this.id_pais = id_pais;
        this.nombre = nombre;
    }

    public int getId_pais() {
        return id_pais;
    }

    public void setId_pais(int id_pais) {
        this.id_pais = id_pais;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
