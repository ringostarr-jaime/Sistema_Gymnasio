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
public class rol_permiso implements Serializable {

    private int idrol_permiso;
    private int idrol;
    private int idpermiso;

    public int getIdrol_permiso() {
        return idrol_permiso;
    }

    public void setIdrol_permiso(int idrol_permiso) {
        this.idrol_permiso = idrol_permiso;
    }

    public int getIdrol() {
        return idrol;
    }

    public void setIdrol(int idrol) {
        this.idrol = idrol;
    }

    public int getIdpermiso() {
        return idpermiso;
    }

    public void setIdpermiso(int idpermiso) {
        this.idpermiso = idpermiso;
    }
    
    

}
