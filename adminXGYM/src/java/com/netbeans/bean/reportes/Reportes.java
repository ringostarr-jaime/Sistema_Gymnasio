/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netbeans.bean.reportes;

import com.netbeans.model.ListaParametros;
import com.netbeans.reporte.ReporteMenu;
import com.util.HerramientasUtil;
import java.io.Serializable;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import java.util.List;
import javax.faces.application.FacesMessage;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;

import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;
import org.primefaces.event.SelectEvent;

/**
 *
 * @author Jymmy
 */
@ManagedBean
@RequestScoped
//@ViewScoped
public class Reportes implements Serializable {
    //Instancia hacia la clase reporteFactura        

    ReporteMenu rFactura = new ReporteMenu();
    FacesContext facesContext = FacesContext.getCurrentInstance();
    ServletContext servletContext = (ServletContext) facesContext.getExternalContext().getContext();
    //ruta foto logo
    String ruta2 = servletContext.getRealPath("/WEB-INF/");
    private Date fechaInicio;
    private Date fechaFin;
    private int years;
    private String estado;


    //<editor-fold defaultstate="collapsed" desc="GET y SET">

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    

    public int getYears() {
        return years;
    }

    public void setYears(int years) {
        this.years = years;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }
    //</editor-fold>  


    public void verReporte(int idCliente) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        //String ruta = servletContext.getRealPath("/Reportes/clientes/clienteEspecifico.jasper");
        String ruta = servletContext.getRealPath("/WEB-INF/Reportes/clientes/clienteEspecifico.jasper");
        List<ListaParametros> parametros = new ArrayList<>();
        parametros.add(new ListaParametros("CONTEXT", ruta2));
        parametros.add(new ListaParametros("idCliente", String.valueOf(idCliente)));

        rFactura.getReporte(ruta, parametros, true);
        FacesContext.getCurrentInstance().responseComplete();

    }

    public void verReporteFactura() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        //String ruta = servletContext.getRealPath("/Reportes/facturas/facturasMain.jasper");
        String ruta = servletContext.getRealPath("/WEB-INF/Reportes/facturas/facturasMain.jasper");
        
        if (fechaInicio != null && fechaFin != null) {
            List<ListaParametros> parametros = new ArrayList<>();
            parametros.add(new ListaParametros("CONTEXT", ruta2));
            parametros.add(new ListaParametros("fechaInicio", HerramientasUtil.yyyy_MM_dd.format(fechaInicio) + " 00:00:00"));
            parametros.add(new ListaParametros("fechaFin", HerramientasUtil.yyyy_MM_dd.format(fechaFin) + " 23:59:59"));
            System.out.println("== "+ruta);
            System.out.println("== "+(HerramientasUtil.yyyy_MM_dd.format(fechaInicio) + " 00:00:00"));
            System.out.println("== "+(HerramientasUtil.yyyy_MM_dd.format(fechaFin) + " 23:59:59"));
            rFactura.getReporte(ruta, parametros, true);
            FacesContext.getCurrentInstance().responseComplete();
        } else {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN, "Revisar", "Los campos de fecha estan vacios"));
        }

    }
    
    public void verReporteFacturaYears() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        //String ruta = servletContext.getRealPath("/Reportes/facturas/facturadoMes.jasper");
        String ruta = servletContext.getRealPath("/WEB-INF/Reportes/facturas/facturadoMes.jasper");
        if (years!=0) {
            List<ListaParametros> parametros = new ArrayList<>();
            parametros.add(new ListaParametros("CONTEXT", ruta2));
            parametros.add(new ListaParametros("years", ""+years));           
          
            rFactura.getReporte(ruta, parametros, true);
            FacesContext.getCurrentInstance().responseComplete();
        } else {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN, "Revisar", "El campo de año es requerido"));
        }

    }
    
    public void verReporteClientesMora() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        //String ruta = servletContext.getRealPath("/Reportes/clientes/clienteEspecifico.jasper");
        String ruta = servletContext.getRealPath("/WEB-INF/Reportes/clientes/clienteEspecifico.jasper");
        if (years!=0) {
            List<ListaParametros> parametros = new ArrayList<>();
            parametros.add(new ListaParametros("CONTEXT", ruta2));
            parametros.add(new ListaParametros("years", ""+years));           
          
            rFactura.getReporte(ruta, parametros, true);
            FacesContext.getCurrentInstance().responseComplete();
        } else {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN, "Revisar", "El campo de año es requerido"));
        }

    }

}
