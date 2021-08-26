package com.netbeans.bean;

import com.netbeans.DAO.PersonaDAO;
import com.netbeans.model.Persona;
import java.io.Serializable;
import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

//Se debe usar la anotacion de ManagedBean para crear los beans
//aca iran todos los metodos de accion
@ManagedBean
@ViewScoped
public class PersonaBean implements Serializable {

    //Para manejar los postBack
    private boolean isPostBack() {
        boolean rpta;
        rpta = FacesContext.getCurrentInstance().isPostback();
        return rpta;
    }

    //Variable que controla la dinamicidad del boton nuevo o modificar
    private String accion;

    public String getAccion() {
        return accion;
    }

    public void setAccion(String accion) {
        this.limpiar();
        this.accion = accion;
    }

    private Persona persona = new Persona();
    private List<Persona> listPersonas;

    public List<Persona> getListPersonas() {
        return listPersonas;
    }

    public void setListPersonas(List<Persona> listPersonas) {
        this.listPersonas = listPersonas;
    }

    public Persona getPersona() {
        return persona;
    }

    public void setPersona(Persona persona) {
        this.persona = persona;
    }

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

    public void limpiar() {
        this.persona.setCodigo(0);
        this.persona.setNombre("");
        this.persona.setSexo("");
    }

    private void modificar() throws Exception {
        PersonaDAO dao;
        try {
            dao = new PersonaDAO();
            dao.modificar(persona);
            this.listar("v");
        } catch (Exception e) {
            throw e;
        }

    }

    private void registrar() throws Exception {
        PersonaDAO dao;
        try {
            dao = new PersonaDAO();
            dao.registrar(persona);
            this.listar("v");
        } catch (Exception e) {
            throw e;
        }

    }

    public void listar(String valor) {
        PersonaDAO dao;
        try {
            if (valor.equals("f")) {
                if (isPostBack() == false) {
                    dao = new PersonaDAO();
                    listPersonas = dao.listar();
                }
            } else {
                dao = new PersonaDAO();
                listPersonas = dao.listar();
            }
        } catch (Exception e) {
        }

    }

    public void leerID(Persona per) throws Exception {
        PersonaDAO dao;
        Persona temp;
        try {
            dao = new PersonaDAO();
            temp = dao.leerId(per);
            if (temp != null) {
                this.persona = temp;
                this.accion = "Modificar";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public void eliminar(Persona per) throws Exception {
        PersonaDAO dao;
        try {
            dao = new PersonaDAO();
            dao.eliminar(per);
            this.listar("v");
        } catch (Exception e) {
            throw e;
        }

    }

}
