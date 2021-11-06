/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netbeans.model;

import java.io.Serializable;

/**
 *
 * @author Jymmy
 */
public class Permisos implements Serializable {

    private int idpermisos;
    private int valor;
    private String descripcion;
    private int modulos;

    public int getIdpermisos() {
        return idpermisos;
    }

    public void setIdpermisos(int idpermisos) {
        this.idpermisos = idpermisos;
    }

    public int getValor() {
        return valor;
    }

    public void setValor(int valor) {
        this.valor = valor;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getModulos() {
        return modulos;
    }

    public void setModulos(int modulos) {
        this.modulos = modulos;
    }

}
