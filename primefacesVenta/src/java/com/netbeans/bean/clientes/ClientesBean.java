/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netbeans.bean.clientes;

import com.netbeans.DAO.ClientesDAO;

import com.netbeans.model.Cliente;
import com.netbeans.model.contarTablas;
import com.util.HerramientasUtil;

import java.io.Serializable;

import java.util.ArrayList;
import java.util.Arrays;

import java.util.Calendar;

import java.util.List;
import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;

import javax.faces.context.FacesContext;
import org.primefaces.event.SelectEvent;

import javax.faces.bean.ViewScoped;

import org.primefaces.event.FileUploadEvent;
import org.primefaces.event.ToggleEvent;
import org.primefaces.model.UploadedFile;
import org.primefaces.model.Visibility;

/**
 *
 * @author Jymmy
 */
@ManagedBean
//@SessionScoped
@ViewScoped
//@Stateful
public class ClientesBean implements Serializable {

    //Para manejar los postBack
    private boolean isPostBack() {
        boolean rpta;
        rpta = FacesContext.getCurrentInstance().isPostback();
        return rpta;
    }

    private Cliente clientes = new Cliente();
    private int age;
    public int idImagen;
    private int visibleImagen = 1;
    private int botonNuevo = 1;
    private String texto = "Guardar";
    private List<Cliente> clientesLista;
    private contarTablas contar;
    private UploadedFile file;
    private String estado;
    private List<Boolean> list;

    //<editor-fold defaultstate="collapsed" desc="GETS&SET">

    public List<Boolean> getList() {
        return list;
    }

    public void setList(List<Boolean> list) {
        this.list = list;
    }
    
    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public UploadedFile getFile() {
        return file;
    }

    public void setFile(UploadedFile file) {
        this.file = file;
    }

    public contarTablas getContar() {
        return contar;
    }

    public void setContar(contarTablas contar) {
        this.contar = contar;
    }

    public List<Cliente> getClientesLista() {
        return clientesLista;
    }

    public void setClientesLista(List<Cliente> clientesLista) {
        this.clientesLista = clientesLista;
    }

    public int getBotonNuevo() {
        return botonNuevo;
    }

