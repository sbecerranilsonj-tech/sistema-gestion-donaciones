package com.donaciones.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;

public class Donacion implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id_donacion;
    private int id_donante;
    private Integer id_campania; // Puede ser nulo
    private String tipo_donacion;
    private String estado_donacion;
    private Date fecha_donacion;
    private BigDecimal monto; // DECIMAL(10,2)
    private String descripcion;

    // Campos adicionales para mostrar en la UI, no directamente en la tabla Donacion
    private String nombreDonante;
    private String nombreCampania;

    public Donacion() {
    }

    // Getters y Setters
    public int getId_donacion() {
        return id_donacion;
    }

    public void setId_donacion(int id_donacion) {
        this.id_donacion = id_donacion;
    }

    public int getId_donante() {
        return id_donante;
    }

    public void setId_donante(int id_donante) {
        this.id_donante = id_donante;
    }

    public Integer getId_campania() {
        return id_campania;
    }

    public void setId_campania(Integer id_campania) {
        this.id_campania = id_campania;
    }

    public String getTipo_donacion() {
        return tipo_donacion;
    }

    public void setTipo_donacion(String tipo_donacion) {
        this.tipo_donacion = tipo_donacion;
    }

    public String getEstado_donacion() {
        return estado_donacion;
    }

    public void setEstado_donacion(String estado_donacion) {
        this.estado_donacion = estado_donacion;
    }

    public Date getFecha_donacion() {
        return fecha_donacion;
    }

    public void setFecha_donacion(Date fecha_donacion) {
        this.fecha_donacion = fecha_donacion;
    }

    public BigDecimal getMonto() {
        return monto;
    }

    public void setMonto(BigDecimal monto) {
        this.monto = monto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getNombreDonante() {
        return nombreDonante;
    }

    public void setNombreDonante(String nombreDonante) {
        this.nombreDonante = nombreDonante;
    }

    public String getNombreCampania() {
        return nombreCampania;
    }

    public void setNombreCampania(String nombreCampania) {
        this.nombreCampania = nombreCampania;
    }
}
