package com.netbeans.bean;

import com.netbeans.DAO.ClientesDAO;
import com.netbeans.DAO.FacturaDAO;
import com.netbeans.DAO.ProductoDAO;

import com.netbeans.model.Cliente;
import com.netbeans.model.Detallefactura;

import com.netbeans.model.Productos;

import com.util.HerramientasUtil;
import java.io.Serializable;
import java.math.BigDecimal;

import java.util.ArrayList;
import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import java.util.Date;
import javax.annotation.PostConstruct;

@ManagedBean
@ViewScoped
public class VentaBeans implements Serializable {

    private Productos producto = new Productos();
    private Date fechaInicio;
    private Date fechaFinal;
    private List<Detallefactura> listaDetalleFactura = new ArrayList<>();
    private List<Detallefactura> listaDetalleFactura2 = new ArrayList<>();
    public List<Detallefactura> listaDetalleFactura3;
    private int ultimoIdFactura;
    private boolean ver;

    //VentaBeans ventaBean = new VentaBeans();
    private List<Cliente> clientesLista;
    private Cliente clientes = new Cliente();
    //double totalvendido = 0;
    //double mon, m2;

    @PostConstruct
    public void iniciar() {
        ver = true;
    }

    //<editor-fold defaultstate="collapsed" desc="GET SET">
    public boolean isVer() {
        return ver;
    }

    public void setVer(boolean ver) {
        this.ver = ver;
    }

    public List<Cliente> getClientesLista() {
        return clientesLista;
    }

    public void setClientesLista(List<Cliente> clientesLista) {
        this.clientesLista = clientesLista;
    }

    public Cliente getClientes() {
        return clientes;
    }

    public void setClientes(Cliente clientes) {
        this.clientes = clientes;
    }

    public List<Detallefactura> getListaDetalleFactura3() {
        return listaDetalleFactura3;
    }

    public void setListaDetalleFactura3(List<Detallefactura> listaDetalleFactura3) {
        this.listaDetalleFactura3 = listaDetalleFactura3;
    }

    /*public double getTotalvendido() {
        return totalvendido;
    }

    public void setTotalvendido(double totalvendido) {
        this.totalvendido = totalvendido;
    }*/
    public int getUltimoIdFactura() {
        return ultimoIdFactura;
    }

    public void setUltimoIdFactura(int ultimoIdFactura) {
        this.ultimoIdFactura = ultimoIdFactura;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        if (fechaInicio != null) {
            this.fechaInicio = fechaInicio;
        }

    }

    public Date getFechaFinal() {
        return fechaFinal;
    }

    public void setFechaFinal(Date fechaFinal) {
        if (fechaFinal != null) {
            this.fechaFinal = fechaFinal;
        }

    }

    public List<Detallefactura> getListaDetalleFactura2() {
        return listaDetalleFactura2;
    }

    public void setListaDetalleFactura2(List<Detallefactura> listaDetalleFactura2) {
        this.listaDetalleFactura2 = listaDetalleFactura2;
    }

    public List<Detallefactura> getListaDetalleFactura() {
        return listaDetalleFactura;
    }

    public void setListaDetalleFactura(List<Detallefactura> listaDetalleFactura) {
        this.listaDetalleFactura = listaDetalleFactura;
    }

    public Productos getProducto() {
        return producto;
    }

