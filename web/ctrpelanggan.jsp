<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="database.dbConnection"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
            String Kd_Customer = request.getParameter("txtKd_Customer");
            String Nama = request.getParameter("txtNama");
            String Alamat = request.getParameter("txtAlamat");
            String No_Telp = request.getParameter("txtNo_Telp");
            String action = request.getParameter("cmdsubmit");

            if ("Submit".equals(action)) {
                try {
                    dbConnection konek = new dbConnection();
                    Connection conn = konek.koneksiDB();
                    Statement st = conn.createStatement();
                    String sql = "INSERT INTO customer(Kd_Customer, Nama, Alamat, No_Telp) " +
                                 "VALUES ('"+Kd_Customer+"', '"+Nama+"', '"+Alamat+"', '"+No_Telp+"')";
                    st.executeUpdate(sql);
                    conn.close();
        %>
                    <script>
                        alert("Data berhasil ditambahkan");
                        window.location = "pelanggan.jsp";
                    </script>
        <%
                } catch(Exception e) {
                    e.printStackTrace();
                }
            } else if ("ubah".equals(action)) {
                try {
                    dbConnection konek = new dbConnection();
                    Connection conn = konek.koneksiDB();
                    Statement st = conn.createStatement();
                    String sql = "UPDATE customer " +
                                 "SET Nama = '" + Nama + "', " +
                                 "Alamat = '" + Alamat + "', " +
                                 "No_Telp = '" + No_Telp + "'" +
                                 "WHERE Kd_Customer = '" + Kd_Customer + "'";
                    st.executeUpdate(sql);
                    conn.close();
        %>
                    <script>
                        alert("Data berhasil diubah");
                        window.location = "pelanggan.jsp";
                    </script>
        <%
                } catch(Exception e) {
                    out.print(e);
                }
            } else if ("hapus".equals(action)) {
                try {
                    dbConnection konek = new dbConnection();
                    Connection conn = konek.koneksiDB();
                    Statement st = conn.createStatement();
                    String sql = "DELETE FROM customer WHERE Kd_Customer = '" + Kd_Customer + "'";
                    st.executeUpdate(sql);
                    conn.close();
        %>
                    <script>
                        alert("Data berhasil dihapus");
                        window.location = "pelanggan.jsp";
                    </script>
        <%
                } catch(Exception e) {
                    out.print(e);
                }
            }
        %>
    </body>
</html>
