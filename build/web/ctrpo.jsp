<%@page import="java.sql.PreparedStatement"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="database.dbConnection"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Tambah Pembelian</title>
</head>
<body>
<%
    // tangkap parameter
    String KdPo = request.getParameter("txtKdPo");
    String TglPoParam = request.getParameter("txtTglPo");
    String Nama_Barang = request.getParameter("txtNama_Barang");
    String SisaStokParam = request.getParameter("txtSisaStok");
    String Harga = request.getParameter("txtHarga");
    String JumlahBeli = request.getParameter("txtJumlahBeli");
    String Total = request.getParameter("txtTotal");
    String Nama = request.getParameter("txtNama");

    // konversi tipe data
    int sisaStok = 0;
    if (SisaStokParam != null && !SisaStokParam.isEmpty()) {
        sisaStok = Integer.parseInt(SisaStokParam);
    }

    int harga = 0;
    if (Harga != null) {
        harga = Integer.parseInt(Harga);
    }

    int jumlahBeli = 0;
    int total = 0;

    if (JumlahBeli != null && !JumlahBeli.isEmpty()) {
        jumlahBeli = Integer.parseInt(JumlahBeli);
    }

    if (Total != null && !Total.isEmpty()) {
        total = Integer.parseInt(Total);
    }

    String action = request.getParameter("cmdsubmit");

    if ("Submit".equals(action)) {

        try {

            // cek duplikasi NoNota
            dbConnection konek = new dbConnection();
            Connection conn = konek.koneksiDB();
            String sqlCheck = "SELECT KdPo FROM po WHERE KdPo = ?";
            PreparedStatement psCheck = conn.prepareStatement(sqlCheck);
            psCheck.setString(1, KdPo);
            ResultSet rsCheck = psCheck.executeQuery();

            if (rsCheck.next()) {
                %>
                <script>
                    alert("KdPo " + <%=KdPo%> + " sudah ada!");
                    window.location = "po.jsp";
                </script>
                <%
                return;
            }

            // ambil SKU barang
            new dbConnection().koneksiDB();
            Connection conn2 = konek.koneksiDB();
            Statement st = conn2.createStatement();
            ResultSet rsBarang = st.executeQuery("SELECT Kd_Barang FROM barang WHERE Nama_Barang ='" + Nama_Barang + "'");
            String Kd_Barang = "";
            if (rsBarang.next()) {
                Kd_Barang = rsBarang.getString("Kd_Barang");
            }

            // siapkan query insert
            java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
            String sqlInsert = "INSERT INTO po(KdPo, Kd_Barang, TglPo, Nama_Barang, SisaStok, Harga, JumlahBeli, Total, Nama) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            // insert data
            PreparedStatement psInsert = conn.prepareStatement(sqlInsert);
            psInsert.setString(1, KdPo);
            psInsert.setString(2, Kd_Barang);
            psInsert.setDate(3, currentDate);
            psInsert.setString(4, Nama_Barang);
            psInsert.setInt(5, sisaStok);
            psInsert.setInt(6, harga);
            psInsert.setInt(7, jumlahBeli);
            psInsert.setInt(8, total);
            psInsert.setString(9, Nama);

            psInsert.executeUpdate();

            // redirect ke halaman pembelian
            %>
            <script>
                alert("Data berhasil ditambahkan");
                window.location = "po.jsp";
            </script>
            <%
        } catch (Exception e) {
            out.print("Terjadi error: " + e.getMessage());
        }
    } else if ("hapus".equals(action)) {
                try {
                    dbConnection konek = new dbConnection();
                    Connection conn = konek.koneksiDB();
                    Statement st = conn.createStatement();
                    String sql = "DELETE FROM po WHERE KdPo = '" + KdPo + "'";
                    st.executeUpdate(sql);
                    conn.close();
        %>
                    <script>
                        alert("Data berhasil dihapus");
                        window.location = "po.jsp";
                    </script>
        <%
                } catch(Exception e) {
                    out.print(e);
                }
            }
        %>
</body>
</html>
