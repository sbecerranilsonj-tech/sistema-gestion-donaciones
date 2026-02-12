package com.donaciones.model;

import java.io.Serializable;
import java.sql.Date;

public class Campania implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id_campania;
    private String nombre;
    private String descripcion;
    private Date fecha_inicio;
    private Date fecha_fin;
    private String estado;

    public Campania() {
    }

    public int getId_campania() {
        return id_campania;
    }

    public void setId_campania(int id_campania) {
        this.id_campania = id_campania;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Date getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
