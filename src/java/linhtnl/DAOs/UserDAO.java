/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package linhtnl.DAOs;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import linh.util.SHA256;
import linhtnl.DTOs.UserDTO;
import linhtnl.db.LinhConnection;

/**
 *
 * @author ASUS
 */
public class UserDAO implements Serializable {

    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    SHA256 SHA = new SHA256();

    private void closeConnection() throws Exception {
        if (rs != null) {
            rs.close();
        }
        if (pst != null) {
            pst.close();
        }
        if (con != null) {
            con.close();
        }
    }

    public UserDTO checkLogin(String email, String password) throws Exception {
        UserDTO dto = new UserDTO(email);
        try {
            String sql = "Select role, username from tblUser where UserID = ? and password = ? ";          
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, SHA.toHexString(SHA.getSHA(password)));
            rs = pst.executeQuery();
            System.out.println(pst);
            if (rs.next()) {
                dto.setRole(rs.getString("role"));
                dto.setUsername(rs.getString("username"));
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public boolean isExist(String email) throws Exception {
        boolean check = false;
        try {
            String sql = "Select * from tblUser where UserID='" + email + "'";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            if(rs.next()){
                check=true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean createNewAccount(UserDTO dto) throws Exception {
        int count = 0;
        try {

            String sql = "INSERT tblUser values('" + dto.getEmail() + "','" + SHA.toHexString(SHA.getSHA(dto.getPassword())) + "','" + dto.getUsername() + "',1,'Student')";
            con = LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            count += pst.executeUpdate();
        } finally {
            closeConnection();
        }
        return count > 0;
    }
}
