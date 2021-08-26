package com.convertidor;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;

//Convertidor de datos 

@FacesConverter("sexoConverter")
public class SexoConverter implements Converter{

    @Override
    public Object getAsObject(FacesContext context, UIComponent component, String value) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAsString(FacesContext context, UIComponent component, Object value) {
        String sexo="";
        if(value !=null)
        {
            sexo=(String)value;
            switch(sexo)
            {
                case "M":
                    sexo="MASCULINO";
                    break;
                    
                    case "F":
                    sexo="FEMENINO";
                    break;
                    
            }
        
        }
        
        
        return sexo;
    }
    
}
