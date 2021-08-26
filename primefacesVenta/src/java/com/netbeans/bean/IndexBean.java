/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netbeans.bean;

import com.netbeans.DAO.ClientesDAO;
import com.netbeans.DAO.IndexDAO;

import com.netbeans.model.Permisos;
import com.netbeans.model.Theme;
import com.netbeans.model.Usuario;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

/**
 *
 * @author Jymmy
 */
@ManagedBean
@ViewScoped
public class IndexBean implements Serializable {

    //------PERMISOS
    private List<Permisos> permisos = new ArrayList<>();

    private List<Integer> idClientes = new ArrayList<>();

    private Usuario usuario = new Usuario();
    private String usuarioNombre;
    private int idUsuario;
    //private List<Theme> themes;
    private String temas;

    //<editor-fold defaultstate="collapsed" desc="GET SET">   

    public String getTemas() {
        return temas;
    }

    public void setTemas(String temas) {
        this.temas = temas;
    }
    
    

    public List<Integer> getIdClientes() {
        return idClientes;
    }

    public void setIdClientes(List<Integer> idClientes) {
        this.idClientes = idClientes;
    }
    
    public String getUsuarioNombre() {
        return usuarioNombre;
    }

    public void setUsuarioNombre(String usuarioNombre) {
        this.usuarioNombre = usuarioNombre;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public List<Permisos> getPermisos() {
        return permisos;
    }

    public void setPermisos(List<Permisos> permisos) {
        this.permisos = permisos;
    }
    //</editor-fold>

    @PostConstruct
    public void init() {
        
        try {
         IndexDAO cd = new IndexDAO();
                temas=cd.temas();    
        } catch (Exception e) {
            temas="bootstrap";
        }
         
    }
    
    public IndexBean() {
    }

    public String iniciarSession() {
        Usuario us;
        IndexDAO index;
        permisos = new ArrayList<>();
        String redireccion = null;
        limpiarListas();
        try {
            index = new IndexDAO();
            us = index.iniciarSesion(usuario);
            //Almacenar en la session
            FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put("usuario", us);
            //Recupera permisos para el rol           
            if (us != null) {
                setUsuarioNombre(us.getUsuario() + ": " + us.getNombre());
                setIdUsuario(us.getIdUsuario());
                permisos = index.permisos(us.getRol());
                for (int i = 0; i < permisos.size(); i++) {
                    /* System.out.println("====PERMISOS "+permisos.get(0).getModulos()+"-"+permisos.get(0).getDescripcion()+" - "+permisos.get(0).getValor());                
                   System.out.println("====PERMISOS "+permisos.get(1).getModulos()+"-"+permisos.get(1).getDescripcion()+" - "+permisos.get(1).getValor());                
                   System.out.println("====PERMISOS "+permisos.get(2).getModulos()+"-"+permisos.get(2).getDescripcion()+" - "+permisos.get(2).getValor());                
                   System.out.println("====PERMISOS "+permisos.get(3).getModulos()+"-"+permisos.get(3).getDescripcion()+" - "+permisos.get(3).getValor());                
                   System.out.println("====PERMISOS "+permisos.get(4).getModulos()+"-"+permisos.get(4).getDescripcion()+" - "+permisos.get(4).getValor());  
                     */
                    //System.out.println("====PERMISOS " + permisos.get(i).getDescripcion() + "   MODULO " + permisos.get(i).getModulos() + " POSICION " + i + " VALOR " + permisos.get(i).getValor());
                }
                FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put("permisos", permisos);
                /* //Ruta no implicita //redireccion="/protegido/principal";*/ /*ruta explicita*/
                seguimientoClientes();
                redireccion = "/paginas/informacion?faces-redirect=true";
            } else {
                FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "Info", "Usuario no encontrado"));
            }
        } catch (Exception e) {
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN, "Aviso", "Error de conexion"));
        }
        return redireccion;
    }

    public void verificarSesion() {
        FacesContext context = FacesContext.getCurrentInstance();
        try {
            Usuario us = (Usuario) context.getExternalContext().getSessionMap().get("usuario");
            if (us == null) {
                context.getExternalContext().redirect("../../faces/index.xhtml");
            }
        } catch (Exception e) {
            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN, "Aviso", "Error verificando sesion"));
        }
    }

    /*  
   ====PERMISOS 0-crear - 1
   ====PERMISOS 1-editar - 1
   ====PERMISOS 2-eliminar - 1
   ====PERMISOS 3-ver - 1
   ====PERMISOS 4-generar - 1  
    
    --- MODULO 1 clientes
     */
    public boolean verificarPermisos(int id, int posicion, int valor) {
        //List<Permisos> permisos
        List<Permisos> permisos2 = new ArrayList<>();
        boolean temp = false;
        FacesContext context = FacesContext.getCurrentInstance();
        try {
            permisos2 = (List<Permisos>) context.getExternalContext().getSessionMap().get("permisos");
            //System.out.println("====PERMISOS "+permisos2.get(0).getModulos()+"-"+permisos2.get(0).getDescripcion()+" - "+permisos2.get(0).getValor());                
            //System.out.println("====PERMISOS "+permisos2.get(1).getModulos()+"-"+permisos2.get(1).getDescripcion()+" - "+permisos2.get(1).getValor());                
            if (permisos2 == null) {
                temp = false;
                //context.getExternalContext().redirect("../../faces/index.xhtml");
            } else {
                for (int i = 0; i < permisos2.size(); i++) {
                    //System.out.println(permisos2.get(i).getModulos()+" "+i+" "+permisos2.get(i).getDescripcion()+" "+permisos2.get(i).getValor());
                    if (permisos2.get(i).getModulos() == id && i == posicion && permisos2.get(i).getValor() == valor) {
                        temp = true;
                        break;
                    }
                }

            }

        } catch (Exception e) {
            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN, "Aviso", "Error verificando sesion"));
        }

        return temp;
    }

    //<editor-fold defaultstate="collapsed" desc="comment">
    /* public List<Permisos> verificarPermisos(int id) {
        //List<Permisos> permisos
        List<Permisos> permisos2 = new ArrayList<>();
        List<Permisos> temp = new ArrayList<>();
        FacesContext context = FacesContext.getCurrentInstance();
        try {
            permisos2 = (List<Permisos>) context.getExternalContext().getSessionMap().get("permisos");
            //System.out.println("====PERMISOS "+permisos2.get(0).getModulos()+"-"+permisos2.get(0).getDescripcion()+" - "+permisos2.get(0).getValor());                
            //System.out.println("====PERMISOS "+permisos2.get(1).getModulos()+"-"+permisos2.get(1).getDescripcion()+" - "+permisos2.get(1).getValor());                

            if (permisos2 == null) {
                context.getExternalContext().redirect("../../faces/index.xhtml");
            } else {
                for (int i = 0; i < permisos2.size(); i++) {
                    if (permisos2.get(i).getModulos() == id) {
                        Permisos permisos1 = new Permisos();
                        permisos1.setDescripcion((permisos2.get(i).getDescripcion()));
                        permisos1.setIdpermisos((permisos2.get(i).getIdpermisos()));
                        permisos1.setModulos((permisos2.get(i).getModulos()));
                        permisos1.setValor((permisos2.get(i).getValor()));
                        temp.add(permisos1);
                    } else {
                        Permisos permisos1 = new Permisos();
                        permisos1.setDescripcion("Sin permisos");
                        permisos1.setIdpermisos(0);
                        permisos1.setModulos(0);
                        permisos1.setValor(0);
                        temp.add(permisos1);
                    }

                }

            }

        } catch (Exception e) {
            context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_WARN, "Aviso", "Error verificando sesion"));
        }

        return temp;
    }*/
