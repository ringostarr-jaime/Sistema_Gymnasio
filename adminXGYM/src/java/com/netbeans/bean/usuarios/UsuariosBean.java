/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netbeans.bean.usuarios;

import com.netbeans.DAO.IndexDAO;
import com.netbeans.DAO.UsuarioDAO;
import com.netbeans.bean.IndexBean;
import com.netbeans.model.Modulos;
import com.netbeans.model.Rol;
import com.netbeans.model.Theme;

import com.netbeans.model.Usuario;

import java.io.Serializable;

import java.util.ArrayList;

import java.util.List;
import javax.annotation.PostConstruct;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;

import javax.faces.context.FacesContext;

import javax.faces.bean.ViewScoped;
import org.primefaces.model.DualListModel;

/**
 *
 * @author Jymmy
 */
@ManagedBean
//@SessionScoped
@ViewScoped
//@Stateful
public class UsuariosBean implements Serializable {

    //Para manejar los postBack
    private boolean isPostBack() {
        boolean rpta;
        rpta = FacesContext.getCurrentInstance().isPostback();
        return rpta;
    }

    private Usuario usuarios = new Usuario();
    private Modulos modula = new Modulos();
    private Rol roles = new Rol();
    private String accion;
    private List<Usuario> listarUsuarios = new ArrayList<>();
    private List<Rol> listarRoles = new ArrayList<>();
    private List<Rol> listarRolPermisos = new ArrayList<>();
    private List<Rol> listarRolPermisosBusquedaId = new ArrayList<>();
    private List<Modulos> listarModulos = new ArrayList<>();
    private List<Rol> listarRolPermisosTarget = new ArrayList<>();
    private DualListModel RolPermisos;
    private int id;
    private List<Theme> themes;
    private String nombreTema;

    //<editor-fold defaultstate="collapsed" desc="GETS&SET">
    public String getNombreTema() {
        return nombreTema;
    }

    public void setNombreTema(String nombreTema) {
        this.nombreTema = nombreTema;
    }

    public List<Theme> getThemes() {
        return themes;
    }

    public void setThemes(List<Theme> themes) {
        this.themes = themes;
    }

    public List<Rol> getListarRolPermisosBusquedaId() {
        return listarRolPermisosBusquedaId;
    }

    public void setListarRolPermisosBusquedaId(List<Rol> listarRolPermisosBusquedaId) {
        this.listarRolPermisosBusquedaId = listarRolPermisosBusquedaId;
    }

    public Modulos getModula() {
        return modula;
    }

    public void setModula(Modulos modula) {
        this.modula = modula;
    }

    public List<Modulos> getListarModulos() {
        return listarModulos;
    }

    public void setListarModulos(List<Modulos> listarModulos) {
        this.listarModulos = listarModulos;
    }

    public DualListModel getRolPermisos() {
        return RolPermisos;
    }

    public void setRolPermisos(DualListModel RolPermisos) {
        this.RolPermisos = RolPermisos;
    }

    public List<Rol> getListarRolPermisosTarget() {
        return listarRolPermisosTarget;
    }

    public void setListarRolPermisosTarget(List<Rol> listarRolPermisosTarget) {
        this.listarRolPermisosTarget = listarRolPermisosTarget;
    }

    public List<Rol> getListarRolPermisos() {
        return listarRolPermisos;
    }

    public void setListarRolPermisos(List<Rol> listarRolPermisos) {
        this.listarRolPermisos = listarRolPermisos;
    }

    public Rol getRoles() {
        return roles;
    }

    public void setRoles(Rol roles) {
        this.roles = roles;
    }

    public List<Rol> getListarRoles() {
        return listarRoles;
    }

    public void setListarRoles(List<Rol> listarRoles) {
        this.listarRoles = listarRoles;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Usuario> getListarUsuarios() {
        return listarUsuarios;
    }

    public void setListarUsuarios(List<Usuario> listarUsuarios) {
        this.listarUsuarios = listarUsuarios;
    }

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        this.limpiar(accion);
        this.accion = accion;
    }

    public Usuario getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(Usuario usuarios) {
        this.usuarios = usuarios;
    }