    public void setProducto(Productos producto) {
        this.producto = producto;
    }

//</editor-fold>
    /*public void agregar() {
        if(producto!=null)
        {
        DetalleVenta det = new DetalleVenta();
        det.setCantidad(cantidad);
        det.setProducto(producto);
        this.lista.add(det);
        }
     
    }*/
    public void registrar() throws Exception {
        FacturaDAO dao;

        try {
             //----Unir 2 listas
            (listaDetalleFactura3 = new ArrayList<>(listaDetalleFactura)).addAll(listaDetalleFactura2);
            if (clientes.getNombreCompleto() != null && listaDetalleFactura3.size() > 0 && valueSellTotal3() > 0) {
                IndexBean ib = new IndexBean();
                dao = new FacturaDAO();
                dao.registrarFactura(listaDetalleFactura3, ultimoIdFactura, clientes.getIdcliente(), valueSellTotal3(), ib.idUsuario());
                cambioEstados();
                //Mensaje de exito si la venta fue exitosa
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Exito", ""));
                //<p:growl id="msj" autoUpdate="true" showDetail="true"></p:growl> necesario para que el xml muestre el mensaje
            } else {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN, "Aviso", "Debe llenar los campos de cliente y productos"));
            }

        } catch (Exception e) {
            //throw e;
            System.out.println("==ER " + e);
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Aviso " + e, "Error al insertar los datos"));
        } finally {
            FacesContext.getCurrentInstance().getExternalContext().getFlash().setKeepMessages(true);
        }
    }

    private boolean isPostBack() {
        boolean rpta;
        rpta = FacesContext.getCurrentInstance().isPostback();
        return rpta;
    }

    public double totalp(double g, int ca) {
        double monto = 0;
        monto = g * ca;
        //totalv(monto);
        if (monto > 0) {
            monto = HerramientasUtil.convertir2decimales(monto);
        }
        return monto;
    }

    /* public void totalv(double g) {

        if (totalvendido == 0) {
            mon = g;
            setTotalvendido(mon);
        } else {
            setTotalvendido(totalvendido + mon);
        }
    }*/
    public void buscarProducto(Productos pro) throws Exception {
        ProductoDAO dao;
        Productos temp;
        try {
            dao = new ProductoDAO();
            //if (cantidad > 0) {
            if (pro.getCantidad() > 0) {
                temp = dao.leerId(pro);
                if (temp != null) {
                    this.producto = temp;
                    if (producto.getOtrosProductos() == 1) {
                        if (fechaInicio != null && fechaFinal != null) {
                            this.listaDetalleFactura2.add(new Detallefactura(null, producto, this.producto.getCodBarra(), this.producto.getNombreProducto(), pro.getCantidad(), this.producto.getPrecioVenta(), new BigDecimal(valueSellTotal2()), fechaInicio, fechaFinal, (HerramientasUtil.dd_MM_yyyyy.format(fechaInicio)), (HerramientasUtil.dd_MM_yyyyy.format(fechaFinal))));
                        } else {
                            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN, "Debe llenar los campos de fecha", ""));
                        }
                    } else {
                        this.listaDetalleFactura.add(new Detallefactura(null, producto, this.producto.getCodBarra(), this.producto.getNombreProducto(), pro.getCantidad(), this.producto.getPrecioVenta(), new BigDecimal(valueSellTotal())));
                    }
                    producto= new Productos();
                    fechaInicio = null;
                    fechaFinal= null;
                    
                }
            } else {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN, "Campo cantidad vacio", ""));
            }

        } catch (Exception e) {
            throw e;
        }
    }

    /*public int getValueBuyTotal() {
        int quantity = 0;
        for (Detallefactura p : listaDetalleFactura) {
            quantity += p.getCantidad();
        }
        return quantity;
    }*/
    //<editor-fold defaultstate="collapsed" desc="valueSellTotal">
    public double valueSellTotal() {
        double quantity = 0;
        for (Detallefactura p : listaDetalleFactura) {
            quantity += p.getCantidad() * p.getPrecioVenta().doubleValue();
            if (quantity > 0) {
                quantity = HerramientasUtil.convertir2decimales(quantity);
            }
        }
        return quantity;
    }

    public double valueSellTotal2() {
        double quantity = 0;
        for (Detallefactura p : listaDetalleFactura2) {
            quantity += p.getCantidad() * p.getPrecioVenta().doubleValue();
            if (quantity > 0) {
                quantity = HerramientasUtil.convertir2decimales(quantity);
            }
        }
        return quantity;
    }

    public double valueSellTotal3() {
        double quantity = 0;
        quantity = valueSellTotal() + valueSellTotal2();
        return quantity;
    }
    //</editor-fold>

    public void obtenerUltimo(String valor) {
        try {
            FacturaDAO f = new FacturaDAO();
            if (valor.equals("f")) {
                if (isPostBack() == false) {
                    ultimoIdFactura = (f.obtenerUlitmoId() + 1);
                }
            } else {
                ultimoIdFactura = (f.obtenerUlitmoId() + 1);
            }
        } catch (Exception e) {
        }

    }

    //<editor-fold defaultstate="collapsed" desc="QUITAR">    
    public void quitar1(Detallefactura detalle) {
        for (Detallefactura detallefactura : listaDetalleFactura) {
            if (detallefactura.getProducto().getCodProducto() == detalle.getProducto().getCodProducto()) {
                listaDetalleFactura.remove(detalle);
                break;
            }
        }
    }

    public void quitar2(Detallefactura detalle) {
        for (Detallefactura detallefactura : listaDetalleFactura2) {
            if (detallefactura.getProducto().getCodProducto() == detalle.getProducto().getCodProducto()) {
                listaDetalleFactura2.remove(detalle);
                break;
            }
        }
    }
//</editor-fold>

    public void leerID(Cliente cl) throws Exception {
        ClientesDAO dao;
        try {
            dao = new ClientesDAO();
            this.clientes = dao.leerId(cl);
        } catch (Exception e) {
            throw e;
        }
    }

    public void listarClientes2(int opcion, String valor) {
        ClientesDAO cd;
        try {
            if (valor.equals("f")) {
                if (isPostBack() == false) {
                    cd = new ClientesDAO();
                    clientesLista = cd.listarClientesAll(opcion);
                }
            } else {
                cd = new ClientesDAO();
                clientesLista = cd.listarClientesAll(opcion);
            }
        } catch (Exception e) {
        }

    }

    public void cambioEstados() {
        if (this.ver) {
            ver = false;
        } else {
            ver = true;
        }
    }

}
