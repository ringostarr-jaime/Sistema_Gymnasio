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
public class ListaParametros implements Serializable{

    private String key;
    private String contenido;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public ListaParametros(String key, String contenido) {
        this.key = key;
        this.contenido = contenido;
    }

}
