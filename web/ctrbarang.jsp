<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.dbConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
            String Kd_Barang = request.getParameter("txtKd_Barang");
            String Nama_Barang = request.getParameter("txtNama_Barang");
            String Harga = request.getParameter("txtHarga");
            String KdJenis = request.getParameter("txtKdJenis");
            String action = request.getParameter("cmdadd");

            if ("Add".equals(action)) {
                try {
                    dbConnection konek = new dbConnection();
                    Connection conn = konek.koneksiDB();
                    Statement st = conn.createStatement();
                    ResultSet rsJenis = st.executeQuery("SELECT JenisBarang FROM jenis WHERE KdJenis = '"+KdJenis+"'");
                    String JenisBarang = "";
                    if (rsJenis.next()) {
                        JenisBarang = rsJenis.getString("JenisBarang");
                    }
                    rsJenis.close();

                    String sql = "INSERT INTO barang(Kd_Barang, Nama_Barang, Harga, JenisBarang) " +
                                 "VALUES ('"+Kd_Barang+"', '"+Nama_Barang+"', '"+Harga+"'," +
                                 "'"+JenisBarang+"')";
                    st.executeUpdate(sql);
                    conn.close();
        %>
                    <script>
                        alert("Data berhasil ditambahkan");
                        window.location = "barang.jsp";
                    </script>
        <%
                } catch(Exception e) {
                    out.print(e);
                }
            } else if ("ubah".equals(action)) {
                try {
                    dbConnection konek = new dbConnection();
                    Connection conn = konek.koneksiDB();
                    Statement st = conn.createStatement();
                     ResultSet rsJenis = st.executeQuery("SELECT JenisBarang FROM jenis WHERE KdJenis = '"+KdJenis+"'");
                    String JenisBarang = "";
                    if (rsJenis.next()) {
                        JenisBarang = rsJenis.getString("JenisBarang");
                    }
                    rsJenis.close();

                   String sql = "UPDATE barang " +
                         "SET Nama_Barang = '" + Nama_Barang + "', " +
                         "Harga = '" + Harga + "', " +
                         "JenisBarang = '" + JenisBarang + "'" +
                         "WHERE Kd_Barang = '" + Kd_Barang + "'";
                    st.executeUpdate(sql);
                    conn.close();
        %>
                    <script>
                        alert("Data berhasil diubah");
                        window.location = "barang.jsp";
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
                     String sql = "DELETE FROM barang WHERE Kd_Barang = '" + Kd_Barang + "'";
                    st.executeUpdate(sql);
                    conn.close();
        %>
                    <script>
                        alert("Data berhasil dihapus");
                        window.location = "barang.jsp";
                    </script>
        <%
                } catch(Exception e) {
                    out.print(e);
                }
            }
             %>
    </body>
</html>
