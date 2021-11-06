/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netbeans.DAO;

import com.netbeans.model.Permisos;
import com.netbeans.model.Theme;
import com.netbeans.model.Usuario;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jymmy
 */
public class IndexDAO extends DAO {

    public Usuario iniciarSesion(Usuario us) throws Exception {
        Usuario usuario = null;
        ResultSet rs;
        try {
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("select * from usuarios where usuario=? and clave=? and estado=1");
            st.setString(1, us.getUsuario().trim());
            st.setString(2, us.getClave().trim());
            /*st.setString(1, "admin");
            st.setString(2, "@admin");*/
            rs = st.executeQuery();
            while (rs.next()) {
                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idusuarios"));
                usuario.setUsuario(rs.getString("usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setClave(rs.getString("clave"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setRol(rs.getInt("rol"));
            }
        } catch (Exception e) {
            throw e;

        } finally {
            this.cerrar();
        }
        return usuario;
    }

    public List<Permisos> permisos(int rol) throws Exception {
        List<Permisos> listarPermisos;
        ResultSet rs;
        try {
            listarPermisos = new ArrayList<>();
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("SELECT p.idpermisos,p.valor,p.descripcion,p.id_modulos FROM ventas.rol_permiso r inner join ventas.permisos p on r.id_permiso =  p.idpermisos inner join ventas.modulos m on m.idmodulos = p.id_modulos where r.id_rol= ? and m.estado=1");
            st.setInt(1, rol);
            rs = st.executeQuery();
            while (rs.next()) {
                Permisos permisos = new Permisos();
                permisos.setIdpermisos(rs.getInt("idpermisos"));
                permisos.setDescripcion(rs.getString("descripcion"));
                permisos.setModulos(rs.getInt("id_modulos"));
                permisos.setValor(rs.getInt("valor"));
                listarPermisos.add(permisos);
            }
            //System.out.println("SIZE "+listarPermisos.size());
        } catch (Exception e) {
            throw e;

        } finally {
            this.cerrar();
        }
        return listarPermisos;
    }
    
       public String temas() throws Exception {
        String tmas = "";
        ResultSet rs;
        try {           
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("SELECT nombre from ventas.thema");            
            rs = st.executeQuery();
            while (rs.next()) {              
                tmas=(rs.getString("nombre"));   
            }
            //System.out.println("SIZE "+listarPermisos.size());
        } catch (Exception e) {            
            tmas="bootstrap";
        } finally {
            this.cerrar();
        }
        return tmas;
    }
}
