<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="database.dbConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
<%
    String KdStok = request.getParameter("txtKdStok");
    String Nama_Barang = request.getParameter("txtNama_Barang");
    int Terbeli = Integer.parseInt(request.getParameter("txtTerbeli"));
    int Terjual = Integer.parseInt(request.getParameter("txtTerjual"));
    int SisaStok = Terbeli - Terjual;
    String action = request.getParameter("cmdsubmit");

    if ("Simpan".equals(action)) {
        try {
            // Check duplicate KdStok
            dbConnection konek = new dbConnection();
            Connection conn = konek.koneksiDB();
            String sqlCheck = "SELECT KdStok FROM stok WHERE KdStok = ?";
            try (PreparedStatement psCheck = conn.prepareStatement(sqlCheck)) {
                psCheck.setString(1, KdStok);
                try (ResultSet rsCheck = psCheck.executeQuery()) {
                    if (rsCheck.next()) {
                        %>
                        <script>
                            alert("KdStok <%=KdStok%> sudah ada!");
                            window.location = "stok.jsp";
                        </script>
                        <%
                        return;
                    }
                }
            }

            // Get SKU
            try (Connection conn2 = konek.koneksiDB();
                 PreparedStatement ps = conn2.prepareStatement("SELECT Kd_Barang FROM barang WHERE Nama_Barang = ?");
            ) {
                ps.setString(1, Nama_Barang);
                try (ResultSet rsBarang = ps.executeQuery()) {
                    String Kd_Barang = "";
                    if (rsBarang.next()) {
                        Kd_Barang = rsBarang.getString("Kd_Barang");
                    }

                    // Insert data
                    String sqlInsert = "INSERT INTO stok(KdStok, Kd_Barang, Nama_Barang, Terbeli, Terjual, SisaStok) VALUES (?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement psInsert = conn.prepareStatement(sqlInsert)) {
                        psInsert.setString(1, KdStok);
                        psInsert.setString(2, Kd_Barang);
                        psInsert.setString(3, Nama_Barang);
                        psInsert.setInt(4, Terbeli);
                        psInsert.setInt(5, Terjual);
                        psInsert.setInt(6, SisaStok);

                        psInsert.executeUpdate();

                        // Redirect to the stok.jsp page
                        %>
                        <script>
                            alert("Data berhasil ditambahkan");
                            window.location = "stok.jsp";
                        </script>
                        <%
                    }
                }
            }
        } catch (Exception e) {
            out.print(e);
        }
    }
%>
</body>
</html>
