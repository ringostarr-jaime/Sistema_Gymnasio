/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netbeans.bean;

import com.netbeans.DAO.ClientesDAO;

import java.io.IOException;
import java.io.Serializable;

import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;

import javax.faces.context.FacesContext;
import javax.faces.event.PhaseId;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.StreamedContent;

/**
 * SOLO SE DEBE ENVIAR EL ID COMO PARAMETRO PARA REALIZAR LA BUSQUEDA SE REALIZA
 * POR MEDIO DE OTRO BEAN DEBIDO A PROBLEMAS CON LOS SCOPE
 *
 * @author Jymmy
 */
@ManagedBean
@ApplicationScoped
public class Images implements Serializable {

    public ClientesDAO cd = new ClientesDAO();

    public StreamedContent getImage() throws IOException, Exception {
        FacesContext context = FacesContext.getCurrentInstance();
        if (context.getCurrentPhaseId() == PhaseId.RENDER_RESPONSE) {
            return new DefaultStreamedContent();

        } else {
            // So, browser is requesting the image. Return a real StreamedContent with the image bytes.
            //return new DefaultStreamedContent(new ByteArrayInputStream(bytes), "image/png");
            String id = context.getExternalContext().getRequestParameterMap().get("id");
            return cd.getImage(Integer.parseInt(id));

        }
    }

    public StreamedContent obtenerImagen() throws IOException, Exception {
        FacesContext context = FacesContext.getCurrentInstance();
        if (context.getCurrentPhaseId() == PhaseId.RENDER_RESPONSE) {

            return new DefaultStreamedContent();
        } else {
            String id = context.getExternalContext().getRequestParameterMap().get("id2");
            return cd.getImage(Integer.parseInt(id));

        }
    }
}