//</editor-fold>
    public int idUsuarios() {
        Usuario us = (Usuario) FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("usuario");
        //return us.getUsuario();
        //usuarioNombre = (us.getUsuario() + "; " + us.getNombre());
        return us.getIdUsuario();
    }

    public String nombreUsuario() {
        Usuario us = (Usuario) FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("usuario");
        //return us.getUsuario();
        usuarioNombre = (us.getUsuario() + "; " + us.getNombre());
        return usuarioNombre;
    }

    public int idUsuario() {
        Usuario us = (Usuario) FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("usuario");
        idUsuario = us.getIdUsuario();
        return idUsuario;
    }

    public void cerrarSesion() {
        FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
    }

    public void limpiarListas() {
        permisos = new ArrayList<>();
        //HerramientasUtil.clientesListaUTIL = clientesLista;
        //HerramientasUtil.permisosUTIL =permisosUsuario;
    }

    public boolean validaPermisos(int modulo, String descripcion) {
        boolean respuesta = false;
        for (int i = 0; i < permisos.size(); i++) {
            if (permisos.get(i).getDescripcion().trim().equals(descripcion)) {
                if (permisos.get(i).getValor() == modulo) {
                    respuesta = true;
                    i = permisos.size();
                }
            }
        }
        return respuesta;
    }

    public void seguimientoClientes() {
        ClientesDAO cd = new ClientesDAO();
        try {
            if (cd.consultarSeguimiento() > 0) {
                idClientes = cd.listarClientesActivosId();
                for (int i = 0; i < idClientes.size(); i++) {
                    if (cd.revisarClientesMora(idClientes.get(i))>0) {
                        cd.updateClienteMora(0, idClientes.get(i));
                    }else
                    {
                        cd.updateClienteMora(1, idClientes.get(i));
                    }
                }
                cd.insertSeguimiento();
            }
        } catch (Exception e) {
            System.out.println("===ERROR seguimientoClientes "+e);
        }

    }

}
