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
public class Theme implements Serializable{
    
    private int posicion;
    private String nombre;
    private String tema;

    public Theme(int posicion, String nombre, String tema) {
        this.posicion = posicion;
        this.nombre = nombre;
        this.tema = tema;
    }
    
    
    

    public int getPosicion() {
        return posicion;
    }

    public void setPosicion(int posicion) {
        this.posicion = posicion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTema() {
        return tema;
    }

    public void setTema(String tema) {
        this.tema = tema;
    }
    
    
    
}
