/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package linhtnl.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;
import linh.util.SHA256;
import linhtnl.DTOs.SubjectDTO;
import linhtnl.db.LinhConnection;

/**
 *
 * @author ASUS
 */
public class SubjectDAO {
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
    
    public Vector<SubjectDTO> init()throws Exception{
        Vector<SubjectDTO> result =null;
        try{
            String sql= "select SubID, subName from, tblSubject";
            con=LinhConnection.getConnection();
            pst = con.prepareStatement(sql);
            rs=pst.executeQuery();
            while(rs.next()){
                SubjectDTO dto = new SubjectDTO(rs.getString("SubID"),rs.getString("subName"));
                result.add(dto);
            }
        }finally{
            closeConnection();
        }
        return result;
    }
}
