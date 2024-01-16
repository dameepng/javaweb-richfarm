<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.dbConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Barang</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
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

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        .table-header {
            font-weight: bold;
            background-color: #f0f0f0;
        }

        .edit-button,
        .delete-button {
            margin: 2px;
            padding: 2px 5px;
            background-color: #f0f0f0;
            border: 1px solid #ddd;
            cursor: pointer;
        }
        
        .align-icon-text {
        display: flex;
        align-items: center;
        }

        .align-icon-text i {
            margin-right: 5px; /* Sesuaikan margin sesuai kebutuhan */
        }
            
        .btn-success,
        .btn-secondary {
            margin: 2px;
            padding: 6px 10px;
            font-size: 16px; /* Sesuaikan ukuran font sesuai kebutuhan */
        }

        .edit-button:hover,
        .delete-button:hover {
            background-color: #ddd;
        }

        .search-container {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <form method="post" action="ctrbarang.jsp">
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
                <div class="col-md-10">
                    <!-- Isi dari supplierdata.jsp -->
                    <div class="container">
                        <h2>Data Barang</h2>
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
                                <label for="kodeSupplier">Kode Barang:</label>
                                <input type="text" class="form-control" name="txtKd_Barang" placeholder="Masukan Kode Barang" value="<%= request.getParameter("Kd_Barang") != null ? request.getParameter("Kd_Barang") : "" %>">
                            </div>
                            <div class="form-group">
                                <label for="namaSupplier">Nama Barang:</label>
                                <input type="text" class="form-control" name="txtNama_Barang" placeholder="Masukan Nama Barang" value="<%= request.getParameter("Nama_Barang") != null ? request.getParameter("Nama_Barang") : "" %>">
                            </div>
                            <div class="form-group">
                                <label for="noHandphone">Harga:</label>
                                <input type="text" class="form-control" name="txtHarga" placeholder="Masukan Harga Barang" onkeypress="return angkaSaja(event)" required value="<%= request.getParameter("Harga") != null ? request.getParameter("Harga") : "" %>">
                            </div>
                            <div class="form-group">
                                <label for="alamat">Jenis:</label>
                                <select class="form-control" name="txtKdJenis"  >
                                            <option value="Semua">Pilih Jenis Barang</option>
                                           <%
                                            try {
                                                dbConnection konek = new dbConnection();
                                                Connection conn = konek.koneksiDB();
                                                Statement st = conn.createStatement();
                                                ResultSet rs = st.executeQuery("SELECT KdJenis, JenisBarang FROM jenis"); // tambahkan kolom HargaJual
                                                while (rs.next()) {
                                            %>
                                                <option value="<%= rs.getString("KdJenis") %>"><%= rs.getString("JenisBarang") %></option>

                                            <%
                                                }
                                                rs.close();
                                                st.close();
                                                conn.close();
                                            } catch (Exception e) {
                                                out.print(e);
                                            }
                                            %>
                                        </select>
                                        <br>
                                        <a href="http://localhost:8089/richfarm/jenis.jsp" class="btn btn-success"><i class="material-icons">&#xE147;</i> <span>Tambah Jenis Barang</span></a>
                            </div>          
                            <input type="submit" class="btn btn-primary" value="Add" name="cmdadd">
                            <input type="submit" class="btn btn-primary" value="ubah" name="cmdadd">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>