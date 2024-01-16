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
    <form method="post" action="laporan.jsp">
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
<!-- Formulir Filter dan Tabel Output Filter -->
<div class="col-sm-9">
    <div class="row">
        <div class="col-md-4">
            <div class="form-group">
                <label for="tglMulai">Tanggal Mulai:</label>
                <input type="date" class="form-control" id="tglMulai" name="tglMulai">
            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group">
                <label for="tglAkhir">Tanggal Akhir:</label>
                <input type="date" class="form-control" id="tglAkhir" name="tglAkhir">
            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group">
                <label for="customerFilter">Nama Customer:</label>
                <select class="form-control" id="customerFilter" name="customerFilter">
                    <option value="">Semua Customer</option>
                    <!-- Ambil daftar supplier dari database dan tampilkan di sini -->
                    <% 
                        try {
                            dbConnection konek = new dbConnection();
                            Connection conn = konek.koneksiDB();
                            Statement st = conn.createStatement();
                            ResultSet rs = st.executeQuery("SELECT DISTINCT Nama FROM po");
                            while (rs.next()) {
                    %>
                                <option value="<%= rs.getString("Nama") %>"><%= rs.getString("Nama") %></option>
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
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-10">
            <button type="submit" class="btn btn-primary">Filter</button>
            <a href="http://localhost:8089/richfarm/po.jsp" class="btn btn-secondary">Reset Filter</a>
        </div>
    </div>
                <br>
    <!-- Tabel Output Filter -->
    <div class="row">
        <div class="col-sm-12">
            <h2>Hasil Filter</h2>
            <table class="table">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Kd Po</th>
                        <th>Tanggal Po</th>
                        <th>Kode Barang</th>
                        <th>Nama Barang</th>
                        <th>Sisa Stok</th>
                        <th>Harga </th>
                        <th>Jumlah Beli</th>
                        <th>Total Bayaran</th>
                        <th>Nama Customer</th>
                        <!-- Tambahkan kolom sesuai kebutuhan -->
                    </tr>
                </thead>
                <tbody>
                        <!-- Logika Pemrosesan Formulir Filter disini -->
                        <%
                            // Cek apakah sudah ada parameter formulir yang dikirim
                            if (request.getParameter("tglMulai") != null) {
                                // Logika Pemrosesan Formulir Filter
                                String tglMulai = request.getParameter("tglMulai");
                                String tglAkhir = request.getParameter("tglAkhir");
                                String customerFilter = request.getParameter("customerFilter");

                                // Buat kueri SQL berdasarkan kriteria filter
                                String query = "SELECT * FROM po WHERE 1=1";
                                if (tglMulai != null && !tglMulai.isEmpty()) {
                                    query += " AND TglPo >= '" + tglMulai + "'";
                                }
                                if (tglAkhir != null && !tglAkhir.isEmpty()) {
                                    query += " AND TglPo <= '" + tglAkhir + "'";
                                }
                                if (customerFilter != null && !customerFilter.isEmpty()) {
                                    query += " AND Nama = '" + customerFilter + "'";
                                }

                                // Eksekusi kueri dan tampilkan hasilnya
                                try {
                                    dbConnection konek = new dbConnection();
                                    Connection conn = konek.koneksiDB();
                                    Statement st = conn.createStatement();
                                    ResultSet rs = st.executeQuery(query);

                                    int counter = 1;
                                    while (rs.next()) {
                        %>
                                        <tr>
                                            <td><%= counter++ %></td>
                                            <td><%= rs.getString("KdPo") %></td>
                                            <td><%= rs.getString("TglPo") %></td>
                                            <td><%= rs.getString("Kd_Barang") %></td>
                                            <td><%= rs.getString("Nama_Barang") %></td>
                                            <td><%= rs.getString("SisaStok") %></td>
                                            <td><%= rs.getString("Harga") %></td>
                                            <td><%= rs.getString("JumlahBeli") %></td>
                                            <td><%= rs.getString("Total") %></td>
                                            <td><%= rs.getString("Nama") %></td>
                                            <!-- Tambahkan kolom sesuai kebutuhan -->
                                        </tr>
                        <%
                                    }
                                    rs.close();
                                    st.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    out.println("Terjadi kesalahan: " + e.getMessage());
                                }
                            }
                        %>
                    </tbody>
            </table>
        </div>
    </div>
    <!-- Akhir Tabel Output Filter -->
</div>
<!-- Akhir Formulir Filter dan Tabel Output Filter -->
</body>
</html>