    public void setBotonNuevo(int botonNuevo) {
        this.botonNuevo = botonNuevo;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public int getVisibleImagen() {
        return visibleImagen;
    }

    public void setVisibleImagen(int visibleImagen) {
        this.visibleImagen = visibleImagen;
    }

    public int getIdImagen() {
        return idImagen;
    }

    public void setIdImagen(int idImagen) {
        this.idImagen = idImagen;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public Cliente getClientes() {
        return clientes;
    }

    public void setClientes(Cliente clientes) {
        this.clientes = clientes;
    }
    //</editor-fold>       
    
    @PostConstruct
    public void init()
    {
        list = Arrays.asList(true, false, true, true, false, true, true, true, true);
    }
    
     public void onToggle(ToggleEvent e) {
        list.set((Integer) e.getData(), e.getVisibility() == Visibility.VISIBLE);
    }

    public void onDateSelect(SelectEvent event) {
        //System.out.println("*****FECHA "+event.getObject());      
        try {
            age = edad(HerramientasUtil.dd_MM_yyyyy.format(event.getObject()));
        } catch (Exception e) {
        }
        //System.out.println("*****FECHA "+format.format(event.getObject()));        
    }

    public String estadoCliente(int estatus) {
        String valor = "Vigente";

        switch (estatus) {
            case 0:
                valor = "Mora";

                break;
            case 1:
                valor = "Vigente";
                break;
            case 2:
                valor = "Desactivado";
                break;

        }

        return valor;
    }

    //<editor-fold defaultstate="collapsed" desc="EDAD METOODO">    
    public int edad(String fecha) {
        //----FECHA ACTUAL FORMATEADA         
        Calendar rightNow = Calendar.getInstance();
        String fecha2 = HerramientasUtil.dd_MM_yyyyy.format(rightNow.getTime());
        //----FECHA ACTUAL FORMATEADA

        int edad = 0;
        try {
            //----------Calcular EDAD para fechas 28-06-2021
            if (Integer.parseInt(fecha2.substring(6, 10)) >= Integer.parseInt(fecha.substring(6, 10))) {
                if (Integer.parseInt(fecha2.substring(3, 5)) >= Integer.parseInt(fecha.substring(3, 5))) {
                    if (Integer.parseInt(fecha2.substring(0, 2)) >= Integer.parseInt(fecha.substring(0, 2))) {
                        //System.out.println("" + ((Integer.parseInt(fecha2.substring(6, 10)) - Integer.parseInt(fecha.substring(6, 10)))));
                        edad = (Integer.parseInt(fecha2.substring(6, 10)) - Integer.parseInt(fecha.substring(6, 10)) - 1);
                    } else {
                        //System.out.println("" + ((Integer.parseInt(fecha2.substring(6, 10)) - Integer.parseInt(fecha.substring(6, 10)))-1));
                        edad = ((Integer.parseInt(fecha2.substring(6, 10)) - Integer.parseInt(fecha.substring(6, 10))));
                    }
                } else {
                    //System.out.println("" + ((Integer.parseInt(fecha2.substring(6, 10)) - Integer.parseInt(fecha.substring(6, 10)))-1));
                    edad = ((Integer.parseInt(fecha2.substring(6, 10)) - Integer.parseInt(fecha.substring(6, 10))) - 1);
                }
            }
        } catch (Exception e) {
            System.out.println("Error en clientesBean edad1 " + e);
        }
        //System.out.println("====" + edad);
        return edad;
    }

    public int edadYYYYmmdd(String fecha) {
        int edad = 0;
        //----FECHA ACTUAL FORMATEADA         
        Calendar rightNow = Calendar.getInstance();
        String fecha2 = HerramientasUtil.yyyy_MM_dd.format(rightNow.getTime());
        //----FECHA ACTUAL FORMATEADA
        //System.out.println("====" + fecha);
        if (!fecha.trim().equals("")) {
            fecha2 = fecha2.trim();
            fecha = fecha.trim();
            try {
                //----------Calcular EDAD para fechas 28-06-2021
                if (Integer.parseInt(fecha2.substring(0, 4)) >= Integer.parseInt(fecha.substring(0, 4))) {
                    if (Integer.parseInt(fecha2.substring(5, 7)) >= Integer.parseInt(fecha.substring(5, 7))) {
                        if (Integer.parseInt(fecha2.substring(8, 10)) >= Integer.parseInt(fecha.substring(8, 10))) {
                            //System.out.println("" + ((Integer.parseInt(fecha2.substring(6, 10)) - Integer.parseInt(fecha.substring(6, 10)))));
                            edad = (Integer.parseInt(fecha2.substring(0, 4)) - Integer.parseInt(fecha.substring(0, 4)) - 1);
                        } else {
                            //System.out.println("" + ((Integer.parseInt(fecha2.substring(6, 10)) - Integer.parseInt(fecha.substring(6, 10)))-1));
                            edad = ((Integer.parseInt(fecha2.substring(0, 4)) - Integer.parseInt(fecha.substring(0, 4))));
                        }
                    } else {
                        //System.out.println("" + ((Integer.parseInt(fecha2.substring(6, 10)) - Integer.parseInt(fecha.substring(6, 10)))-1));
                        edad = ((Integer.parseInt(fecha2.substring(0, 4)) - Integer.parseInt(fecha.substring(0, 4))) - 1);
                    }
                }
            } catch (Exception e) {
                System.out.println("Error en clientesBean edad2 " + e);
            }
        }

        return edad;
    }
    //</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="SUBIR ARCHIVO BLOB">
    public void fileUploadListener(FileUploadEvent event) {
        event.getComponent().setTransient(false);
        if (event != null) {
            // Get uploaded file from the FileUploadEvent
            this.file = event.getFile();
            setFile(event.getFile());
            // Print out the information of the file
            //System.out.println("Uploaded File Name Is :: "+file.getFileName()+" :: Uploaded File Size :: "+file.getSize());
            // Add message
            FacesContext.getCurrentInstance().addMessage(null, new FacesMessage("La foto a sido cargada"));
        }

    }
//</editor-fold>    

    //<editor-fold defaultstate="collapsed" desc="GUARDAR/MODIFICAR CLIENTE">
    public void guardarCliente() {
        ClientesDAO cd;
        clientes.setEstado(Integer.parseInt(estado));

        switch (botonNuevo) {
            //---GUARDAR-----
            case 1:
                try {
                    cd = new ClientesDAO();
                    int idCliente = cd.guardarCliente(clientes, age);
                    if (idCliente > 0) {
                        estadosBoton(2);
                        idImagen = cd.upload(file, 1, idCliente, clientes.getNombre().trim() + "_" + clientes.getApellido().trim());
                        visibleImagen = idImagen;
                        file = null;
                    }

                } catch (Exception ex) {
                    FacesMessage message = new FacesMessage("Error de conexion");
                    FacesContext.getCurrentInstance().addMessage(null, message);
                }
                //nuevo();
                break;
            case 2:
                //---MODIFICAR-----
                try {

                    int idCliente = 0;
                    cd = new ClientesDAO();
                    idCliente = cd.modificarCliente(clientes);

                    if (idCliente > 0) {
                        if (clientes.getImagen() != 0) {
                            idImagen = cd.modificarUpload(file, 1, idCliente, clientes.getNombre().trim() + "_" + clientes.getApellido().trim(), clientes.getImagen());
                        } else {
                            idImagen = cd.upload(file, 1, idCliente, clientes.getNombre().trim() + "_" + clientes.getApellido().trim());
                        }

                        //estadosBoton(1);
                        visibleImagen = idImagen;
                        idImagen = clientes.getImagen();
                        file = null;

                    }

                } catch (Exception ex) {
                    FacesMessage message = new FacesMessage("Error de conexion");
                    FacesContext.getCurrentInstance().addMessage(null, message);
                }
                //nuevo();
                break;

        }

    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="LISTAR">
    public void listarClientes(int opcion) {

        ClientesDAO cd;
        try {
            clientesLista = new ArrayList<>();
            cd = new ClientesDAO();
            //---Revisamos si ya esta cargada la lista           
            clientesLista = cd.listarClientesAll(opcion);
            contar();

        } catch (Exception e) {
            System.out.println("Error en listarClientes " + e);
            FacesMessage message = new FacesMessage("Error al listar clientes " + e);
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
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="LIMPIAR NUEVO">
    public void nuevo() {
        //---------LIMPIEZA DE VARIABLES----------
        clientes.setApellido("");
        clientes.setNombre("");
        clientes.setCorreo("");
        clientes.setNota("");
        clientes.setTelefono("");
        clientes.setIdcliente(0);
        age = 0;
        visibleImagen = 0;
        clientesLista = new ArrayList<>();
        //---------LIMPIEZA DE VARIABLES----------
        botonNuevo = 1;
        texto = "Guardar";
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="ESTADOS">
    public void estadosBoton(int opcion) {
        switch (opcion) {
            case 1:
                /*   clientesLista = new ArrayList<>();
                //---------LIMPIEZA DE VARIABLES----------
                clientes.setApellido("");
                clientes.setNombre("");
                clientes.setCorreo("");
                clientes.setNota("");
                clientes.setTelefono("");
                clientes.setIdcliente(0);
                age = 0;
                visibleImagen = 0;
                HerramientasUtil.clientesListaUTIL = clientesLista;*/
                //---------LIMPIEZA DE VARIABLES----------
                botonNuevo = 1;
                texto = "Guardar";
                break;
            case 2:
                botonNuevo = 2;
                texto = "Modificar";
                // HerramientasUtil.clientesListaUTIL = clientesLista;
                break;
            default:
                clientesLista = new ArrayList<>();
                botonNuevo = 1;
                texto = "Guardar";
        }
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="CONTAR">
    public void contar() {
        int datos[] = {0, 1, 2};
        String tablas[] = {"clientes", "clientes", "clientes"};
        ClientesDAO c;
        try {
            c = new ClientesDAO();
            contar = c.contar(datos, tablas, 3);
        } catch (Exception e) {
            System.out.println("==ERROR contar " + e);
        }
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="SELECIONAR CLIENTE">
    public void leerDatosCliente(Cliente pro) throws Exception, Throwable {
        try {
            idImagen = pro.getImagen();
            estadosBoton(2);
            if (clientes.getIdcliente() != pro.getIdcliente()) {
                this.clientes = pro;
                if (pro.getImagen() > 0) {
                    visibleImagen = 0;
                }
                age = edadYYYYmmdd(pro.getFecha2());
                //listarClientes();
            }
        } catch (Exception e) {
            System.out.println("=== ERROR modificar " + e);
        }
    }
//</editor-fold>

    //<editor-fold defaultstate="collapsed" desc="BORRAR CLIENTE">    
    public void borrarDatosCliente(Cliente pro) throws Exception, Throwable {
        try {
            ClientesDAO cd;
            cd = new ClientesDAO();
            if (cd.eliminarCliente(pro) > 0) {
                clientes = new Cliente();
            }
        } catch (Exception e) {
            System.out.println("=== ERROR eliminar " + e);
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

    public void test() {
        System.out.println("" + estado);
    }

}
