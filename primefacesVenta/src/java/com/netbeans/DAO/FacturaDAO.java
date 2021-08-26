/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netbeans.DAO;

import com.netbeans.model.Detallefactura;
import com.util.HerramientasUtil;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;


/**
 *
 * @author Jymmy
 */
public class FacturaDAO extends DAO{
    
     public int obtenerUlitmoId() throws Exception {      
        int id=0;
        ResultSet rs;
        try {
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("SELECT codFactura FROM ventas.factura ORDER BY codFactura DESC LIMIT 1");            
            rs = st.executeQuery();
            while (rs.next()) {
               id=rs.getInt("codFactura");
               
            }            
            
        } catch (Exception e) {
            System.out.println("==ERROR "+e);

        } finally {
            this.cerrar();
        }
        return id;
    }
     
     public int registrarFactura(List<Detallefactura> detalle,int numeroFactura, int idCliente,double total, int idUsuario) throws SQLException, Exception {
         int id=0;
        try {
            
            String sql1 = "INSERT INTO ventas.factura (numeroFactura,idusuarios,idclientes,totalVenta) values (?,?,?,?)";
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement(sql1,PreparedStatement.RETURN_GENERATED_KEYS);
            st.setInt(1,numeroFactura);
            st.setInt(2, idUsuario);
            st.setInt(3, idCliente);
            st.setDouble(4, total);           
            st.executeUpdate();
            
             ResultSet rs = st.getGeneratedKeys();
                if (rs != null && rs.next()) {
                    id = rs.getInt(1);
                }  
            
            st.close();
            this.getCn().commit();
            
            if(id>0)
            {
            registrarDetalleFactura(detalle,id);
            }
            
            //FacesMessage message = new FacesMessage("Exito", "los datos del producto fueron ingresados");
            //FacesContext.getCurrentInstance().addMessage(null, message);
        } catch (Exception e) {
            this.getCn().rollback();
            throw e;
        } finally {
            this.cerrar();
        }
        return id;
    }
    
     public int registrarDetalleFactura(List<Detallefactura> detalle, int idFactura) throws SQLException, Exception {
         int cantidad=0;
        try {
            
            String sql1 = "INSERT INTO ventas.detallefactura(codFactura,codProducto,codBarra,nombreProducto,cantidad,precioVenta,total,fechaInicio,fechaFinal) values (?,?,?,?,?,?,?,?,?)";
            this.Conectar();            
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement(sql1);
            for (int i = 0; i < detalle.size(); i++) {                
                st.setInt(1, idFactura);
                st.setInt(2, detalle.get(i).getProducto().getCodProducto());
                st.setString(3, detalle.get(i).getCodBarra());
                st.setString(4, detalle.get(i).getNombreProducto());      
                st.setInt(5, detalle.get(i).getCantidad()); 
                st.setBigDecimal(6, detalle.get(i).getPrecioVenta());  
                st.setBigDecimal(7, detalle.get(i).getPrecioVenta().multiply(new BigDecimal(detalle.get(i).getCantidad())));
                st.setDate(8, HerramientasUtil.convertir(detalle.get(i).getFechaInicio())); 
                st.setDate(9, HerramientasUtil.convertir(detalle.get(i).getFechaFinal())); 
                st.executeUpdate();
                cantidad++;
            }            
            st.close();
            
            if(cantidad==detalle.size())
            {
            this.getCn().commit();
            }else
            {
             this.getCn().rollback();
             this.cerrar();
             borrarFactura(idFactura);
            }            

            FacesMessage message = new FacesMessage("Exito", "los datos del producto fueron ingresados codigo factura "+idFactura);
            FacesContext.getCurrentInstance().addMessage(null, message);
        } catch (Exception e) {
            this.getCn().rollback();
            throw e;
        } finally {
            this.cerrar();
        }
        return cantidad;
    }
     
     public int borrarFactura (int idFactura) throws SQLException, Exception
     {
        int id = 0;
        try {           
                String sql = "DELETE FROM ventas.factura WHERE codFactura=?";  
                this.Conectar();
                this.getCn().setAutoCommit(false);
                PreparedStatement st = this.getCn().prepareStatement(sql);  
                st.setInt(1, idFactura);                
                id =st.executeUpdate(); 
                
                st.close();
                this.getCn().commit();

                //FacesMessage message = new FacesMessage("Exito", "los datos del cliente fueron eliminados");
                //FacesContext.getCurrentInstance().addMessage(null, message);
            
        } catch (Exception e) {
            this.getCn().rollback();
            //System.out.println("****ERROR eliminados " + e);
            FacesMessage message = new FacesMessage("Error de conexion");
            FacesContext.getCurrentInstance().addMessage(null, message);           
            id = 0;
        }
        finally
        {
        this.cerrar();
        }
     
        return id;
     }
    
}
