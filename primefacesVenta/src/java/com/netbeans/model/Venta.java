package com.netbeans.model;
//Por cada tabla creo una clase con sus variables y metodo get y set

import java.io.Serializable;
import java.sql.Date;

public class Venta implements Serializable {

    private int codigo;
    private Date fecha;
    private Persona persona;
    private double monto;

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Persona getPersona() {
        return persona;
    }

    public void setPersona(Persona persona) {
        this.persona = persona;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

}
