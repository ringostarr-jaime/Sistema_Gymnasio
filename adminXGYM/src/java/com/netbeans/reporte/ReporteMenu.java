/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.netbeans.reporte;

import static com.netbeans.DAO.DAO.jdbc;
import static com.netbeans.DAO.DAO.pass;
import static com.netbeans.DAO.DAO.user;
import com.netbeans.model.ListaParametros;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.faces.context.FacesContext;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;

import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;

/**
 *
 * @author Jymmy
 */
public class ReporteMenu {

    Connection conexion;

    public void getReporte(String ruta, List<ListaParametros> parametros, boolean parametro) throws ClassNotFoundException, ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException, FileNotFoundException, IOException {
        
        conexion = DriverManager.getConnection(jdbc, user, pass);

        //Se definen los parametros que el reporte necesita
        /*Map parameter = new HashMap();
        parameter.put("codCliente", codC);
        parameter.put("codVendedor", codV);
        parameter.put("codFactura", codF);*/
        try {
            File file = new File(ruta);

            HttpServletResponse httpServletResponse = (HttpServletResponse) FacesContext.getCurrentInstance().getExternalContext().getResponse();
            ServletOutputStream out = httpServletResponse.getOutputStream();

            httpServletResponse.setContentType("application/pdf");
            httpServletResponse.addHeader("Content-Type", "application/pdf");

            /*FacesContext facesContext = FacesContext.getCurrentInstance();
            ServletContext servletContext = (ServletContext) facesContext.getExternalContext().getContext();
            String ruta2 = servletContext.getRealPath("/WEB-INF/");*/
            //ServletContext servletContext = null;
            Map parameter = new HashMap();
            if (parametro) {
                for (int i = 0; i < parametros.size(); i++) {
                    parameter.put(parametros.get(i).getKey(), "" + parametros.get(i).getContenido());
                }
            }
            //   parameter.put("CONTEXT", ruta2);

            JasperReport jasperReport = (JasperReport) JRLoader.loadObjectFromFile(file.getPath());
            //JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, conexion);
            JasperPrint jasperPrint = null;
            if (parametro) {
                jasperPrint = JasperFillManager.fillReport(jasperReport, parameter, conexion);
            } else {
                jasperPrint = JasperFillManager.fillReport(jasperReport, null, conexion);
            }

            //JRExporter jrExporter = null;
            JRExporter jrExporter = new JRPdfExporter();
            jrExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
            //jrExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, httpServletResponse.getOutputStream());
            jrExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, out);

            // jrExporter.exportReport();
            if (jrExporter != null) {
                try {
                    jrExporter.exportReport();
                } catch (JRException e) {
                    e.printStackTrace();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conexion != null) {
                try {
                    conexion.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
