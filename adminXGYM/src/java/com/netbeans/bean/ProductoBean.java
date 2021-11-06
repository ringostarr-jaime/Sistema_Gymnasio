package com.netbeans.bean;

import com.netbeans.DAO.ProductoDAO;
import com.netbeans.model.Productos;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import javax.faces.event.AjaxBehaviorEvent;

//Se debe usar la anotacion de ManagedBean para crear los beans
//aca iran todos los metodos de accion
@ManagedBean
@ViewScoped
public class ProductoBean implements Serializable {

    //Variable que controla la dinamicidad del boton nuevo o modificar
    private String accion;
    private Productos producto = new Productos();
    private List<Productos> listProductos;
    private List<Productos> listProductos2;
    private boolean ver;

    //<editor-fold defaultstate="collapsed" desc="GET ">
    public List<Productos> getListProductos2() {
        return listProductos2;
    }

    public void setListProductos2(List<Productos> listProductos2) {
        this.listProductos2 = listProductos2;
    }

    public boolean isVer() {
        return ver;
    }

    public void setVer(boolean ver) {
        this.ver = ver;
    }

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        limpiar();
        this.accion = accion;
    }

    public List<Productos> getListProductos() {
        return listProductos;
    }

    public void setListProductos(List<Productos> listProductos) {
        this.listProductos = listProductos;
    }

    public Productos getProducto() {
        return producto;
    }

    public void setProducto(Productos producto) {
        this.producto = producto;
    }

//</editor-fold>
    //<editor-fold defaultstate="collapsed" desc="CONSTRUCT POSTBACK">
    //Para manejar los postBack
    private boolean isPostBack() {
        boolean rpta;
        rpta = FacesContext.getCurrentInstance().isPostback();
        return rpta;
    }

    @PostConstruct
    public void iniciar() {
        ver = true;
    }

    //</editor-fold>
    //<editor-fold defaultstate="collapsed" desc="OPERAR">
    public void operar() throws Exception {
        switch (accion) {
            case "Registrar":
                this.registrar();
                this.limpiar();
                break;
            case "Modificar":
                this.modificar();
                this.limpiar();
                break;
        }
    }
//</editor-fold>   

    //<editor-fold defaultstate="collapsed" desc="LIMPIAR">
    public void limpiar() {
        this.producto.setCodBarra("");
        this.producto.setNombreProducto("");
        this.producto.setPrecioVenta(new BigDecimal(0));
        this.producto.setStockMinimo(0);
        this.producto.setStockActual(0);
        this.producto.setCodProducto(0);
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="MODIFICAR">
    public void modificar() throws Exception {
        ProductoDAO dao;
        try {
            dao = new ProductoDAO();
            if (producto.getCodProducto() > 0) {
                dao.modificar(producto);
            }
            this.listarProductosEstados("v", 1, -1, 0);
        } catch (Exception e) {
            throw e;
        }

    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="REGISTRAR">
    public void registrar() throws Exception {
        ProductoDAO dao;
        try {
            dao = new ProductoDAO();
            dao.registrar(producto);
            this.listarProductosEstados("v", 1, -1, 0);
            producto = new Productos();
        } catch (Exception e) {
            throw e;
        }

    }
//</editor-fold>

    public void listarProductos(String valor, int estado, int producto, int agregar) {
        ProductoDAO dao;
        try {
            if (valor.equals("f")) {
                if (isPostBack() == false) {
                    dao = new ProductoDAO();
                    listProductos = dao.listarProductosEstados(estado, producto, agregar);
                }
            } else {
                dao = new ProductoDAO();
                listProductos = dao.listarProductosEstados(estado, producto, agregar);
            }
        } catch (Exception e) {
        }
    }

    public void listarOtrosProductos(String valor, int estado, int producto, int agregar) {
        ProductoDAO dao;
        try {
            if (valor.equals("f")) {
                if (isPostBack() == false) {
                    dao = new ProductoDAO();
                    listProductos2 = dao.listarProductosEstados(estado, producto, agregar);
                }
            } else {
                dao = new ProductoDAO();
                listProductos2 = dao.listarProductosEstados(estado, producto, agregar);
            }
        } catch (Exception e) {
        }
    }

    public void listarProductosEstados(String valor, int estado, int producto, int agregar) {
        ProductoDAO dao;
        try {
            if (valor.equals("f")) {
                if (isPostBack() == false) {
                    dao = new ProductoDAO();
                    listProductos = dao.listarProductosEstados(estado, producto, agregar);
                }
            } else {
                dao = new ProductoDAO();
                listProductos = dao.listarProductosEstados(estado, producto, agregar);
            }
        } catch (Exception e) {
        }
    }

    public void leerID(Productos pro) throws Exception {
        ProductoDAO dao;
        Productos temp;
        try {
            dao = new ProductoDAO();
            temp = dao.leerId(pro);
            if (temp != null) {
                if (temp.getOtrosProductos() == 1) {
                    temp.setCheck(true);
                    ver = false;
                } else {
                    ver = true;
                }

                if (temp.getEstado() == 1) {
                    temp.setCheck2(true);
                } else {
                    temp.setCheck2(false);
                }

                this.producto = temp;
                this.accion = "Modificar";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    //<editor-fold defaultstate="collapsed" desc="ELIMINAR">
    public void eliminar(Productos pro) throws Exception {
        ProductoDAO dao;
        try {
            dao = new ProductoDAO();
            dao.eliminar(pro);
            this.listarProductosEstados("v", 1, -1, 0);
        } catch (Exception e) {
            throw e;
        }

    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="CAMBIO ESTADOS">
    public void cambioEstados() {
        if (this.ver) {
            ver = false;
        } else {
            ver = true;
        }
    }

    //</editor-fold>
    public void renderPanel(AjaxBehaviorEvent event) {
        if (ver) {
            ver = false;
        } else {
            ver = true;
        }
    }

}
