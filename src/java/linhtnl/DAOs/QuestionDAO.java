/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package linhtnl.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import linh.util.SHA256;

/**
 *
 * @author ASUS
 */
public class QuestionDAO {

    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    SHA256 SHA = new SHA256();
    private final int questionsPerPage = 20;

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
    
}
