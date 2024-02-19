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
            margin-left: 270px;
            padding: 1px 16px; /* Ganti padding menjadi 20px */
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
        
        body {
            font-family: 'Arial', sans-serif;
        }

        .container-fluid {
            display: flex;
        }

        .sidebar {
            background-color: #343a40;
            min-height: 100vh;
            color: white;
            padding: 20px;
            width: 200px;
            margin-right: 20px;
        }

        .sidebar a {
            display: block;
            color: white;
            padding: 16px;
            text-decoration: none;
        }

        .content {
            padding: 20px; /* Tambahkan padding 20px */
            flex-grow: 1;
            margin: 20px 20px 0 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        th,
        td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .total {
            font-weight: bold;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <form method="post" action="ctrpo.jsp">
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
               <%!
        String nomorNotaBaru = "Nt01";  // Nomor Nota default jika tidak ada data pembelian sebelumnya
        Connection conn = null; // Deklarasi variabel koneksi
    %>

    <!-- Kode lainnya -->

    <%-- Kode untuk menghubungkan ke database dan query --%>
    <%
        try {
            dbConnection konek = new dbConnection();
            conn = konek.koneksiDB();

            // Ambil nomor nota terakhir
            Statement stNota = conn.createStatement();
            ResultSet rsNota = stNota.executeQuery("SELECT MAX(KdPo) AS MaxPo FROM po");

            if (rsNota.next()) {
                // Jika ada data pembelian sebelumnya, hasilkan nomor nota baru
                String nomorNotaTerakhir = rsNota.getString("MaxPo");
                if (nomorNotaTerakhir != null && !nomorNotaTerakhir.isEmpty()) {
                    int nomorTerakhir = Integer.parseInt(nomorNotaTerakhir.substring(2));  // Ambil angka setelah "Nt"
                    nomorNotaBaru = "Nt" + String.format("%02d", nomorTerakhir + 1);  // Format ulang nomor nota baru
                }
            }

            rsNota.close();
            stNota.close();

            // Sisanya dari kode Anda
            // ...

        } catch (SQLException e) {
            out.print(e);
        } finally {
            // Tutup koneksi di sini
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    out.print(e);
                }
            }
        }
    %>
                <div class="col-sm-9">
                    <div class="row">
                        <h1>Data Pembelian</h1>
                        <table>
                            <tr>
                                <th>No Nota</th>
                                <td>
                                    <div class="form-group row">
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="KdPo" placeholder="Masukkan No Nota"  value="<%= nomorNotaBaru %>" readonly>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>Tgl Nota</th>
                                <td id="TglPo"></td>
                            </tr>
                            <tr>
                                <th>Pilih Customer</th>
                                <td>
                                    <div class="form-group">
                                        <br>
                                        <select class="form-control" id="customer" name="txtsupplier" onchange="getBarangData()">
                                            <option value="Semua">Pilih Customer</option>
                                           <%
                                            try {
                                                dbConnection konek = new dbConnection();
                                                Connection conn = konek.koneksiDB();
                                                Statement st = conn.createStatement();
                                                ResultSet rs = st.executeQuery("SELECT Nama FROM customer"); // tambahkan kolom HargaJual
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
                                </td>
                            </tr>
                            <tr>
                                <th>Pilih Barang</th>
                                <td>
                                    <div class="form-group">
                                        <br>
                                        <select class="form-control" id="barang" name="txtbarang" onchange="getBarangData()">
                                            <option value="Semua">Pilih Barang</option> 
                                            <%
                                              try {
                                                dbConnection konek = new dbConnection();
                                                Connection conn = konek.koneksiDB();
                                                Statement st = conn.createStatement();
                                                ResultSet rs = st.executeQuery("SELECT barang.nama_barang, barang.harga, stok.sisastok FROM barang JOIN stok ON barang.kd_barang = stok.kd_barang");
                                                while (rs.next()) {  
                                            %>
                                              <option value="<%= rs.getString("nama_barang") %>" 
                                                      data-harga="<%= rs.getInt("harga") %>"
                                                      data-stok="<%= rs.getInt("sisastok") %>">
                                                <%= rs.getString("nama_barang") %>
                                              </option>
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
                                </td>
                            </tr>
                            <tr>
                                <th>Jumlah Beli</th>
                                <td>
                                    <div class="form-group row">
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="jumlahBeli" placeholder="Masukkan Jumlah Barang">
                                        </div>
                                        <div class="col-sm-4">
                                            <button type="button" id="btnTambah" onclick="tambahBarang()">Input</button>
                                        </div>
                                    </div>
                                </td>
                            </tr>
<!--                            <tr>
                                <th>Total Bayar</th>
                                <td class="total">Rp 0,-</td>
                            </tr>-->
                        </table>
                            <!-- Tabel untuk menampilkan data barang -->
                            <h2>Data Barang</h2>
                            <table>
                                <thead>
                                    <tr>
<!--                                        <th>No Nota</th>-->
                                        <th>Nama Barang</th>
                                        <th>Sisa Stok</th>
                                        <th>Harga </th>
                                        <th>Jumlah Beli</th>
                                        <th>Total Bayaran</th>
<!--                                        <th>Nama Supplier</th>-->
                                        <th>Opsi</th>
                                    </tr>
                                </thead>
                                <tbody id="barangTableBody">
                                </tbody>
                            </table>
<!--                             Tombol Tambah 
                            <button type="button" id="btnTambah">Tambah</button>-->
                            <br> <!-- Tambahkan tag <br> di sini untuk menambahkan spasi -->
                            <!-- Daftar Barang -->
<h2>Daftar Barang</h2>
<table>
    <thead>
        <tr>
            <th>No</th>
            <th>No Po</th>
            <th>Tanggal Po</th>
            <th>Kode Barang</th>
            <th>Nama Barang</th>
            <th>Sisa Stok</th>
            <th>Harga </th>
            <th>Jumlah Beli</th>
            <th>Total Bayaran</th>
            <th>Nama Customer</th>
            <th>Opsi</th> <!-- Tambahkan kolom opsi -->
        </tr>
    </thead>
    <tbody id="barangTableBody">
        <!-- Isi tabel -->
        <%
        try {
            dbConnection konek = new dbConnection();
            Connection conn = konek.koneksiDB();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM po");
            int counter = 1;
            while (rs.next()) {
                String KdPo = rs.getString("KdPo");
                String TglPo = rs.getString("TglPo");
                String Kd_Barang = rs.getString("Kd_Barang");
                String Nama_Barang = rs.getString("Nama_Barang");
                String SisaStok = rs.getString("SisaStok");
                String Harga = rs.getString("Harga");
                String JumlahBeli = rs.getString("JumlahBeli");
                String Total = rs.getString("Total");
                String Nama = rs.getString("Nama");
        %>
                <tr>
                    <td><%= counter %></td>
                    <td><%= KdPo %></td>
                    <td><%= TglPo %></td>
                    <td><%= Kd_Barang %></td>
                    <td><%= Nama_Barang %></td>
                    <td><%= SisaStok %></td>
                    <td><%= Harga %></td>
                    <td><%= JumlahBeli %></td>
                    <td><%= Total %></td>
                    <td><%= Nama %></td>
                    <td>
                        <a href="#deleteEmployeeModal" class="delete btn btn-danger" value="hapus" data-toggle="modal" data-kdpo="<%= rs.getString("KdPo") %>">
                        <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i>
                        </a>
                    </td>
                </tr>
        <%
                counter++;
            }
            rs.close();
            st.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Terjadi kesalahan: " + e.getMessage());
        }
        %>
    </tbody>
</table>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div id="deleteEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form method="post" action="ctrpo.jsp">
                    <div class="modal-header">
                        <h4 class="modal-title">Hapus Data Barang</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p>Anda yakin ingin menghapus data ini?</p>
                        <p class="text-warning"><small>Ini akan menghapus data secara permanen.</small></p>
                        <input type="hidden" name="txtKdPo" id="delete-kdpo">
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-default" data-dismiss="modal" value="Batal" name="cmdsubmit">
                        <input type="submit" class="btn btn-danger" value="hapus" name="cmdsubmit">
                    </div>
                </form>
            </div>
        </div>
    </div>
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
    document.addEventListener("DOMContentLoaded", function () {
        // Memanggil fungsi updateTanggal setiap 1000 milidetik (1 detik)
        setInterval(updateTanggal, 100);
        
        // ... kode lainnya ...
    });

    function updateTanggal() {
        // Mengambil elemen dengan id "tglNota"
        var tglNotaElement = document.getElementById("TglPo");

        // Mendapatkan tanggal saat ini
        var currentDate = new Date();
        
        // Format tanggal (DD/MM/YYYY)
        var formattedDate = currentDate.toLocaleDateString('id-ID');

        // Menampilkan tanggal pada elemen
        tglNotaElement.textContent = formattedDate;
    }
</script>
<script>
    function tambahBarang() {
        var selectedBarang = document.getElementById("barang");
        var selectedCustomer = document.getElementById("customer");
        var selectedOption = selectedBarang.options[selectedBarang.selectedIndex];
        var selectedOption1 = selectedCustomer.options[selectedCustomer.selectedIndex];
        var KdPo = document.getElementById("KdPo").value;
        var sisaStok = parseInt(selectedOption.getAttribute("data-stok"));
         var jumlahBeli = parseInt(document.getElementById("jumlahBeli").value);

        // Lakukan validasi untuk memastikan input valid
        if (selectedBarang.value === "Nama_Barang" || selectedCustomer.value === "Nama" || KdPo === "" ||  isNaN(jumlahBeli) || jumlahBeli <= 0) {
            alert("Pilih barang dan masukkan jumlah beli terlebih dahulu.");
            return;
        }

        // Ambil nama barang dan harga jual dari data yang tersimpan di dropdown
        var namaBarang = selectedOption.text;
        var harga = selectedOption.getAttribute("data-harga");
//        var sisaStok = selectedOption.getAttribute("data-stok");
        var namaCustomer = selectedOption1.text;

        // Hitung total bayaran
        var totalBayaran = harga * jumlahBeli;
        
        // Perbarui sisa stok
        var newSisaStok = sisaStok - jumlahBeli;
        
        // Perbarui tampilan HTML yang menampilkan sisa stok
        selectedOption.setAttribute("data-stok", newSisaStok);
        selectedOption.text = namaBarang + " (Sisa Stok: " + newSisaStok + ")";

        // Tambahkan data barang ke dalam tabel
        var tableBody = document.getElementById("barangTableBody");
        var newRow = tableBody.insertRow(tableBody.rows.length);
        var cell1 = newRow.insertCell(0);
        var cell2 = newRow.insertCell(1);
        var cell3 = newRow.insertCell(2);
        var cell4 = newRow.insertCell(3);
        var cell5 = newRow.insertCell(4);
        var cell6 = newRow.insertCell(5);
//        var cell7 = newRow.insertCell(6);
//        var cell8 = newRow.insertCell(7);

        // Tambahkan input tersembunyi untuk menyimpan nilai namaBarang
        var hiddenInputNama = document.createElement("input");
        hiddenInputNama.type = "hidden";
        hiddenInputNama.name = "txtNama_Barang";
        hiddenInputNama.value = namaBarang;
        newRow.appendChild(hiddenInputNama);
        
        var hiddenInputNoNota = document.createElement("input");
        hiddenInputNoNota.type = "hidden";
        hiddenInputNoNota.name = "txtKdPo";
        hiddenInputNoNota.value = KdPo;
        newRow.appendChild(hiddenInputNoNota);
        
        var hiddenInputSisaStok = document.createElement("input");
        hiddenInputSisaStok.type = "hidden";
        hiddenInputSisaStok.name = "txtSisaStok";
        hiddenInputSisaStok.value = sisaStok;
        newRow.appendChild(hiddenInputSisaStok);
        
        var hiddenInputHargaJual = document.createElement("input");
        hiddenInputHargaJual.type = "hidden";
        hiddenInputHargaJual.name = "txtHarga";
        hiddenInputHargaJual.value = harga;
        newRow.appendChild(hiddenInputHargaJual);
        
        var hiddenInputJumlahBeli = document.createElement("input");
        hiddenInputJumlahBeli.type = "hidden";
        hiddenInputJumlahBeli.name = "txtJumlahBeli";
        hiddenInputJumlahBeli.value = jumlahBeli;
        newRow.appendChild(hiddenInputJumlahBeli);
        
        var hiddenInputTotal = document.createElement("input");
        hiddenInputTotal.type = "hidden";
        hiddenInputTotal.name = "txtTotal";
        hiddenInputTotal.value = totalBayaran;
        newRow.appendChild(hiddenInputTotal);

        // Tambahkan input tersembunyi untuk menyimpan nilai namaSupplier
        var hiddenInputSupplier = document.createElement("input");
        hiddenInputSupplier.type = "hidden";
        hiddenInputSupplier.name = "txtNama";
        hiddenInputSupplier.value = namaCustomer;
        newRow.appendChild(hiddenInputSupplier);

//        cell1.innerHTML = NoNota;
        cell1.innerHTML = namaBarang;
        cell2.innerHTML = newSisaStok;
        cell3.innerHTML = "Rp " + harga + ",-";
        cell4.innerHTML = jumlahBeli;
        cell5.innerHTML = "Rp " + totalBayaran + ",-";
//        cell7.innerHTML = namaSupplier;

        // Tambahkan tombol "Tambah" pada tabel opsi
        var tambahButton = document.createElement("button");
        tambahButton.type = "submit";
        tambahButton.value = "Submit";
        tambahButton.name = "cmdsubmit";
        tambahButton.textContent = "Tambah";
        tambahButton.addEventListener("click", function() {
            // Tambahkan logika tambah data di sini (jika diperlukan)
            alert("Data barang ditambahkan ke pembelian.");
        });

        // Tambahkan tombol "Tambah" ke dalam cell8 (kolom opsi)
        cell6.appendChild(tambahButton);
        
        // Reset nilai input
        selectedBarang.value = "Nama_Barang";
        selectedCustomer.value = "Nama";
        document.getElementById("jumlahBeli").value = "";
        document.getElementById("KdPo").value = "";
    }
</script>
 <script>
        document.addEventListener("DOMContentLoaded", function () {
            var deleteButtons = document.querySelectorAll(".delete");

            for (var i = 0; i < deleteButtons.length; i++) {
                deleteButtons[i].addEventListener("click", function () {
                    var kdpo = this.getAttribute("data-kdpo");
                    $('#delete-kdpo').val(kdpo);
                });
            }
        });
    </script>
</body>
</html>