    //</editor-fold>
    @PostConstruct
    public void init() {

        if (themes == null || themes.size() == 0) {
            themes = new ArrayList<>();
            themes.add(new Theme(0, "afterdark", "afterdark"));
            themes.add(new Theme(1, "afternoon", "afternoon"));
            themes.add(new Theme(2, "afterwork", "afterwork"));
            themes.add(new Theme(3, "aristo", "aristo"));
            themes.add(new Theme(4, "bootstrap", "bootstrap"));
            themes.add(new Theme(5, "black-tie", "black-tie"));
            themes.add(new Theme(6, "blitzer", "blitzer"));
            themes.add(new Theme(7, "bluesky", "bluesky"));
            themes.add(new Theme(8, "casablanca", "casablanca"));
            themes.add(new Theme(9, "cupertino", "cupertino"));
            themes.add(new Theme(10, "cruze", "cruze"));
            themes.add(new Theme(11, "delta", "delta"));
            themes.add(new Theme(12, "dark-hive", "dark-hive"));
            themes.add(new Theme(13, "dot-luv", "dot-luv"));
            themes.add(new Theme(14, "eggplant", "eggplant"));
            themes.add(new Theme(15, "excite-bike", "excite-bike"));
            themes.add(new Theme(16, "flick", "flick"));
            themes.add(new Theme(17, "glass-x", "glass-x"));
            themes.add(new Theme(18, "home", "home"));
            themes.add(new Theme(19, "hot-sneaks", "hot-sneaks"));
            themes.add(new Theme(20, "humanity", "humanity"));
            themes.add(new Theme(21, "le-frog", "le-frog"));
            themes.add(new Theme(22, "midnight", "midnight"));
            themes.add(new Theme(23, "mint-choc", "mint-choc"));
            // themes.add(new Theme(17,"none", "none"));
            themes.add(new Theme(25, "overcast", "overcast"));
            themes.add(new Theme(26, "pepper-grinder", "pepper-grinder"));
            themes.add(new Theme(27, "redmond", "redmond"));
            themes.add(new Theme(28, "rocket", "rocket"));
            themes.add(new Theme(29, "sam", "sam"));
            themes.add(new Theme(30, "south-street", "south-street"));
            themes.add(new Theme(31, "start", "start"));
            themes.add(new Theme(32, "sunny", "sunny"));
            themes.add(new Theme(33, "swanky-purse", "swanky-purse"));
            themes.add(new Theme(34, "trontastic", "trontastic"));
            themes.add(new Theme(35, "ui-darkness", "ui-darkness"));
            themes.add(new Theme(36, "ui-lightness", "ui-lightness"));
            themes.add(new Theme(37, "vader", "vader"));           
        }

    }

    public void guardarTema() throws Exception //public void guardarTema( )  
    {
        try {
            if (!nombreTema.trim().equals("")) {
                UsuarioDAO ud = new UsuarioDAO();
                ud.modificarTema(nombreTema);
            }
        } catch (Exception e) {
            System.out.println("===guardarTema " + e);
        }

    }

    public String estadoCliente(int estado) {
        String valor = "Activo";

        switch (estado) {
            case 0:
                valor = "Desactivado";
                break;
            case 1:
                valor = "Activo";
                break;
        }

        return valor;
    }

