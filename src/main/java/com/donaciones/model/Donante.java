package com.donaciones.model;

import java.io.Serializable;
import java.sql.Date;

public class Donante implements Serializable {

    private static final long serialVersionUID = 1L;

    private int idDonante;
    private String nombre;
    private String email;
    private String telefono;
    private String direccion;
    private String tipoDonante;
    private int idPais;
    private Date fechaRegistro;

    // Constructor vacío (obligatorio para JSP/DAO)
    public Donante() {
    }

    public int getIdDonante() {
        return idDonante;
    }

    public void setIdDonante(int idDonante) {
        this.idDonante = idDonante;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTipoDonante() {
        return tipoDonante;
    }

    public void setTipoDonante(String tipoDonante) {
        this.tipoDonante = tipoDonante;
    }

    public int getIdPais() {
        return idPais;
    }

    public void setIdPais(int idPais) {
        this.idPais = idPais;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
} 
