package com.netbeans.DAO;

import com.netbeans.model.Modulos;
import com.netbeans.model.Persona;
import com.netbeans.model.Rol;
import com.netbeans.model.Usuario;
import com.netbeans.model.rol_permiso;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;

//Aca van las consultas a la base de datos y extiendo de DAO que es la conexion a la abse de datos
public class UsuarioDAO extends DAO {

    public int registrar(Usuario usuarios) throws SQLException, Exception {
        int valor = 0;
        String sql1 = "insert into ventas.usuarios (nombre,usuario,clave,correo,telefono,estado,rol) values(?,?,?,?,?,?,?)";
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement(sql1);
            st.setString(1, usuarios.getNombre());
            st.setString(2, usuarios.getUsuario());
            st.setString(3, usuarios.getClave());
            st.setString(4, usuarios.getCorreo());
            st.setString(5, usuarios.getTelefono());
            st.setInt(6, usuarios.getEstado());
            st.setInt(7, usuarios.getRol());
            valor = st.executeUpdate();
            st.close();
            this.getCn().commit();

        } catch (Exception e) {
            valor = 0;
            this.getCn().rollback();
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error de grabacion ", "" + e));
        } finally {
            this.cerrar();
        }
        return valor;
    }

    public List<Usuario> listar() throws Exception {
        List<Usuario> lista;
        ResultSet rs;
        try {
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("Select * from ventas.usuarios u inner join ventas.rol r on u.rol= r.idrol");
            rs = st.executeQuery();
            lista = new ArrayList();
            while (rs.next()) {
                Usuario usu = new Usuario();
                usu.setClave(rs.getString("clave"));
                usu.setCorreo(rs.getString("correo"));
                usu.setEstado(rs.getInt("estado"));
                usu.setIdUsuario(rs.getInt("idusuarios"));
                usu.setNombre(rs.getString("nombre"));
                usu.setRol(rs.getInt("rol"));
                usu.setTelefono(rs.getString("telefono"));
                usu.setUsuario(rs.getString("usuario"));
                usu.setRolNombre(rs.getString("r.nombre"));
                lista.add(usu);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            this.cerrar();
        }
        return lista;
    }

    public List<Rol> listarRol(int id) throws Exception {
        List<Rol> lista;
        String sql = "SELECT r.idrol,r.nombre,r.descripcion,r.estado FROM ventas.rol r  ";
        ResultSet rs;
        try {
            if (id != 0) {
                sql = sql.concat(" where r.idrol=? ");
            }
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement(sql);
            rs = st.executeQuery();
            lista = new ArrayList();
            while (rs.next()) {
                Rol r = new Rol();
                r.setIdrol(rs.getInt("r.idrol"));
                r.setNombre(rs.getString("r.nombre"));
                r.setDescripcion(rs.getString("r.descripcion"));
                r.setEstado(rs.getInt("r.estado"));
                /*r.setPdescripcion(rs.getString("p.descripcion"));
            r.setMdescripcion(rs.getString("m.descripcion"));
            r.setIdPermisos(rs.getInt("p.idpermisos"));*/
                lista.add(r);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            this.cerrar();
        }
        return lista;
    }

    public List<Rol> listarRolPermisos(int id, int idRol) throws Exception {
        //---ya que el admin tiene todos los permisos tomamos en base al 1
        idRol = (idRol == 0 ? 1 : idRol);
        List<Rol> lista = null;
        String sql = "SELECT r.idrol,r.nombre,r.descripcion,r.estado ,p.descripcion,m.descripcion,p.idpermisos FROM ventas.rol r inner join ventas.rol_permiso rp on r.idrol=rp.id_rol inner join ventas.permisos p on p.idpermisos =rp.id_permiso inner join ventas.modulos m on m.idmodulos=p.id_modulos ";
        ResultSet rs;
        try {
            if (id != 0 && idRol != 0) {
                sql = sql.concat(" where p.id_modulos=? and r.idrol=?");
            }
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement(sql);
            if (id != 0 && idRol != 0) {
                st.setInt(1, id);
                st.setInt(2, idRol);
            }
            rs = st.executeQuery();
            lista = new ArrayList();
            while (rs.next()) {
                Rol r = new Rol();
                r.setIdrol(rs.getInt("r.idrol"));
                r.setNombre(rs.getString("r.nombre"));
                r.setDescripcion(rs.getString("r.descripcion"));
                r.setEstado(rs.getInt("r.estado"));
                r.setPdescripcion(rs.getString("p.descripcion"));
                r.setMdescripcion(rs.getString("m.descripcion"));
                r.setIdPermisos(rs.getInt("p.idpermisos"));
                lista.add(r);
            }
        } catch (Exception e) {
            System.out.println("====listarRolPermisos " + e);
        } finally {
            this.cerrar();
        }
        return lista;
    }

    public Usuario leerId(Usuario us) throws Exception {
        Usuario usu = null;
        ResultSet rs;
        try {
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("Select * from ventas.usuarios u inner join ventas.rol r on u.rol= r.idrol where idusuarios=?");
            st.setInt(1, us.getIdUsuario());
            rs = st.executeQuery();
            while (rs.next()) {
                usu = new Usuario();
                usu.setClave(rs.getString("clave"));
                usu.setCorreo(rs.getString("correo"));
                usu.setEstado(rs.getInt("estado"));
                usu.setIdUsuario(rs.getInt("idusuarios"));
                usu.setNombre(rs.getString("nombre"));
                usu.setRol(rs.getInt("rol"));
                usu.setTelefono(rs.getString("telefono"));
                usu.setUsuario(rs.getString("usuario"));
            }
        } catch (Exception e) {
            throw e;

        } finally {
            this.cerrar();
        }
        return usu;
    }

    public Rol leerRol(Rol rol) throws Exception {
        Rol roles = null;
        ResultSet rs;
        try {
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("Select * from ventas.rol where idrol=?");
            st.setInt(1, rol.getIdrol());
            rs = st.executeQuery();
            while (rs.next()) {
                roles = new Rol();
                roles.setNombre(rs.getString("nombre"));
                roles.setDescripcion(rs.getString("descripcion"));
                roles.setEstado(rs.getInt("estado"));
                roles.setIdrol(rs.getInt("idrol"));

            }
        } catch (Exception e) {
            throw e;

        } finally {
            this.cerrar();
        }
        return roles;
    }

    public void modificar(Usuario usuarios) throws SQLException, Exception {
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement("update ventas.usuarios set nombre=?, usuario=?, clave=?,correo=?,telefono=?,estado=?,rol=? where idusuarios=?");
            st.setString(1, usuarios.getNombre());
            st.setString(2, usuarios.getUsuario());
            st.setString(3, usuarios.getClave());
            st.setString(4, usuarios.getCorreo());
            st.setString(5, usuarios.getTelefono());
            st.setInt(6, usuarios.getEstado());
            st.setInt(7, usuarios.getRol());
            st.setInt(8, usuarios.getIdUsuario());
            st.executeUpdate();
            st.close();
            this.getCn().commit();
        } catch (Exception e) {
            this.getCn().rollback();
            throw e;
        } finally {
            this.cerrar();
        }
    }

    public int eliminarUsuario(Usuario usu) throws SQLException, Exception {
        int respuesta = 0;
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement("delete from usuarios where idusuarios=?");
            st.setInt(1, usu.getIdUsuario());
            respuesta = st.executeUpdate();
            st.close();
            this.getCn().commit();
        } catch (Exception e) {
            respuesta = 0;
            this.getCn().rollback();
            throw e;
        } finally {
            this.cerrar();
        }
        return respuesta;
    }
    
    public int eliminarRol(Rol entidadRol) throws SQLException, Exception {
        int respuesta = 0;
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement("delete from ventas.rol where idrol=?");
            st.setInt(1, entidadRol.getIdrol());
            respuesta = st.executeUpdate();
            st.close();
            this.getCn().commit();
        } catch (Exception e) {
            respuesta = 0;
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error al eliminar ", "" + e));
            this.getCn().rollback();           
        } finally {
            this.cerrar();
        }
        return respuesta;
    }

    public List<Modulos> listarModulos(Modulos modula) throws Exception {
        Modulos modulo;
        List<Modulos> listModulo = new ArrayList();
        ResultSet rs;
        String sql = "Select * from ventas.modulos ";
        try {

            if (modula.getIdmodulos() != 0) {
                sql = sql.concat(" where idmodulos=?");
            }
            this.Conectar();
            //System.out.println("===listarModulos "+sql);  
            PreparedStatement st = this.getCn().prepareStatement(sql);
            if (modula.getIdmodulos() != 0) {
                st.setInt(1, modula.getIdmodulos());
            }
            rs = st.executeQuery();
            while (rs.next()) {
                modulo = new Modulos();
                modulo.setDescripcion(rs.getString("descripcion"));
                modulo.setEstado(rs.getInt("estado"));
                modulo.setIdmodulos(rs.getInt("idmodulos"));
                listModulo.add(modulo);
            }
        } catch (Exception e) {
            System.out.println("===listarModulos " + e);
        } finally {
            this.cerrar();
        }
        return listModulo;
    }

    public int registrarRol(Rol roles) throws SQLException, Exception {
        int valor = 0;
        String sql1 = "insert into ventas.rol (nombre,descripcion,estado) values(?,?,?)";
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement(sql1/*, PreparedStatement.RETURN_GENERATED_KEYS*/);
            st.setString(1, roles.getNombre());
            st.setString(2, roles.getDescripcion());
            st.setInt(3, roles.getEstado());
            valor = st.executeUpdate();
            /*  ResultSet rs = st.getGeneratedKeys();
            if (rs != null && rs.next()) {
                    valor = rs.getInt(1);
             } */
            st.close();
            this.getCn().commit();

        } catch (Exception e) {
            valor = 0;
            this.getCn().rollback();
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error de grabacion ", "" + e));
        } finally {
            this.cerrar();
        }
        return valor;
    }

    public int modificarRol(Rol roles) throws SQLException, Exception {
        int valor = 0;
        String sql1 = "update ventas.rol set nombre=?,  descripcion=?,estado=? where idrol=?";
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement(sql1);
            st.setString(1, roles.getNombre());
            st.setString(2, roles.getDescripcion());
            st.setInt(3, roles.getEstado());
            st.setInt(4, roles.getIdrol());
            valor = st.executeUpdate();
            st.close();
            this.getCn().commit();

        } catch (Exception e) {
            valor = 0;
            this.getCn().rollback();
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error de grabacion ", "" + e));
        } finally {
            this.cerrar();
        }
        return valor;
    }

    public int modificarInsertarRolPermisos(List<String> target,List<String> source, int idRol) throws SQLException, Exception {
        int continuar;
        int contador=0;
      
         for (int i = 0; i < source.size(); i++) {
            continuar = listarPermisosRol((Integer.parseInt((source.get(i).toString()))), idRol);
            if (continuar>0) {
                contador=contador+modificarPermisoRol( idRol,(Integer.parseInt((source.get(i).toString()))),continuar);                
            } 
        }
        
        for (int i = 0; i < target.size(); i++) {
            continuar = listarPermisosRol((Integer.parseInt((target.get(i).toString()))), idRol);
            if (continuar>0) {
                contador=contador+modificarPermisoRol( idRol,(Integer.parseInt((target.get(i).toString()))),continuar);                
            } 
        }
        
        for (int i = 0; i < target.size(); i++) { 
            contador=contador+registrarPermisoRol( idRol,(Integer.parseInt((target.get(i).toString()))));
        }
        
        return contador;

    }

    public int registrarPermisoRol(int idRol, int idPermiso) throws SQLException, Exception {

        int valor = 0;
        String sql1 = "insert into ventas.rol_permiso (id_rol,id_permiso) values(?,?)";
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement(sql1);
            st.setInt(1, idRol);
            st.setInt(2, idPermiso);
            valor = valor + st.executeUpdate();
            st.close();
            this.getCn().commit();

        } catch (Exception e) {
            System.out.println("===registrarPermisoRol " + e);
            valor = 0;
            this.getCn().rollback();
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error de grabacion ", "" + e));
        } finally {
            this.cerrar();
        }
        return valor;
    }

    public int listarPermisosRol(int idRol, int idRolPermiso) throws Exception {
        List<rol_permiso> listPermisos = new ArrayList();
        ResultSet rs;
        String sql = "SELECT * FROM ventas.rol_permiso where id_rol=?  and id_permiso=? ";
        rol_permiso permisos;        
        int existe=0;
        try {

            this.Conectar();
            //System.out.println("===listarModulos "+sql);  
            PreparedStatement st = this.getCn().prepareStatement(sql);
            st.setInt(1, idRolPermiso);
            st.setInt(2, idRol);
            rs = st.executeQuery();

            while (rs.next()) {
                permisos = new rol_permiso();
                permisos.setIdrol_permiso(rs.getInt("idrol_permiso"));
                permisos.setIdrol(rs.getInt("id_rol"));
                permisos.setIdpermiso(rs.getInt("id_permiso"));
                listPermisos.add(permisos);
            }

            if (listPermisos.size() > 0) {
                existe = listPermisos.get(0).getIdrol_permiso();
            }

            this.cerrar();

        } catch (Exception e) {
            System.out.println("===listarPermisosRol " + e);
        } finally {
            this.cerrar();
        }
        return existe;
    }

    public int modificarPermisoRol(int idRol, int idPermiso, int idrol_permiso) throws SQLException, Exception {
        int valor = 0;
        
        String sql1 = "delete from ventas.rol_permiso where id_rol=? and id_permiso=? and idrol_permiso=? ";
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement(sql1);
            st.setInt(1, idRol);
            st.setInt(2, idPermiso);
            st.setInt(3, idrol_permiso);
            valor = st.executeUpdate();

            st.close();
            this.getCn().commit();
        } catch (Exception e) {
            System.out.println("===registrarPermisoRol " + e);
            valor = 0;
            this.getCn().rollback();
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error de grabacion ", "" + e));
        } finally {
            this.cerrar();
        }
        return valor;
    }
    
    
    public void modificarTema(String nombre) throws SQLException, Exception {
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);
            PreparedStatement st = this.getCn().prepareStatement("UPDATE ventas.thema SET nombre = ? WHERE idthema=1");
            st.setString(1, nombre);           
            st.executeUpdate();
            st.close();
            this.getCn().commit();
        } catch (Exception e) {
            this.getCn().rollback();
            throw e;
        } finally {
            this.cerrar();
        }
    }
}
