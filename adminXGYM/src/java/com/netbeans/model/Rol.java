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
public class Rol implements Serializable{
    
    private int idrol;
    private String nombre;
    private String descripcion;
    private int estado;
    private String Pdescripcion;
    private String Mdescripcion;   
    private int idPermisos;
    
    //----roles_permisos
    private int idmodulos;
    
    //<editor-fold defaultstate="collapsed" desc="GET y SET">

    public int getIdmodulos() {
        return idmodulos;
    }

    public void setIdmodulos(int idmodulos) {
        this.idmodulos = idmodulos;
    }

    
    
    public int getIdPermisos() {
        return idPermisos;
    }

    public void setIdPermisos(int idPermisos) {
        this.idPermisos = idPermisos;
    }
    
    

    public String getPdescripcion() {
        return Pdescripcion;
    }

    public void setPdescripcion(String Pdescripcion) {
        this.Pdescripcion = Pdescripcion;
    }

    public String getMdescripcion() {
        return Mdescripcion;
    }

    public void setMdescripcion(String Mdescripcion) {
        this.Mdescripcion = Mdescripcion;
    }
    

    

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }   

    public int getIdrol() {
        return idrol;
    }

    public void setIdrol(int idrol) {
        this.idrol = idrol;
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
    
    //</editor-fold>
    
}
