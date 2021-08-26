/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.util;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.Calendar;

import java.util.Locale;

/**
 *
 * @author Jymmy
 */
public class HerramientasUtil {

    public static SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
    public static SimpleDateFormat ddMMyyyy = new SimpleDateFormat("ddMMyyyy");
    public static SimpleDateFormat yyyymmdd = new SimpleDateFormat("yyyy/MM/dd");
    public static SimpleDateFormat yyyymmdd2 = new SimpleDateFormat("yyyyMMdd");
    public static SimpleDateFormat formatoFechaHora = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
    public static SimpleDateFormat yyyy_MM_dd = new SimpleDateFormat("yyyy-MM-dd");
    public static SimpleDateFormat dd_MM_yyyyy = new SimpleDateFormat("dd-MM-yyyy");

    //-------CARGAR LISTA CON DATOS DEL CLIENTE USUARIOS ACTIVOS
    //public static List<Cliente> clientesListaUTIL = new ArrayList<>();
    //public static List<Permisos> permisosUTIL = new ArrayList<>();
    public String dd_MM_yyyyDATE(Date fecha1) {
        return dd_MM_yyyyy.format(fecha1);
    }

    public static String formatoFechasyyyyMMdd(String fecha) {
        String fechaf;

        fechaf = fecha.substring(6, 10) + "" + fecha.substring(3, 5)
                + "" + fecha.substring(0, 2);

        return fechaf;
    }

    public static java.sql.Date convertir(java.util.Date fechaUtilDate) {
        java.util.Date date = new java.util.Date();
        if (fechaUtilDate == null) {
            return new java.sql.Date(date.getTime());
        }
        return new java.sql.Date(fechaUtilDate.getTime());
    }

    public static String fechaDIAMESDIACST(Date fecha) throws ParseException {
        //java.util.Date fecha = new java.util.Date("Mon Dec 15 00:00:00 CST 2014");
        DateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss Z yyyy", Locale.US);
        java.util.Date date;
        date = (java.util.Date) formatter.parse(fecha.toString());
        System.out.println(date);

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        String formatedDate = cal.get(Calendar.DATE) + "-"
                + (cal.get(Calendar.MONTH) + 1)
                + "-" + cal.get(Calendar.YEAR);
        System.out.println("formatedDate : " + formatedDate);
        return formatedDate;
    }

    public static double convertir2decimales(double valor) {
        BigDecimal decimal = new BigDecimal(valor).setScale(2, RoundingMode.HALF_UP);
        return decimal.doubleValue();
    }
}
