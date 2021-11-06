package com.netbeans.DAO;





import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;




public class DAO implements Serializable {
 
    //---DESAROLLO
    public static String jdbc="jdbc:mysql://localhost:3306/ventas";
    public static String user="root";
    public static String pass="123";
    
    //---PRODUCCION
   /*public static String jdbc="";
    public static String user="";
    public static String pass="";*/
    
 private Connection cn;
 
    public Connection getCn() {
        return cn;
    }

    public void setCn(Connection cn) {
        this.cn = cn;
    }   
    
    public void Conectar() throws Exception
    {      
        try {  
            /*Properties prop = new Properties();
            prop.load(new FileInputStream("C:\\conexiones.properties"));
            String jdbc=prop.getProperty("jdbc");
            String user= prop.getProperty("user");
            String pass=prop.getProperty("pass");
              System.out.println("jdbc "+prop.getProperty("jdbc"));
         System.out.println("user "+prop.getProperty("user"));
         System.out.println("pass "+prop.getProperty("pass"));*/
            Class.forName("com.mysql.jdbc.Driver");            
            //cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/ventas","root","123");
            cn=DriverManager.getConnection(jdbc,user,pass);
        } catch (Exception e) {
            throw e;
        }
    
    }
    public void cerrar() throws Exception
    {
        try {
            if(cn != null)
            {
                if(cn.isClosed()==false)
                {
                cn.close();
                }
            
            }
        } catch (Exception e) {
            throw e;
        }
    }
}