    //<editor-fold defaultstate="collapsed" desc="GUARDAR">
    public void guardarUsuarios() {
        UsuarioDAO cd;
        try {
            cd = new UsuarioDAO();
            if (cd.registrar(usuarios) > 0) {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Exito", "los registros fueron ingresados"));
            }

        } catch (Exception ex) {
            FacesMessage message = new FacesMessage("Error de conexion");
            FacesContext.getCurrentInstance().addMessage(null, message);
        }

    }

//</editor-fold>
    //<editor-fold defaultstate="collapsed" desc="LISTAR">
//    public void listarClientes(int opcion) {
//
//        ClientesDAO cd;
//        try {
//            clientesLista = new ArrayList<>();
//            cd = new ClientesDAO();
//            //---Revisamos si ya esta cargada la lista           
//            clientesLista = cd.listarClientesAll(opcion);
//            contar();
//
//        } catch (Exception e) {
//            System.out.println("Error en listarClientes " + e);
//            FacesMessage message = new FacesMessage("Error al listar clientes " + e);
//        }
//
//    }
//
//    public void listarClientes2(int opcion, String valor) {
//        ClientesDAO cd;
//        try {
//            if (valor.equals("f")) {
//                if (isPostBack() == false) {
//                    cd = new ClientesDAO();
//                    clientesLista = cd.listarClientesAll(opcion);
//                }
//            } else {
//                cd = new ClientesDAO();
//                clientesLista = cd.listarClientesAll(opcion);
//            }
//        } catch (Exception e) {
//        }
//
//    }
//</editor-fold>
    //<editor-fold defaultstate="collapsed" desc="LIMPIAR NUEVO">
//    public void nuevo() {
//        //---------LIMPIEZA DE VARIABLES----------
//        clientes.setApellido("");
//        clientes.setNombre("");
//        clientes.setCorreo("");
//        clientes.setNota("");
//        clientes.setTelefono("");
//        clientes.setIdcliente(0);
//        age = 0;
//        visibleImagen = 0;
//        clientesLista = new ArrayList<>();
//        //---------LIMPIEZA DE VARIABLES----------
//        botonNuevo = 1;
//        texto = "Guardar";
//    }
//</editor-fold>
    public void registrarUsuarios() throws Exception {
        switch (accion) {
            case "Registrar":
                this.guardarUsuarios();
                this.limpiar(accion);
                listar("v");
                break;
            case "Modificar":
                this.modificar();
                this.limpiar(accion);
                listar("v");
                break;
        }
    }

    public void registrarRoles() throws Exception {
        switch (accion) {
            case "Registrar":
                this.guardarRol();
                this.limpiar(accion);
                listar("v");
                break;
            case "Modificar":
                this.insertarPermisosRol();
                this.limpiar(accion);
                listar("v");
                break;
        }
    }

