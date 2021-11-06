package com.netbeans.model;

//Por cada tabla creo una clase con sus variables y metodo get y set
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;
import java.util.Date;

public class Productos implements Serializable {

    private Integer codProducto;
    private String nombreProducto;
    private BigDecimal precioVenta;
    private int stockMinimo;
    private int stockActual;
    private String codBarra;
    private Date fechaInicio;
    private Date fechaFinal;
    private int otrosProductos;
    private int estado;

    //----No refleja los datos de la tabla, se usan para realizar logica
    private Set<Detallefactura> detallefacturas = new HashSet<Detallefactura>(0);
    private boolean check;
    private boolean check2;
    private int cantidad;

    /* //Requerido por onmifaces
  @Override
public String toString() {
    return String.format("%s[id=%d]", getClass().getSimpleName(), getCodigo());
}

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 29 * hash + this.codigo;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Productos other = (Productos) obj;
        if (this.codigo != other.codigo) {
            return false;
        }
        return true;
    }*/
    //<editor-fold defaultstate="collapsed" desc="GET SET">    
    public boolean isCheck2() {
        return check2;
    }

    public void setCheck2(boolean check2) {
        if (check2) {
            estado = 1;
        } else {
            estado = 0;
        }
        this.check2 = check2;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public boolean isCheck() {
        return check;
    }

    public void setCheck(boolean check) {
        if (check) {
            otrosProductos = 1;
        } else {
            otrosProductos = 0;
        }
        this.check = check;
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

    public int getOtrosProductos() {
        return otrosProductos;
    }

    public void setOtrosProductos(int otrosProductos) {
        this.otrosProductos = otrosProductos;
    }

    public Integer getCodProducto() {
        return codProducto;
    }

    public void setCodProducto(Integer codProducto) {
        this.codProducto = codProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public BigDecimal getPrecioVenta() {
        return precioVenta;
    }

    public void setPrecioVenta(BigDecimal precioVenta) {
        this.precioVenta = precioVenta;
    }

    public int getStockMinimo() {
        return stockMinimo;
    }

    public void setStockMinimo(int stockMinimo) {
        this.stockMinimo = stockMinimo;
    }

    public int getStockActual() {
        return stockActual;
    }

    public void setStockActual(int stockActual) {
        this.stockActual = stockActual;
    }

    public String getCodBarra() {
        return codBarra;
    }

    public void setCodBarra(String codBarra) {
        this.codBarra = codBarra;
    }

    public Set<Detallefactura> getDetallefacturas() {
        return detallefacturas;
    }

    public void setDetallefacturas(Set<Detallefactura> detallefacturas) {
        this.detallefacturas = detallefacturas;
    }
    //</editor-fold>

}
