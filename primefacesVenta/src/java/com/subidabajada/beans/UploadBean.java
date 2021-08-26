package com.subidabajada.beans;

import com.netbeans.DAO.DAO;

import javax.faces.bean.SessionScoped;
import org.primefaces.model.UploadedFile;

import java.sql.PreparedStatement;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;

import javax.faces.context.FacesContext;

@ManagedBean
@SessionScoped
public class UploadBean extends DAO {

    private UploadedFile file;

    public UploadedFile getFile() {
        return file;
    }

    public void setFile(UploadedFile file) {
        this.file = file;
    }

    public void upload() {
        try {
            if (file != null) {
                //Class.forName("com.mysql.jdbc.Driver");
                //Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ventas","root","123");
                this.Conectar();

                PreparedStatement st = this.getCn().prepareStatement("Insert into imagen (img) value (?)");
                //PreparedStatement st = cn.prepareStatement("Insert into imagen (img) value (?)");
                st.setBinaryStream(1, file.getInputstream());

                st.executeUpdate();
                this.cerrar();

                FacesMessage message = new FacesMessage("Exito", file.getFileName() + " fue sudibo ");
                FacesContext.getCurrentInstance().addMessage(null, message);

            }
        } catch (Exception e) {
            FacesMessage message = new FacesMessage("Error de conexion");
            FacesContext.getCurrentInstance().addMessage(null, message);
        }

    }

}
