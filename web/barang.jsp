<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="database.dbConnection"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Sederhana</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
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
                    <h1>Data Barang</h1>
                            <div class="row">
                                <div class="col-md-2">
                                    <a href="http://localhost:8089/richfarm/barangdata.jsp" class="btn btn-success btn-block align-icon-text">
                                        <i class="material-icons">&#xE147;</i>
                                        <span style="">Tambah Barang</span>
                                    </a>
                                </div>
                                <div class="col-md-2">
                                    <a href="#searchEmployeeModal" class="btn btn-secondary btn-block align-icon-text" data-toggle="modal">
                                        <i class="material-icons">search</i>
                                        <span>Search</span>
                                    </a>
                                </div>
                            </div>
                       <%
    try {
        dbConnection konek = new dbConnection();
        Connection conn = konek.koneksiDB();
        Statement st = conn.createStatement();

        String action = request.getParameter("cmdsubmit");

        if ("cari".equals(action)) {
            String keyword = request.getParameter("txtCariNama");
            String encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
            ResultSet rs = st.executeQuery("SELECT * FROM barang WHERE Nama_Barang LIKE '%" + keyword + "%'");
%>
            <!-- Tampilkan Hasil Pencarian -->
            <h2>Hasil Pencarian untuk "<%= keyword %>"</h2>
            <table>
                <tr class="table-header">
                    <th>No</th>
                    <th>Kode Barang</th>
                    <th>Nama Barang</th>
                    <th>Harga</th>
                    <th>Jenis</th>
                    <th>Opsi</th>
                </tr>
<%
            int counter = 1;
            while (rs.next()) {
                String Kd_Barang = rs.getString("Kd_Barang");
                String Nama_Barang = rs.getString("Nama_Barang");
                String Harga = rs.getString("Harga");
                String JenisBarang = rs.getString("JenisBarang");
%>
                <tr>
                    <td><%= counter %></td>
                    <td><%= rs.getString("Kd_Barang") %></td>
                    <td><%= rs.getString("Nama_Barang") %></td>
                    <td><%= rs.getString("Harga") %></td>
                    <td><%= rs.getString("JenisBarang") %></td>
                    <td>
                        <a href="http://localhost:8089/richfarm/barangdata.jsp?Kd_Barang=<%= rs.getString("Kd_Barang") %>&Nama_Barang=<%= rs.getString("Nama_Barang") %>&Harga=<%= rs.getString("Harga") %>&JenisBarang=<%= rs.getString("JenisBarang") %>" class="edit btn btn-warning">
                    <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
                </a>
                 &nbsp;&nbsp;&nbsp;
                 <a href="#deleteEmployeeModal" class="delete btn btn-danger" value="hapus" data-toggle="modal" data-Kd_Barang="<%= rs.getString("Kd_Barang") %>">
                     <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i>
                 </a>
                    </td>
                </tr>
<%
                counter++;
            }
%>
            </table>
<%
        } else {
            ResultSet rs = st.executeQuery("SELECT * FROM barang");
%>
            <!-- Tampilkan Semua Data -->
           
            <table>
                <tr class="table-header">
                    <th>No</th>
                    <th>Kode Barang</th>
                    <th>Nama Barang</th>
                    <th>Harga</th>
                    <th>Jenis</th>
                    <th>Opsi</th>
                </tr>
<%
            int counter = 1;
            while (rs.next()) {
                String Kd_Barang = rs.getString("Kd_Barang");
                String Nama_Barang = rs.getString("Nama_Barang");
                String Harga = rs.getString("Harga");
                String JenisBarang = rs.getString("JenisBarang");
%>
                <tr>
                    <td><%= counter %></td>
                    <td><%= rs.getString("Kd_Barang") %></td>
                    <td><%= rs.getString("Nama_Barang") %></td>
                    <td><%= rs.getString("Harga") %></td>
                    <td><%= rs.getString("JenisBarang") %></td>
                <td>
                <a href="http://localhost:8089/richfarm/barangdata.jsp?Kd_Barang=<%= rs.getString("Kd_Barang") %>&Nama_Barang=<%= rs.getString("Nama_Barang") %>&Harga=<%= rs.getString("Harga") %>&JenisBarang=<%= rs.getString("JenisBarang") %>" class="edit btn btn-warning">
                    <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
                </a>
                 &nbsp;&nbsp;&nbsp;
                 <a href="#deleteEmployeeModal" class="delete btn btn-danger" value="hapus" data-toggle="modal" data-Kd_Barang="<%= rs.getString("Kd_Barang") %>">
                     <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i>
                 </a>
            </td>
        </tr>
                        <%
            counter++;
        }
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>
                    </table>
                </div>
            </div>
        </div>
    </form>
    <div id="searchEmployeeModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="barang.jsp">
                <div class="modal-header">                        
                    <h4 class="modal-title">Search Data</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">                    
                    <div class="form-group">
                        <label for="txtCariNama">Nama Barang</label>
                        <input type="text" id="txtCariNama" name="txtCariNama" class="form-control" placeholder="Masukkan nama barang yang ingin dicari">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <input type='submit' class="btn btn-primary" value='cari' name='cmdsubmit'>
                </div>
            </form>
        </div>
    </div>
</div>
 <div id="deleteEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form method="post" action="ctrbarang.jsp">
                    <div class="modal-header">
                        <h4 class="modal-title">Hapus Data Barang</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p>Anda yakin ingin menghapus data ini?</p>
                        <p class="text-warning"><small>Ini akan menghapus data secara permanen.</small></p>
                        <input type="hidden" name="txtKd_Barang" id="delete-Kd_Barang">
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Batal" name="cmdadd">
                        <input type="submit" class="btn btn-danger" value="hapus" name="cmdadd">
                    </div>
                </form>
            </div>
        </div>
    </div>
  <script>
document.addEventListener("DOMContentLoaded", function() {
    var editButtons = document.querySelectorAll("[name='data-edit']");

    for (var i = 0; i < editButtons.length; i++) {
        editButtons[i].addEventListener("click", function() {
            var Kd_Barang = this.getAttribute("data-Kd_Barang");
            var Nama_Barang = this.getAttribute("data-Nama_Barang");
            var Harga = this.getAttribute("data-Harga");
            var KdJenis = this.getAttribute("data-KdJenis");

            // Mengarahkan ke supplierdata.jsp dengan membawa data melalui parameter URL
            var url = "http://localhost:8080/richfarm/barangdata.jsp?" +
                      "Kd_Barang=" + encodeURIComponent(Kd_Barang) +
                      "&Nama_Barang=" + encodeURIComponent(Nama_Barang) +
                      "&Harga=" + encodeURIComponent(Harga) +
                      "&KdJenis=" + encodeURIComponent(KdJenis);
                      

            window.location.href = url;
        });
    }
});
</script>
 <script>
        document.addEventListener("DOMContentLoaded", function () {
            var deleteButtons = document.querySelectorAll(".delete");

            for (var i = 0; i < deleteButtons.length; i++) {
                deleteButtons[i].addEventListener("click", function () {
                    var Kd_Barang = this.getAttribute("data-Kd_Barang");
                    $('#delete-Kd_Barang').val(Kd_Barang);
                });
            }
        });
    </script>
</body>
</html>