    //<editor-fold defaultstate="collapsed" desc="SELECIONAR CLIENTE">
//    public void leerDatosCliente(Cliente pro) throws Exception, Throwable {
//        try {
//            idImagen = pro.getImagen();
//            estadosBoton(2);
//            if (clientes.getIdcliente() != pro.getIdcliente()) {
//                this.clientes = pro;
//                if (pro.getImagen() > 0) {
//                    visibleImagen = 0;
//                }
//                age = edadYYYYmmdd(pro.getFecha2());
//                //listarClientes();
//            }
//        } catch (Exception e) {
//            System.out.println("=== ERROR modificar " + e);
//        }
//    }
//</editor-fold>
    //<editor-fold defaultstate="collapsed" desc="BORRAR USUARIO">    
    public void eliminarUsuario(Usuario usu) throws Exception, Throwable {
        try {
            UsuarioDAO dao;
            dao = new UsuarioDAO();
            if (dao.eliminarUsuario(usu) > 0) {
                usuarios = new Usuario();
            }
        } catch (Exception e) {
            System.out.println("=== ERROR eliminar " + e);
        }
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="BORRAR ROL">    
    public void eliminarRol(Rol entiddadRol) throws Exception, Throwable {
        try {
            UsuarioDAO dao;
            dao = new UsuarioDAO();
            if (dao.eliminarRol(entiddadRol) > 0) {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Eliminado", "se elimino el registro"));
            }
        } catch (Exception e) {
            System.out.println("=== ERROR eliminar " + e);
        }
    }
    //</editor-fold>

    private void modificar() throws Exception {
        UsuarioDAO dao;
        try {
            dao = new UsuarioDAO();
            dao.modificar(usuarios);
            this.listar("v");
        } catch (Exception e) {
            throw e;
        }

    }

    private void insertarPermisosRol() throws Exception {
        UsuarioDAO dao;
        try {
            dao = new UsuarioDAO();
            dao.modificarRol(roles);
            if (dao.modificarInsertarRolPermisos(RolPermisos.getTarget(), RolPermisos.getSource(), roles.getIdrol()) > 0) {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Exito", "los registros fueron ingresados"));
            }
            this.listar("v");
            this.listarRolPermiso("v", 0, 0);
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Error", "" + e));
        }

    }

    public void limpiar(String accion) {
        if (accion.trim().equals("Registrar")) {
            roles = new Rol();
        }
        usuarios = new Usuario();
        //listarRolPermisos = new ArrayList<>();
        //listarModulos = new ArrayList<>();
        //listarRolPermisos2 = new ArrayList<>();
        //RolPermisos = new DualListModel();
    }

    public void listar(String valor) {
        UsuarioDAO dao;
        try {
            if (valor.equals("f")) {
                if (isPostBack() == false) {
                    dao = new UsuarioDAO();
                    listarUsuarios = dao.listar();
                }
            } else {
                dao = new UsuarioDAO();
                listarUsuarios = dao.listar();
            }
        } catch (Exception e) {
        }

    }

    public void listarRol(String valor, int id) {
        UsuarioDAO dao;
        try {
            if (valor.equals("f")) {
                if (isPostBack() == false) {
                    dao = new UsuarioDAO();
                    listarRoles = dao.listarRol(id);
                }
            } else {
                dao = new UsuarioDAO();
                listarRoles = dao.listarRol(id);
            }
        } catch (Exception e) {
        }

    }

    public void listarRolPermiso(String valor, int id, int idRol) {
        UsuarioDAO dao;
        try {
            if (valor.equals("f")) {
                if (isPostBack() == false) {
                    dao = new UsuarioDAO();
                    listarRolPermisos = dao.listarRolPermisos(id, idRol);
                    RolPermisos = new DualListModel<>(listarRolPermisos, listarRolPermisosTarget);
                    listarModulos = dao.listarModulos(modula);

                }
            } else {
                dao = new UsuarioDAO();

                listarRolPermisosBusquedaId = dao.listarRolPermisos(id, idRol);
                listarRolPermisos = dao.listarRolPermisos(id, 0);
                if (listarRolPermisosBusquedaId.size() > 0) {

                    for (int j = 0; j < listarRolPermisosBusquedaId.size(); j++) {
                        for (int i = 0; i < listarRolPermisos.size(); i++) {
                            if (listarRolPermisos.get(i).getIdPermisos() == listarRolPermisosBusquedaId.get(j).getIdPermisos()) {
                                listarRolPermisos.remove((Rol) listarRolPermisos.get(i));
                            }
                        }
                    }
                    RolPermisos = new DualListModel<>(listarRolPermisos, listarRolPermisosBusquedaId);
                } else {
                    RolPermisos = new DualListModel<>(listarRolPermisos, listarRolPermisosTarget);
                }

                listarModulos = dao.listarModulos(modula);
                listarRol("v", 0);

            }
        } catch (Exception e) {
            System.out.println("===listarRolPermiso " + e);
        }

    }

    public void leerID(Usuario us) throws Exception {
        UsuarioDAO dao;
        try {
            dao = new UsuarioDAO();
            this.usuarios = dao.leerId(us);
        } catch (Exception e) {
            throw e;
        }
    }

    public void leerRol(Rol rol) throws Exception {
        UsuarioDAO dao;
        try {
            dao = new UsuarioDAO();
            this.roles = dao.leerRol(rol);
            listarRolPermiso("v", (rol.getIdmodulos() == 0 ? 1 : rol.getIdmodulos()), rol.getIdrol());

        } catch (Exception e) {
            throw e;
        }
    }

    public void idUsuario() {
        IndexBean index = new IndexBean();
        id = index.getIdUsuario();
    }

    //<editor-fold defaultstate="collapsed" desc="GUARDAR-ROL">
    public void guardarRol() {
        UsuarioDAO cd;
        try {
            cd = new UsuarioDAO();
            if (cd.registrarRol(roles) > 0) {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, "Exito", "los registros fueron ingresados"));
            }

        } catch (Exception ex) {
            FacesMessage message = new FacesMessage("Error de conexion");
            FacesContext.getCurrentInstance().addMessage(null, message);
        }

    }
    //</editor-fold>

}
