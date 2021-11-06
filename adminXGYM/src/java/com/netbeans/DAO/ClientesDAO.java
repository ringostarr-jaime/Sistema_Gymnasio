/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netbeans.DAO;

import com.netbeans.model.Cliente;

import com.netbeans.model.contarTablas;
import com.util.HerramientasUtil;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.StreamedContent;
import org.primefaces.model.UploadedFile;

/**
 *
 * @author Jymmy
 */
public class ClientesDAO extends DAO {

    //<editor-fold defaultstate="collapsed" desc="GUARDAR CLIENTE INSERT">
    public int guardarCliente(Cliente clientes, int age) throws Exception {
        int id = 0;
        try {
            if (clientes != null) {
                String sql = "";
                if (age > 0) {
                    sql = "INSERT INTO ventas.clientes (nombres,apellidos,telefono,correo,estado,nota,dui,fechaNacimiento) VALUES (?,?,?,?,?,?,?,?)";
                } else {
                    sql = "INSERT INTO ventas.clientes (nombres,apellidos,telefono,correo,estado,nota,dui) VALUES (?,?,?,?,?,?,?)";
                }

                this.Conectar();
                this.getCn().setAutoCommit(false);
                PreparedStatement st = this.getCn().prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
                st.setString(1, clientes.getNombre());
                st.setString(2, clientes.getApellido());
                st.setString(3, clientes.getTelefono());
                //System.out.println("****FECHA1 " + clientes.getFechaNac()); 
                st.setString(4, clientes.getCorreo());
                st.setInt(5, 1); //---ESTADO ACTIVO se crean activos
                st.setString(6, clientes.getNota());
                st.setString(7, clientes.getDui());
                if (age > 0) {
                    st.setDate(8, HerramientasUtil.convertir(clientes.getFechaNac()));
                }
                st.executeUpdate();

                ResultSet rs = st.getGeneratedKeys();
                if (rs != null && rs.next()) {
                    id = rs.getInt(1);
                }
                st.close();

                this.getCn().commit();

                FacesMessage message = new FacesMessage("Exito", "los datos del cliente fueron ingresados");
                FacesContext.getCurrentInstance().addMessage(null, message);

            }
        } catch (Exception e) {
            this.getCn().rollback();
            System.out.println("****ERROR guardarCliente " + e);
            FacesMessage message = new FacesMessage("Error de conexion");
            FacesContext.getCurrentInstance().addMessage(null, message);
            id = 0;
        } finally {
            this.cerrar();
        }

        return id;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="ELIMINAR">
    public int eliminarCliente(Cliente clientes) throws Exception {
        int id = 0;
        try {
            if (clientes != null) {
                String sql = "";
                sql = "DELETE FROM ventas.clientes where idclientes=? ";
                //System.out.println("====SQL modificar " + sql);              
                this.Conectar();
                this.getCn().setAutoCommit(false);
                PreparedStatement st = this.getCn().prepareStatement(sql);
                st.setInt(1, clientes.getIdcliente());
                if (st.executeUpdate() > 0) {
                    id = clientes.getIdcliente();
                }
                st.close();
                this.getCn().commit();

                FacesMessage message = new FacesMessage("Exito", "los datos del cliente fueron eliminados");
                FacesContext.getCurrentInstance().addMessage(null, message);

            }
        } catch (Exception e) {
            this.getCn().rollback();
            System.out.println("****ERROR eliminados " + e);
            FacesMessage message = new FacesMessage("Error de conexion");
            FacesContext.getCurrentInstance().addMessage(null, message);
            id = 0;
        } finally {
            this.cerrar();
        }

        return id;
    }
//</editor-fold>    

    //<editor-fold defaultstate="collapsed" desc="MODIFICAR CLIENTE ">
    public int modificarCliente(Cliente clientes) throws Exception {
        int id = 0;
        try {
            if (clientes != null) {
                String sql = "";
                sql = "UPDATE  ventas.clientes SET nombres=?,apellidos=?,correo=?,estado=?,fechaNacimiento=?,nota=?,telefono=?,dui=? where idclientes=? ";
                //System.out.println("====SQL modificar " + sql);              
                this.Conectar();
                this.getCn().setAutoCommit(false);
                PreparedStatement st = this.getCn().prepareStatement(sql);
                st.setString(1, clientes.getNombre());
                st.setString(2, clientes.getApellido());
                st.setString(3, clientes.getCorreo());
                st.setInt(4, clientes.getEstado());
                st.setDate(5, HerramientasUtil.convertir(clientes.getFechaNac()));
                st.setString(6, clientes.getNota());
                st.setString(7, clientes.getTelefono());
                st.setString(8, clientes.getDui());
                st.setInt(9, clientes.getIdcliente());

                if (st.executeUpdate() > 0) {
                    id = clientes.getIdcliente();
                }
                st.close();
                this.getCn().commit();

                FacesMessage message = new FacesMessage("Exito", "los datos del cliente fueron modificados");
                FacesContext.getCurrentInstance().addMessage(null, message);

            }
        } catch (Exception e) {
            this.getCn().rollback();
            System.out.println("****ERROR modificarCliente " + e);
            FacesMessage message = new FacesMessage("Error de conexion");
            FacesContext.getCurrentInstance().addMessage(null, message);
            id = 0;
        } finally {
            this.cerrar();
        }

        return id;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="GUARDAR FOTO">
    public int upload(UploadedFile file, int modulo, int id, String descripcion) throws Exception {
        int idimagen = 0;
        try {
            if (file != null && file.getSize() > 0) {
                this.Conectar();
                this.getCn().setAutoCommit(false);
                PreparedStatement st = this.getCn().prepareStatement("INSERT INTO ventas.imagenes (descripcion,id,imagen,idmodulo) VALUES(?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS);
                st.setString(1, descripcion);
                st.setInt(2, id);
                st.setBinaryStream(3, file.getInputstream());
                st.setInt(4, modulo);

                st.executeUpdate();

                ResultSet rs = st.getGeneratedKeys();
                if (rs != null && rs.next()) {
                    idimagen = rs.getInt(1);
                }
                st.close();
                this.getCn().commit();

                FacesMessage message = new FacesMessage("Exito", file.getFileName() + " fue sudibo ");
                FacesContext.getCurrentInstance().addMessage(null, message);

            }
        } catch (Exception e) {
            this.getCn().rollback();
            System.out.println("====upload " + e);
            FacesMessage message = new FacesMessage("Error de conexion");
            FacesContext.getCurrentInstance().addMessage(null, message);
            idimagen = 0;
        } finally {
            this.cerrar();
        }

        return idimagen;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="MODIFICAR FOTO">
    public int modificarUpload(UploadedFile file, int modulo, int id, String descripcion, int idFoto) throws Exception {
        int idimagen = 0;
        String sql = "";
        try {
            if (file != null && file.getSize() > 0) {
                if (descripcion.trim().equals("")) {
                    idimagen = 0;
                    sql = "UPDATE ventas.imagenes SET id=?, imagen=?, idmodulo=?  where idimagenes=? ";
                } else {
                    idimagen = 1;
                    sql = "UPDATE ventas.imagenes SET id=?, imagen=?, idmodulo=?, descripcion=?  where idimagenes=? ";
                }
                //System.out.println("====SQL modificar " + sql);
                this.Conectar();
                this.getCn().setAutoCommit(false);
                PreparedStatement st = this.getCn().prepareStatement(sql);

                st.setInt(1, id);
                st.setBinaryStream(2, file.getInputstream());
                st.setInt(3, modulo);
                if (idimagen > 0) {
                    st.setString(4, descripcion);
                    st.setInt(5, idFoto);
                } else {
                    st.setInt(4, idFoto);
                }
                idimagen = 0;

                if (st.executeUpdate() > 0) {
                    idimagen = id;
                }
                st.close();
                this.getCn().commit();

                FacesMessage message = new FacesMessage("Exito", file.getFileName() + " fue sudibo ");
                FacesContext.getCurrentInstance().addMessage(null, message);

            }
        } catch (Exception e) {
            this.getCn().rollback();
            System.out.println("====upload " + e);
            FacesMessage message = new FacesMessage("Error de conexion");
            FacesContext.getCurrentInstance().addMessage(null, message);
            idimagen = 0;
        } finally {
            this.cerrar();
        }

        return idimagen;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="METODO PARA BUSCAR UNA IMAGEN EN LA BASE DE DATOS Y REGRESARLA COMO IMAGEN SE DEBE ENVIAR UN ID">
    public StreamedContent getImage(int id) throws IOException, Exception {
        ResultSet rs;
        byte[] bytes = null;
        Blob byt = null;
        try {
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("select imagen from ventas.imagenes where idimagenes=? ");
            st.setInt(1, id);
            rs = st.executeQuery();
            while (rs.next()) {
                bytes = rs.getBytes("imagen");

            }
            return new DefaultStreamedContent(new ByteArrayInputStream(bytes), "image/png");

        } catch (Exception e) {
            FacesMessage message = new FacesMessage("Error de conexion " + e);
            FacesContext.getCurrentInstance().addMessage(null, message);
        } finally {
            this.cerrar();
        }

        return new DefaultStreamedContent();
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="LISTAR CLIENTES">
    public List<Cliente> listarClientesAll(int opcion) throws Exception {
        List<Cliente> lista;
        ResultSet rs;
        String sql = "";
        try {
            this.Conectar();
            sql = "SELECT idclientes,nombres,apellidos,telefono, fechaNacimiento,correo, estado, nota, (case  when idimagenes is NULL  then 0 else idimagenes end) as idimagenes,dui FROM ventas.clientes left join ventas.imagenes on id=idclientes ";
            switch (opcion) {
                case 1:
                    sql = sql.concat(" where estado in (0,1,2) order by idclientes asc");
                    break;
                case 2:
                    sql = sql.concat(" where estado =0 order by idclientes asc");
                    break;
                case 3:                   
                    sql = sql.concat(" where estado =1 order by idclientes asc");       
                    break;
                 case 4: 
                    sql = sql.concat(" where estado =2 order by idclientes asc");    
                    break;
            }

            PreparedStatement st = this.getCn().prepareStatement(sql);
            rs = st.executeQuery();
            lista = new ArrayList();
            while (rs.next()) {
                Cliente c = new Cliente();
                c.setIdcliente(rs.getInt("idclientes"));
                c.setNombre(rs.getString("nombres"));
                c.setApellido(rs.getString("apellidos"));
                c.setCorreo(rs.getString("correo"));
                c.setEstado(rs.getInt("estado"));
                c.setFechaNac(rs.getDate("fechaNacimiento"));
                c.setFecha2(rs.getString("fechaNacimiento"));
                c.setImagen(rs.getInt("idimagenes"));
                c.setNota(rs.getString("nota"));
                c.setTelefono(rs.getString("telefono"));
                c.setDui(rs.getString("dui"));                
                c.setNombreCompleto(rs.getString("nombres") + " " + rs.getString("apellidos"));
                lista.add(c);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            this.cerrar();
        }

        return lista;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="BUSCAR CLIENTES">
    public Cliente leerId(Cliente cl) throws Exception {
        Cliente c = null;
        ResultSet rs;
        String sql = "";
        try {
            this.Conectar();
            sql = "SELECT idclientes,nombres,apellidos,telefono, fechaNacimiento,correo, estado, nota, (case  when idimagenes is NULL  then 0 else idimagenes end) as idimagenes,dui FROM ventas.clientes left join ventas.imagenes on id=idclientes where idclientes=?";

            PreparedStatement st = this.getCn().prepareStatement(sql);
            st.setInt(1, cl.getIdcliente());
            rs = st.executeQuery();

            while (rs.next()) {
                c = new Cliente();
                c.setIdcliente(rs.getInt("idclientes"));
                c.setNombre(rs.getString("nombres"));
                c.setApellido(rs.getString("apellidos"));
                c.setCorreo(rs.getString("correo"));
                c.setEstado(rs.getInt("estado"));
                c.setFechaNac(rs.getDate("fechaNacimiento"));
                c.setFecha2(rs.getString("fechaNacimiento"));
                c.setImagen(rs.getInt("idimagenes"));
                c.setNota(rs.getString("nota"));
                c.setTelefono(rs.getString("telefono"));
                c.setDui(rs.getString("dui"));
                c.setNombreCompleto(rs.getString("nombres") + " " + rs.getString("apellidos"));

            }
        } catch (Exception e) {
            throw e;
        } finally {
            this.cerrar();
        }

        return c;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="CONTAR OBJETOS PASAR LA TABLA Y EL VALOR">
    public contarTablas contar(int datos[], String tablas[], int cantidad) throws Exception {
        contarTablas valor = null;
        ResultSet rs;
        String sql = "";
        try {
            sql = sql.concat("SELECT ");
            for (int i = 0; i < cantidad; i++) {
                if (i > 0 && i < cantidad) {
                    sql = sql.concat(",");
                }
                sql = sql.concat(" (SELECT count(*) FROM ventas." + tablas[i] + " where estado=" + datos[i] + " ) as '" + i + "' ");
                //System.out.println(sql);
            }
            sql = sql.concat(" FROM DUAL");

            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                valor = new contarTablas();
                valor.setCampo0(rs.getInt("0"));
                valor.setCampo1(rs.getInt("1"));
                valor.setCampo2(rs.getInt("2"));
            }

        } catch (Exception e) {
            throw e;
        } finally {
            this.cerrar();
        }
        return valor;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="LISTAR CLIENTES ACTIVOS">
    public List<Integer> listarClientesActivosId() throws Exception {
        List<Integer> lista;
        ResultSet rs;
        String sql = "";
        try {
            this.Conectar();

            //sql = "select idclientes from ventas.clientes where estado = 1";
            sql = "select idclientes from ventas.clientes where nombres<>'CLIENTE-GENERICO' ";

            PreparedStatement st = this.getCn().prepareStatement(sql);
            rs = st.executeQuery();
            lista = new ArrayList();
            while (rs.next()) {
                /*Cliente c = new Cliente();
                c.setIdcliente();  */
                lista.add(rs.getInt("idclientes"));
            }
        } catch (Exception e) {
            throw e;
        } finally {
            this.cerrar();
        }

        return lista;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="consultarSeguimiento">
    public int consultarSeguimiento() throws Exception {
        int respuesta = 0;
        ResultSet rs;
        String sql = "";
        try {
            this.Conectar();

            sql = " select IF ((select 1 from ventas.seguimiento where DATE(revisionfechaInicio) = DATE(NOW())),0,1) valor";
            PreparedStatement st = this.getCn().prepareStatement(sql);
            rs = st.executeQuery();
            while (rs.next()) {
                respuesta = rs.getInt("valor");
            }
        } catch (Exception e) {
            throw e;
        } finally {
            this.cerrar();
        }

        return respuesta;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="REVISAR CLIENTES EN MORA">
    public int revisarClientesMora(int id) throws Exception {
        int respuesta = 0;
        ResultSet rs;
        String sql = "";
        try {
            this.Conectar();
            sql = "select IF ((select f.idclientes from ventas.factura f inner join ventas.detallefactura df on f.codFactura = df.codFactura where idclientes = ?  and df.codProducto in (select codProducto from ventas.producto where otrosProductos = 1) and DATE(df.fechaFinal) >= (SELECT DATE(NOW())) group by df.fechaFinal order by df.fechaFinal desc limit 1),0,1) valor";
            PreparedStatement st = this.getCn().prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            while (rs.next()) {
                respuesta = rs.getInt("valor");
            }
        } catch (Exception e) {
            throw e;
        } finally {
            this.cerrar();
        }

        return respuesta;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="PASAR CLIENTES A MORA">
    public int updateClienteMora(int estado,int id) throws Exception {
        int respuesta=0;
        try {
            String sql = "";
            sql = "UPDATE ventas.clientes SET estado = ? WHERE idclientes=?";
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement(sql);
            st.setInt(1, estado);
            st.setInt(2, id);
            respuesta=st.executeUpdate();
            st.close();
            this.getCn().commit();

        } catch (Exception e) {
            this.getCn().rollback();
            respuesta = 0;
        } finally {
            this.cerrar();
        }

        return respuesta;
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="INSERTAR EN SEGUIMIENTO">
    public int insertSeguimiento() throws Exception {
        int respuesta=0;
        try {
            String sql = "";
            sql = "insert into ventas.seguimiento (revisado) values(1)";
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement(sql);           
            respuesta=st.executeUpdate();
            st.close();
            this.getCn().commit();

        } catch (Exception e) {
             System.out.println("===ERROR insertSeguimiento "+e);
            this.getCn().rollback();
            respuesta = 0;
        } finally {
            this.cerrar();
        }

        return respuesta;
    }
//</editor-fold>
    
    //<editor-fold defaultstate="collapsed" desc="BUSCAR ULTIMO PAGO DEL CLIENTE">
     public String ultimoPago(int id) throws Exception {    
        ResultSet rs;
        String sql = "";
        String datos="";
        try {
            this.Conectar();
            sql = "select d.nombreProducto producto ,d.fechaInicio inicio, d.fechaFinal final, f.totalVenta total from ventas.factura f inner join ventas.detallefactura d on d.codFactura = f.codFactura where f.idclientes=? and f.codFactura  = (select max(ff.codFactura) from ventas.factura ff inner join ventas.detallefactura d on d.codFactura = ff.codFactura inner join ventas.producto p on d.codProducto = p.codProducto where p.otrosProductos=1 and ff.idclientes=? and d.fechaFinal=( SELECT MAX(dd.fechaFinal) from ventas.detallefactura dd inner join ventas.factura fff on fff.codFactura = dd.codFactura inner join ventas.producto pp on dd.codProducto = pp.codProducto where fff.idclientes=? and pp.otrosProductos=1))"; 
            PreparedStatement st = this.getCn().prepareStatement(sql);
            st.setInt(1, id);
            st.setInt(2, id);
            st.setInt(3, id);
            rs = st.executeQuery(); 
            while (rs.next()) {
             datos=rs.getString("producto");
             datos=datos+"\nINICIO "+rs.getString("inicio");
             datos=datos+"\nFIN "+rs.getString("final");  
             datos=datos+"\n$"+rs.getString("total");                          
            }
        } catch (Exception e) {
            throw e;
        } finally {
            this.cerrar();
        }
        return datos;
    }
    //</editor-fold>
    
}
