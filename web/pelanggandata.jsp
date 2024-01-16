<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Pelanggan</title>
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
    <form method="post" action="ctrpelanggan.jsp">
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
                    <!-- Isi dari pelanggandata.jsp -->
                    <div class="container">
                        <h2>Data Pelanggan</h2>
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
                                <label for="kodeSupplier">Kode Customer:</label>
                                <input type="text" class="form-control" name="txtKd_Customer" placeholder="Masukan Kode Customer" value="<%= request.getParameter("Kd_Customer") != null ? request.getParameter("Kd_Customer") : "" %>">
                            </div>
                            <div class="form-group">
                                <label for="namaSupplier">Nama Customer:</label>
                                <input type="text" class="form-control" name="txtNama" placeholder="Masukan Nama Customer" value="<%= request.getParameter("Nama") != null ? request.getParameter("Nama") : "" %>">
                            </div>
                            <div class="form-group">
                                <label for="alamat">Alamat:</label>
                                <textarea class="form-control" name="txtAlamat" rows="3" placeholder="Masukan Alamat"><%= request.getParameter("Alamat") != null ? request.getParameter("Alamat") : "" %></textarea>
                            </div>
                            <div class="form-group">
                                <label for="noHandphone">No. Telepon</label>
                                <input type="text" class="form-control" name="txtNo_Telp" placeholder="Masukan Nomor Handphone" onkeypress="return angkaSaja(event)" required value="<%= request.getParameter("No_Telp") != null ? request.getParameter("No_Telp") : "" %>">
                            </div>
                            <input type="submit" class="btn btn-primary" value="Submit" name="cmdsubmit">
                            <input type="submit" class="btn btn-primary" value="ubah" name="cmdsubmit">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>