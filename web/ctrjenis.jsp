<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="database.dbConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.swing.JOptionPane"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>  
         <% 
    String KdJenis=request.getParameter("txtKdJenis");
    String JenisBarang=request.getParameter("txtJenisBarang");
    String dapat=request.getParameter("cmdadd");
    if(dapat.equals("Add"))
    {
        try
        {
            dbConnection konek = new dbConnection();
            Connection conn = konek.koneksiDB();
            Statement st=conn.createStatement();
            String sql="insert into jenis(KdJenis, JenisBarang) values ('"+KdJenis+"', '"+JenisBarang+"')";
            st.executeUpdate(sql);
            conn.close();
            %>
            <script>
                alert("Data berhasil disimpan");
                window.location = "barang.jsp" ;
                        
            </script>
            <%
        }
        catch(Exception e)
        {
            out.print(e);
        }
    }
%>
    </body>
</html>
