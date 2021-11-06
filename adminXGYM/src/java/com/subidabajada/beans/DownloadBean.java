package com.subidabajada.beans;

import com.netbeans.DAO.DAO;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import org.primefaces.model.StreamedContent;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletResponse;
import org.primefaces.model.DefaultStreamedContent;

/**
 *
 * @author Jymmy
 */
@ManagedBean
@SessionScoped
public class DownloadBean extends DAO {

    private StreamedContent file;
    private int codigo;

    public StreamedContent getFile() {
        return file;
    }

    public void setFile(StreamedContent file) {
        this.file = file;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public void download() {
        ResultSet rs;

        try {
            this.Conectar();

            PreparedStatement st = this.getCn().prepareStatement("select img from imagen where codigo =(?)");
            st.setInt(1, codigo);
            rs = st.executeQuery();

            while (rs.next()) {
                InputStream stream = rs.getBinaryStream("img");
                file = new DefaultStreamedContent(stream, "image/jpg", "descarga.jpg");

            }
            this.cerrar();

            FacesMessage message = new FacesMessage("Exito", "El archivo fue descargado");
            FacesContext.getCurrentInstance().addMessage(null, message);

        } catch (Exception e) {
            FacesMessage message = new FacesMessage("Error de conexion");
            FacesContext.getCurrentInstance().addMessage(null, message);
        }

    }

    public void ver() {
        ResultSet rs;
        try {
            byte[] bytes = null;

            this.Conectar();

            PreparedStatement st = this.getCn().prepareStatement("select img from imagen where codigo =(?)");
            st.setInt(1, codigo);
            rs = st.executeQuery();

            while (rs.next()) {
                bytes = rs.getBytes("img");

            }
            this.cerrar();

            FacesMessage message = new FacesMessage("Exito", "El archivo fue descargado");
            FacesContext.getCurrentInstance().addMessage(null, message);

            HttpServletResponse response = (HttpServletResponse) FacesContext.getCurrentInstance().getExternalContext().getResponse();
            response.getOutputStream().write(bytes);
            response.getOutputStream().close();

            FacesContext.getCurrentInstance().responseComplete();

        } catch (Exception e) {
            FacesMessage message = new FacesMessage("Error de conexion");
            FacesContext.getCurrentInstance().addMessage(null, message);
        }
    }

    public void ver2() {
        int n = 31;
        ResultSet rs;
        try {
            byte[] bytes = null;
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("select img from imagen where codigo =(?)");
            st.setInt(1, n);
            rs = st.executeQuery();
            while (rs.next()) {
                bytes = rs.getBytes("img");

            }
            this.cerrar();

            FacesMessage message = new FacesMessage("Exito", "El archivo fue descargado");
            FacesContext.getCurrentInstance().addMessage(null, message);

            HttpServletResponse response = (HttpServletResponse) FacesContext.getCurrentInstance().getExternalContext().getResponse();
            response.reset();

            response.getOutputStream().write(bytes);

            response.getOutputStream().close();

            FacesContext.getCurrentInstance().responseComplete();

        } catch (Exception e) {
            FacesMessage message = new FacesMessage("Error de conexion " + e);
            FacesContext.getCurrentInstance().addMessage(null, message);
        }
    }

    public StreamedContent getImage() throws IOException {
        int n = 30;
        ResultSet rs;
        byte[] bytes = null;
        try {

            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("select img from imagen where codigo =(?)");
            st.setInt(1, n);
            rs = st.executeQuery();
            while (rs.next()) {
                bytes = rs.getBytes("img");

            }
            this.cerrar();

        } catch (Exception e) {
            FacesMessage message = new FacesMessage("Error de conexion " + e);
            FacesContext.getCurrentInstance().addMessage(null, message);
        }
        return new DefaultStreamedContent(new ByteArrayInputStream(bytes), "image/png");

    }

}
