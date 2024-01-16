<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Sederhana</title>
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
    <form method="post" action="ctrjenis.jsp">
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
                    <!-- Konten Merek -->
                    <h1>Jenis Barang</h1>
                    <br>
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <form name="tampilan" action="barang.jsp" method="post" onsubmit="return ValidasiKosong()">
                                    <div class="form-group">
                                        <label>Kode :</label>
                                        <input type="text" name="txtKdJenis" class="form-control" required placeholder="Masukan Kode">
                                    </div>
                                    <div class="form-group">            
                                        <label>Jenis Barang :</label>
                                        <input type="text" name="txtJenisBarang" class="form-control "  required placeholder="Masukan Jenis Barang">
                                    </div>
                                </form>
                            </tr>
                        </tbody>
                    </table>
                    <input type="submit" class="btn btn-success" value="Add" name="cmdadd">
                </div>
            </div>
        </div>
    </form>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
