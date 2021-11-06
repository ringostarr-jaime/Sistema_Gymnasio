package com.netbeans.DAO;

import com.netbeans.model.Detallefactura;
import com.netbeans.model.Venta;
import java.sql.*;
import java.util.List;

public class VentaDAO extends DAO {

    public void registrar(Venta venta, List<Detallefactura> lista) throws Exception {
        try {
            this.Conectar();
            this.getCn().setAutoCommit(false);

            //Llenar tablas ventas
            PreparedStatement st = this.getCn().prepareStatement("insert into venta(fecha,codPersona, monto)values(?,?,?)");
            st.setDate(1, venta.getFecha());
            st.setInt(2, venta.getPersona().getCodigo());
            st.setDouble(3, venta.getMonto());
            st.executeUpdate();
            st.close();

            //Obtenemos el ultimo id generado en la tabla venta
            PreparedStatement st2 = this.getCn().prepareStatement("select last_insert_id() from venta limit 1");
            ResultSet rs;
            int codVenta = 0;
            rs = st2.executeQuery();
            while (rs.next()) {
                codVenta = rs.getInt(1);
            }
            rs.close();

            //ese valor lo paso aca para poder hacer la insercion
            for (Detallefactura det : lista) {
                PreparedStatement st3 = this.getCn().prepareStatement("insert into DetalleVenta(codVenta,codProducto,cantidad)values(?,?,?)");
                st3.setInt(1, codVenta);
                st3.setInt(2, det.getProducto().getCodProducto());
                st3.setDouble(3, det.getCantidad());
                st3.executeUpdate();
                st3.close();
            }
            this.getCn().commit();
        } catch (Exception e) {
            this.getCn().rollback();
        } finally {
            this.cerrar();
        }
    }

}
