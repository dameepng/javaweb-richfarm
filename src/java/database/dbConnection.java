/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class dbConnection {        
   private Connection conn;
    
   public Connection koneksiDB() {
      if(this.conn==null) {
         try{  
            Class.forName("com.mysql.jdbc.Driver");  
            String vDriver = "jdbc:mysql://localhost:3306/richfarm_db";
            this.conn=DriverManager.getConnection(vDriver,"root","");  
//           JOptionPane.showMessageDialog(null, "Koneksi sukses");
         }catch(ClassNotFoundException e){ 
            System.out.println(e);} catch (SQLException e) {  
            JOptionPane.showMessageDialog(null, "Koneksi Gagal");                 
         }  
      }  
      return conn;
    }  
    
    public static void main(String[] args){
        dbConnection db = new dbConnection();
        Connection con = db.koneksiDB();                
    }
}
