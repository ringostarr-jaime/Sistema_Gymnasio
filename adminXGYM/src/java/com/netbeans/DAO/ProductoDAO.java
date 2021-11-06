package com.netbeans.DAO;

import com.netbeans.model.Productos;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;

//Aca van las consultas a la base de datos y extiendo de DAO que es la conexion a la base de datos
public class ProductoDAO extends DAO {

    public void registrar(Productos pro) throws SQLException, Exception {
        try {
            String sql1 = "insert into producto (nombreProducto,precioVenta,codBarra,stockActual,stockMinimo,estado,otrosProductos) values(?,?,?,?,?,?,?)";
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement(sql1);
            st.setString(1, pro.getNombreProducto().trim().toUpperCase());
            st.setBigDecimal(2, pro.getPrecioVenta());
            st.setString(3, (pro.getCodBarra().trim().equals("") ? "GENERICO" : pro.getCodBarra().trim()));
            st.setInt(4, pro.getStockActual());
            st.setInt(5, pro.getStockMinimo());
            st.setInt(6, 1);
            st.setInt(7, pro.getOtrosProductos());
            st.executeUpdate();
            st.close();
            this.getCn().commit();

            FacesMessage message = new FacesMessage("Exito", "los datos del producto fueron ingresados");
            FacesContext.getCurrentInstance().addMessage(null, message);
        } catch (Exception e) {
            this.getCn().rollback();
            throw e;
        } finally {
            this.cerrar();
        }
    }

    //<editor-fold defaultstate="collapsed" desc="LISTAR">
    public List<Productos> listarProductos() throws Exception {
        List<Productos> lista;
        ResultSet rs;
        try {
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("Select codProducto,nombreProducto,precioVenta,stockMinimo,stockActual,codBarra,fechaInicio,fechaFinal,otrosProductos from producto where otrosProductos=0");
            rs = st.executeQuery();
            lista = new ArrayList();
            while (rs.next()) {
                Productos pro = new Productos();
                pro.setCodProducto(rs.getInt("codProducto"));
                pro.setNombreProducto(rs.getString("nombreProducto"));
                pro.setPrecioVenta(rs.getBigDecimal("precioVenta"));
                pro.setStockMinimo(rs.getInt("stockMinimo"));
                pro.setStockActual(rs.getInt("stockActual"));
                pro.setCodBarra(rs.getString("codBarra"));
                pro.setFechaInicio(rs.getDate("fechaInicio"));
                pro.setFechaFinal(rs.getDate("fechaFinal"));
                pro.setOtrosProductos(rs.getInt("otrosProductos"));
                lista.add(pro);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            this.cerrar();
        }
        return lista;
    }
    //</editor-fold>

    //--1 -ACTIVO---0 DESACTIVADO
    //--1 -OTROS PRODUCTOS --0 PRODUCTOS
    public List<Productos> listarProductosEstados(int estado, int produ, int agregar) throws Exception {
        List<Productos> lista;
        String sql = "Select codProducto,nombreProducto,precioVenta,stockMinimo,stockActual,codBarra,otrosProductos,estado from producto where estado=? ";
        if (agregar == 1) {
            sql = sql.concat(" and otrosProductos=? ");
        }
        ResultSet rs;
        try {
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement(sql);
            st.setInt(1, estado);
            if (agregar == 1) {
                st.setInt(2, produ);
            }
            rs = st.executeQuery();
            lista = new ArrayList();
            while (rs.next()) {
                Productos pro = new Productos();
                pro.setCodProducto(rs.getInt("codProducto"));
                pro.setNombreProducto(rs.getString("nombreProducto"));
                pro.setPrecioVenta(rs.getBigDecimal("precioVenta"));
                pro.setStockMinimo(rs.getInt("stockMinimo"));
                pro.setStockActual(rs.getInt("stockActual"));
                pro.setCodBarra(rs.getString("codBarra"));
                pro.setOtrosProductos(rs.getInt("otrosProductos"));
                pro.setEstado(rs.getInt("estado"));
                lista.add(pro);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            this.cerrar();
        }
        return lista;
    }

    public Productos leerId(Productos pros) throws Exception {
        Productos pro = null;
        ResultSet rs;
        try {
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("select codProducto,nombreProducto,precioVenta,stockMinimo,stockActual,codBarra,fechaInicio,fechaFinal,otrosProductos,estado from producto where codProducto=?");
            st.setInt(1, pros.getCodProducto());
            rs = st.executeQuery();
            while (rs.next()) {
                pro = new Productos();
                pro.setCodBarra(rs.getString("codBarra"));
                pro.setNombreProducto(rs.getString("nombreProducto"));
                pro.setPrecioVenta(rs.getBigDecimal("precioVenta"));
                pro.setStockMinimo(rs.getInt("stockMinimo"));
                pro.setStockActual(rs.getInt("stockActual"));
                pro.setCodProducto(rs.getInt("codProducto"));
                pro.setFechaInicio(rs.getDate("fechaInicio"));
                pro.setFechaFinal(rs.getDate("fechaFinal"));
                pro.setOtrosProductos(rs.getInt("otrosProductos"));
                pro.setEstado(rs.getInt("estado"));
            }
        } catch (Exception e) {
            throw e;

        } finally {
            this.cerrar();
        }
        return pro;
    }

    public void modificar(Productos pro) throws SQLException, Exception {
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement("update producto set nombreProducto=?,precioVenta=?,stockMinimo=?,stockActual=?,codBarra=?,otrosProductos=?,estado=? where codProducto=?");
            st.setString(1, pro.getNombreProducto().trim().toUpperCase());
            st.setBigDecimal(2, pro.getPrecioVenta());
            st.setInt(3, pro.getStockMinimo());
            st.setInt(4, pro.getStockActual());
            st.setString(5, pro.getCodBarra());
            st.setInt(6, pro.getOtrosProductos());
            st.setInt(7, pro.getEstado());
            st.setInt(8, pro.getCodProducto());
            st.executeUpdate();
            st.close();
            this.getCn().commit();
            FacesMessage message = new FacesMessage("Exito", "los datos del producto fueron modificados");
            FacesContext.getCurrentInstance().addMessage(null, message);
        } catch (Exception e) {
            this.getCn().rollback();
            throw e;
        } finally {
            this.cerrar();
        }
    }

    public void eliminar(Productos pro) throws SQLException, Exception {
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement("delete from producto where codProducto=?");
            st.setInt(1, pro.getCodProducto());
            st.executeUpdate();
            this.getCn().commit();
            FacesMessage message = new FacesMessage("Exito", "los datos del producto fueron eliminados");
            FacesContext.getCurrentInstance().addMessage(null, message);
        } catch (Exception e) {
            this.getCn().rollback();
            throw e;
        } finally {
            this.cerrar();
        }
    }
}
