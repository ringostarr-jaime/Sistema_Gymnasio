package com.netbeans.DAO;

import com.netbeans.model.Persona;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

//Aca van las consultas a la base de datos y extiendo de DAO que es la conexion a la abse de datos

public class PersonaDAO extends DAO{
    
    String sql1="insert into persona (nombre,sexo) values(?,?)";
    
    public void registrar(Persona per) throws SQLException, Exception
    {
        try {
        this.Conectar();
        this.getCn().setAutoCommit(false);
         PreparedStatement st=this.getCn().prepareStatement(sql1);
            st.setString(1, per.getNombre());
            st.setString(2, per.getSexo());
            st.executeUpdate();
            st.close();
            this.getCn().commit();
        } catch (Exception e) {
            this.getCn().rollback();
           throw e;
        }finally
        {
            this.cerrar();        
        }
    }
    
    public List<Persona> listar() throws Exception
    {
        List<Persona> lista;
        ResultSet rs;
        try {
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("Select codigo,nombre,sexo from persona");
            rs=st.executeQuery();
            lista = new ArrayList();
            while(rs.next())
            {
            Persona per = new Persona();
            per.setCodigo(rs.getInt("codigo"));
            per.setNombre(rs.getString("nombre"));
            per.setSexo(rs.getString("sexo"));
            
            lista.add(per);
            }
        } catch (Exception e) {
            throw e;
        }finally
        {
        this.cerrar();
        }
        return lista;
    }
    
    public Persona leerId(Persona pers) throws Exception
    {
        Persona per = null;
        ResultSet rs;        
        try {
            this.Conectar();
            PreparedStatement st = this.getCn().prepareStatement("select codigo, nombre, sexo from persona where codigo=?");
            st.setInt(1, pers.getCodigo());
            rs=st.executeQuery();
            while(rs.next())
            {
            per= new Persona();
            per.setCodigo(rs.getInt("codigo"));
            per.setNombre(rs.getString("Nombre"));
            per.setSexo(rs.getString("Sexo"));
            }            
        } catch (Exception e) {
            throw e;
            
        }finally
        {
        this.cerrar();
        }
        return per;
    }
    
      public void modificar(Persona per) throws SQLException, Exception
    {
        try {
        this.Conectar();
        this.getCn().setAutoCommit(false);
         PreparedStatement st=this.getCn().prepareStatement("update persona set nombre =?, sexo=? where codigo=?");
            st.setString(1, per.getNombre());
            st.setString(2, per.getSexo());
            st.setInt(3, per.getCodigo());
            st.executeUpdate();
            st.close();
            this.getCn().commit();
        } catch (Exception e) {
            this.getCn().rollback();
           throw e;
        }finally
        {
            this.cerrar();        
        }
    }
      
    public void eliminar(Persona per) throws SQLException, Exception
    {
        try {
        this.Conectar();
         this.getCn().setAutoCommit(false);
         PreparedStatement st=this.getCn().prepareStatement("delete from persona where codigo=?");          
            st.setInt(1, per.getCodigo());
            st.executeUpdate();
            st.close();
            this.getCn().commit();
        } catch (Exception e) {
            this.getCn().rollback();
           throw e;
        }finally
        {
            this.cerrar();        
        }
    }
}
