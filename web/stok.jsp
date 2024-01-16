<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="database.dbConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Supplier</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .sidebar {
            background-color: #343a40;
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
            font-size: 16px;
        }
        .sidebar a {
            display: block;
            color: white;
            padding: 16px;
            text-decoration: none;
        }
        .sidebar a.active {
            background-color: #04AA6D;
            color: white;
        }
        .sidebar a:hover:not(.active) {
            background-color: #555;
            color: white;
        }
        div.content {
            margin-left: 200px;
            padding: 1px 16px;
            height: 1000px;
        }
        @media screen and (max-width: 700px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            .sidebar a {
                float: none;
                display: block;
                text-align: left;
            }
            div.content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <form method="post" action="ctrstok.jsp">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 p-0 sidebar text-light">
                    <div class="p-4">
                        <h2>Sidebar</h2>
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link text-light" href="http://localhost:8089/richfarm/barang.jsp">Barang</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light" href="http://localhost:8089/richfarm/pelanggan.jsp">Data Pelanggan</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-light" href="http://localhost:8089/richfarm/jenis.jsp">Jenis Barang</a>
                            </li>
                            <li class="nav-item">
                            <a class="nav-link text-light" href="http://localhost:8089/richfarm/stok.jsp">Stok Persediaan</a>
                            </li>
                            <li class="nav-item">
                            <a class="nav-link text-light" href="http://localhost:8089/richfarm/po.jsp">Pre-Order</a>
                            </li>
                            <li class="nav-item">
                            <a class="nav-link text-light" href="http://localhost:8089/richfarm/laporan.jsp">Laporan</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <%
String noStok = "St01";  // Nomor Nota default jika tidak ada data pembelian sebelumnya
Connection conn = null; // Deklarasi variabel koneksi
try {
    dbConnection konek = new dbConnection();
    conn = konek.koneksiDB();

    // Ambil nomor nota terakhir
    String sqlMaxStok = "SELECT MAX(CAST(SUBSTRING(KdStok, 3) AS SIGNED)) AS MaxStok FROM stok";
    try (Statement stNota = conn.createStatement();
         ResultSet rsNota = stNota.executeQuery(sqlMaxStok)) {

        if (rsNota.next()) {
            // Jika ada data pembelian sebelumnya, hasilkan nomor nota baru
            int nomorTerakhir = rsNota.getInt("MaxStok");
            noStok = "St" + String.format("%02d", nomorTerakhir + 1);  // Format ulang nomor nota baru
        }
    }

    // Sisanya dari kode Anda
    // ...

} catch (SQLException e) {
    out.print("Error SQL: " + e.getMessage()); // Cetak pesan kesalahan
} finally {
    // Tutup koneksi di sini
    if (conn != null) {
        try {
            conn.close();
        } catch (SQLException e) {
            out.print("Error saat menutup koneksi: " + e.getMessage()); // Cetak pesan kesalahan
        }
    }
}
%>
                <div class="col-md-10">
                    <!-- Isi dari supplierdata.jsp -->
                    <div class="container">
                        <h2>Data Penyesuaian Stok</h2>
                        <form>
                            <script type="text/javascript">
                                function angkaSaja(evt)
                                  {
                                    var charCode= (evt.which) ? evt.which: event.keyCode;
                                    if(charCode>31 && (charCode<48 || charCode>57))
                                        return false;
                                        return true;
                                  }
                            </script>
                            <div class="form-group">
                                <label for="namaBarang">Kode Stok:</label>
                                <input type="text" class="form-control" id="KdStok" name="txtKdStok" value="<%= noStok %>" readonly>
                            </div>
                            
                                        <%
                                    // Mengambil data kategori dari database (contoh menggunakan JDBC)
                                    try {
                                        dbConnection konek = new dbConnection();
                                        Connection conn1 = konek.koneksiDB();
                                        Statement st= conn1.createStatement();
                                        ResultSet rs = st.executeQuery("SELECT Nama_Barang FROM barang");
                                %>
                                    <div class="form-group">
                                    <label for="kategori">Pilih Barang:</label>
                                    <select class="form-control" id="Nama" name="txtNama_Barang" required>
                                        <option value="" disabled selected></option>
                                        <% while (rs.next()) { %>
                                            <option value="<%= rs.getString("Nama_Barang") %>"><%= rs.getString("Nama_Barang") %></option>
                                        <% } %>
                                    </select>
                                </div>
                                    <%
                                    rs.close();
                                    st.close();
                                    conn.close();
                                } catch(Exception e) {
                                    out.print(e);
                                }
                                %>
                            <div class="form-group">
                                <label for="noHandphone">Terbeli:</label>
                                <input type="text" class="form-control" name="txtTerbeli" id="terbeli" placeholder="Masukan Stok Terbeli" onkeypress="return angkaSaja(event)">
                            </div>
                            <div class="form-group">
                                <label for="noHandphone">Terjual:</label>
                                <input type="text" class="form-control" name="txtTerjual" id="terjual" placeholder="Masukan Stok Terjual" onkeypress="return angkaSaja(event)">
                            </div>
                            <div class="form-group">
                                <label for="namaBarang">Sisa Stok:</label>
                                <input type="text" class="form-control" name="txtSisaStok" id="sisaStok" readonly>
                            </div>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                            <input type="submit" class="btn btn-primary" value="Simpan" name="cmdsubmit">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var dropdown = document.getElementsByClassName("dropdown-btn");
            var i;

            for (i = 0; i < dropdown.length; i++) {
                dropdown[i].addEventListener("click", function() {
                    this.classList.toggle("active");
                    var dropdownContent = this.nextElementSibling;
                    if (dropdownContent.style.display === "block") {
                        dropdownContent.style.display = "none";
                    } else {
                        dropdownContent.style.display = "block";
                    }
                });

                // Tambahkan ini untuk menutup dropdown secara default
                dropdown[i].nextElementSibling.style.display = "none";
            }
        });
    </script>
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        var terjualInput = document.getElementById("terjual");
        var terbeliInput = document.getElementById("terbeli");
        var sisaStokInput = document.getElementById("sisaStok");

        // Fungsi untuk menghitung dan mengupdate Sisa Stok
        function updateSisaStok() {
            var terjualValue = parseInt(terjualInput.value) || 0;
            var terbeliValue = parseInt(terbeliInput.value) || 0;
            var sisaStok = terbeliValue - terjualValue;

            // Update nilai Sisa Stok pada input
            sisaStokInput.value = isNaN(sisaStok) ? '' : sisaStok;
        }
        

        // Tambahkan event listener pada input Terjual dan Terbeli
        terjualInput.addEventListener("input", updateSisaStok);
        terbeliInput.addEventListener("input", updateSisaStok);
    });
</script>
</body>
</html>