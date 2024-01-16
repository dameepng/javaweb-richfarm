<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="database.dbConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- ... (your head section) ... -->
</head>

<body>
   <%
    String email = request.getParameter("txtEmail");
    String password = request.getParameter("txtPassword");
    String action = request.getParameter("cmdsubmit");

    // Logika bisnis dipindahkan ke dalam tag Java
    dbConnection konek = new dbConnection();

    // Proses pendaftaran pengguna dari form
    if ("Daftar".equals(action)) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = konek.koneksiDB();

            // Query untuk menambahkan pengguna baru ke tabel 'users'
            String query = "INSERT INTO users (email, password) VALUES (?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            pstmt.executeUpdate();

            // Redirect setelah pendaftaran berhasil
            response.sendRedirect("login.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Proses login pengguna dari form
    if ("Login".equals(action)) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = konek.koneksiDB();

            // Query untuk memeriksa pengguna dengan email dan password tertentu
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            // Redirect ke halaman dashboard jika login berhasil
            if (rs.next()) {
                response.sendRedirect("barang.jsp");
            } else {
                // Redirect kembali ke halaman login jika login gagal
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>
</body>
</html>
