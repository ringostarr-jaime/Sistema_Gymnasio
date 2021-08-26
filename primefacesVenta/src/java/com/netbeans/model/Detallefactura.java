/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netbeans.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author Jymmy
 */
public class Detallefactura implements Serializable {

    private Integer codDetalle;
    private Factura factura;
    private Productos producto;
    private String codBarra;
    private String nombreProducto;
    private int cantidad;
    private BigDecimal precioVenta;
    private BigDecimal total;
    private Date fechaInicio;
    private Date fechaFinal;

    private String fechaI;
    private String fechaF;

    public Detallefactura(Factura factura, Productos producto, String codBarra, String nombreProducto, int cantidad, BigDecimal precioVenta, BigDecimal total, Date fechaInicio, Date fechaFinal, String fechaI, String fechaF) {
        this.factura = factura;
        this.producto = producto;
        this.codBarra = codBarra;
        this.nombreProducto = nombreProducto;
        this.cantidad = cantidad;
        this.precioVenta = precioVenta;
        this.total = total;
        this.fechaInicio = fechaInicio;
        this.fechaFinal = fechaFinal;
        this.fechaI = fechaI;
        this.fechaF = fechaF;
    }

    //<editor-fold defaultstate="collapsed" desc="GET SET">
    public String getFechaI() {
        return fechaI;
    }

    public void setFechaI(String fechaI) {
        this.fechaI = fechaI;
    }

    public String getFechaF() {
        return fechaF;
    }

    public void setFechaF(String fechaF) {
        this.fechaF = fechaF;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFinal() {
        return fechaFinal;
    }

    public void setFechaFinal(Date fechaFinal) {
        this.fechaFinal = fechaFinal;
    }

    public Integer getCodDetalle() {
        return codDetalle;
    }

    public void setCodDetalle(Integer codDetalle) {
        this.codDetalle = codDetalle;
    }

    public Factura getFactura() {
        return factura;
    }

    public void setFactura(Factura factura) {
        this.factura = factura;
    }

    public Productos getProducto() {
        return producto;
    }

    public void setProducto(Productos producto) {
        this.producto = producto;
    }

    public String getCodBarra() {
        return codBarra;
    }

    public void setCodBarra(String codBarra) {
        this.codBarra = codBarra;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public BigDecimal getPrecioVenta() {
        return precioVenta;
    }

    public void setPrecioVenta(BigDecimal precioVenta) {
        this.precioVenta = precioVenta;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    //</editor-fold>
    public Detallefactura() {
    }

    public Detallefactura(Factura factura, Productos producto, String codBarra, String nombreProducto, int cantidad, BigDecimal precioVenta, BigDecimal total) {
        this.factura = factura;
        this.producto = producto;
        this.codBarra = codBarra;
        this.nombreProducto = nombreProducto;
        this.cantidad = cantidad;
        this.precioVenta = precioVenta;
        this.total = total;
    }

}
